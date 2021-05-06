import ../docentry, ../docentry_io
import hnimast/compiler_aux
import hmisc/hdebug_misc
import std/[strutils, strformat, tables, streams, sequtils, with]
import packages/docutils/[rst]
import hnimast
import hmisc/helpers
import hmisc/other/[oswrap, colorlogger]
import hmisc/algo/[hstring_algo, halgorithm]
import compiler/sighashes
import haxorg/[semorg, ast, importer_nim_rst]

proc headSym(node: PNode): PSym =
  case node.kind:
    of nkProcDeclKinds, nkDistinctTy, nkVarTy,
       nkBracketExpr, nkTypeDef, nkPragmaExpr:
      headSym(node[0])

    of nkCommand, nkCall:
      headSym(node[1])

    of nkSym:
      node.sym

    of nkRefTy, nkPtrTy:
      if node.len == 0:
        nil

      else:
        headSym(node[0])

    of nkIdent, nkEnumTy, nkProcTy, nkObjectTy, nkTupleTy:
      nil

    else:
      raiseImplementKindError(node, node.treeRepr())

proc typeHead(node: PNode): PNode =
  case node.kind:
    of nkSym: node
    of nkTypeDef: typeHead(node[0])
    of nkPragmaExpr: typeHead(node[0])
    else:
      raiseImplementKindError(node)

proc declHead(node: PNode): PNode =
  case node.kind:
    of nkRecCase, nkIdentDefs, nkProcDeclKinds, nkPragmaExpr,
       nkVarTy, nkBracketExpr, nkPrefix,
       nkDistinctTy, nkBracket:
      result = declHead(node[0])

    of nkRefTy, nkPtrTy:
      if node.len > 0:
        result = declHead(node[0])

      else:
        result = node

    of nkSym, nkIdent, nkEnumFieldDef, nkDotExpr,
       nkExprColonExpr, nkCall,
       nkRange, # WARNING
       nkEnumTy,
       nkProcTy,
       nkIteratorTy,
       nkTupleClassTy,
       nkLiteralKinds:
      result = node

    of nkPostfix, nkCommand:
      result = node[1]

    of nkInfix, nkPar:
      result = node[0]

    of nkTypeDef:
      let head = typeHead(node)
      doAssert head.kind == nkSym, head.treeRepr()
      result = head

    of nkObjectTy:
      result = node

    else:
      raiseImplementKindError(node, node.treeRepr())



type
  DocContext = ref object of PPassContext
    db: DocDb
    graph: ModuleGraph
    allModules: seq[DocEntry]
    module: DocEntry
    sigmap: TableRef[SigHash, DocId]

  RegisterStateKind = enum
    rskTopLevel
    rskInheritList
    rskPragma
    rskObjectFields ## Object field groups
    rskObjectBranch ## Object branch or switch expression
    rskEnumFields ## Enum field groups

    rskProcHeader
    rskProcArgs
    rskProcReturn
    rskBracketHead
    rskBracketArgs
    rskTypeHeader
    rskAliasHeader
    rskEnumHeader

    rskDefineCheck


  RegisterState = object
    state: seq[RegisterStateKind]
    switchId: DocId

using
  ctx: DocContext
  node: PNode

proc `+`(state: RegisterState, kind: RegisterStateKind): RegisterState =
  result = state
  result.state.add kind

proc `+=`(state: var RegisterState, kind: RegisterStateKind) =
  state.state.add kind


proc top(state: RegisterState): RegisterStateKind =
  return state.state[^1]

proc initRegisterState(): RegisterState =
  RegisterState(state: @[rskToplevel])

proc toDocPos(info: TLineInfo): DocPos =
  DocPos(line: info.line.int, column: info.col.int)

proc startPos(node): DocPos =
  case node.kind:
    of nkTokenKinds:
      result = toDocPos(node.getInfo())

    else:
      result = node[0].startPos()

proc finishPos(node): DocPos =
  case node.kind:
    of nkTokenKinds:
      result = toDocPos(node.getInfo())
      result.column += len($node) - 1

    else:
      if len(node) > 0:
        var idx = len(node) - 1
        while idx >= 0 and node[idx].kind in {nkEmpty}:
          dec idx

        if idx >= 0:
          result = node[idx].finishPos()

        else:
          result = toDocPos(node.getInfo())

      else:
        result = toDocPos(node.getInfo())

proc nodeExtent(node): DocExtent =
  result.start = startPos(node)
  result.finish = finishPos(node)

proc setLocation(ctx; entry: DocEntry, node) =
  entry.setLocation DocLocation(
    pos: node.getInfo().toDocPos(),
    absFile: AbsFile($ctx.graph.getFilePath(node))
  )

  entry.extent = some nodeExtent(node)
  entry.declHeadExtent = some nodeExtent(node.declHead())

proc nodeSlice(node: PNode): DocCodeSlice =
  let l = len($node)
  if l > 20 and not validIdentifier($node):
    warn node, "has len > 20", l

  initDocSlice(
    node.getInfo().line.int,
    node.getInfo().col.int,
    node.getInfo().col.int + l - 1
  )

proc isEnum*(node): bool =
  case node.kind:
    of nkEnumTy:
      true

    of nkTypeDef:
      node[2].isEnum()

    else:
      false

proc isAliasDecl*(node): bool =
  case node.kind:
    of nkObjectTy, nkEnumTy:
      false

    of nkPtrTy, nkRefTy:
      isAliasDecl(node[0])

    of nkTypeDef:
      isAliasDecl(node[2])

    else:
      true

proc trySigHash*(sym: PSym): SigHash =
  if not isNil(sym):
    try:
      result = sym.sigHash()

    except IndexDefect as e:
      err e.msg
      discard

proc addSigmap(ctx; node; entry: DocEntry) =
  try:
    let hash = node.headSym().sigHash()
    ctx.sigmap[hash] = entry.id()


  except IndexDefect as e:
    err e.msg
    discard

proc sigHash(t: NType): SigHash =
  result = t.declNode.get().headSym().trySigHash()

proc sigHash(t: PNode): SigHash =
  result = t.headSym().trySigHash()

proc sigHash(t: PSym): SigHash =
  result = t.trySigHash()

proc `[]`(ctx; ntype: NType | PNode | PSym): DocId =
  let hash = ntype.sigHash()
  if hash in ctx.sigmap:
    return ctx.sigmap[hash]

proc occur(ctx; node: PNode, kind: DocOccurKind) =
  var occur: DocOccur
  if kind == dokLocalUse:
    raiseImplementError("")

  else:
    occur = DocOccur(kind: kind)
    occur.refid = ctx[node]

  let file = AbsFile($ctx.graph.getFilePath(node))
  ctx.db.newOccur(node.nodeSlice(), file, occur)

proc occur(ctx; node; id: DocId, kind: DocOccurKind) =
  var occur = DocOccur(kind: kind)
  occur.refid = id
  ctx.db.newOccur(
    node.nodeSlice(),
    AbsFile($ctx.graph.getFilePath(node)), occur)

proc occur(ctx; node; localId: string) =
  ctx.db.newOccur(
    node.nodeSlice(),
    ctx.graph.getFilePath(node).string.AbsFile(),
    DocOccur(kind: dokLocalUse, localId: localId)
  )

proc registerUses(ctx; node; state: RegisterState) =
  case node.kind:
    of nkSym:
      case node.sym.kind:
        of skType:
          let useKind =
            case state.top():
              of rskTopLevel, rskPragma:           dokTypeDirectUse
              of rskObjectFields, rskObjectBranch: dokTypeAsFieldUse
              of rskProcArgs, rskProcHeader:       dokTypeAsArgUse

              of rskInheritList: dokInheritFrom
              of rskProcReturn:  dokTypeAsReturnUse
              of rskBracketHead: dokTypeSpecializationUse
              of rskBracketArgs: dokTypeAsParameterUse
              of rskTypeHeader:  dokObjectDeclare
              of rskEnumHeader:  dokEnumDeclare
              of rskAliasHeader: dokAliasDeclare
              else:
                raiseImplementKindError(state.top())

          ctx.occur(node, useKind)

        of skEnumField:
          if state.top() == rskEnumFields:
            ctx.occur(node, dokEnumFieldDeclare)

          else:
            ctx.occur(node, dokEnumFieldUse)

        of skField:
          # QUESTION these two field usage kinds should be different (like
          # `field use` and `enum constant use`?)
          if state.top() in {rskObjectBranch, rskObjectFields}:
            ctx.occur(node, dokFieldDeclare)

          else:
            ctx.occur(node, dokFieldUse)


        of skProc, skTemplate, skMethod, skMacro, skIterator, skConverter:
          if state.top() == rskProcHeader:
            ctx.occur(node, dokCallDeclare)

          else:
            ctx.occur(node, dokCall)

        of skParam, skVar, skConst, skLet, skForVar:
          ctx.occur(node, $node.headSym())

        of skResult:
          # IDEA can be used to collect information about `result` vs
          # `return` uses
          discard

        of skLabel:
          discard # ???

        else:
          info ctx.graph.getFilePath(node)
          raiseImplementError(node.treeRepr())

    of nkIdent:
      # TODO without better context information it is not possible what
      # kind of usage particular identifier represents, so discarding for
      # now.
      if state.switchId.isValid():
        let sub = ctx.db[state.switchId].getSub($node)
        if sub.isValid():
          ctx.occur(node, sub, dokEnumFieldUse)

      elif state.top() == rskDefineCheck:
        let def = ctx.db.getOrNew(dekCompileDefine, $node)
        ctx.occur(node, def.id(), dokDefineCheck)

      elif state.top() == rskPragma:
        let def = ctx.db.getOrNew(dekPragma, $node)
        ctx.occur(node, def.id(), dokAnnotationUsage)


    of nkCommentStmt, nkEmpty, hnimast.nkStrKinds, nkFloatKinds, nkNilLit:
      discard

    of nkIntKinds:
      if notNil(node.typ) and
         notNil(node.typ.sym) and
         notNil(node.typ.sym.ast):

        let parent = ctx[node.typ.sym]
        if node.typ.sym.ast.isEnum():
          if parent.isValid():
            let sub = ctx.db[parent].getSub($node)
            ctx.occur(node, sub, dokEnumFieldUse)


    of nkPragmaExpr:
      ctx.registerUses(node[0], state)
      ctx.registerUses(node[1], state + rskPragma)

    of nkConstSection, nkVarSection, nkLetSection:
      # TODO register local type definitino
      for decl in node:
        ctx.registerUses(decl[1], state) # Type usage
        ctx.registerUses(decl[2], state) # Init expression

    of nkIncludeStmt, nkImportStmt:
      # TODO extract target path from compiler and generate
      # `dekImport/dekInclude` dependency
      discard

    of nkExportStmt:
      # QUESTION not really sure what `export` should be mapped to, so
      # discarding for now.
      discard

    of nkGenericParams:
      # TODO create context with generic parameters declared in
      # procedure/type header and use them to create list of local symbols.
      discard

    of nkPragma:
      # TODO implement for pragma uses
      for subnode in node:
        ctx.registerUses(subnode, state + rskPragma)

    of nkAsmStmt:
      # IDEA possible analysis of passthrough code?
      discard

    of nkCall:
      if "defined" in $node:
        ctx.registerUses(node[1], state + rskDefineCheck)

      else:
        for subnode in node:
          ctx.registerUses(subnode, state)

    of nkProcDeclKinds:
      for idx in 0 .. (len(node) - 2):
        case idx:
          of 3:
            ctx.registerUses(node[idx][0], state + rskProcReturn)
            for n in node[idx][1 ..^ 1]:
              ctx.registerUses(n, state + rskProcArgs)

          else:
            ctx.registerUses(node[idx], state + rskProcHeader)

      ctx.registeruses(node[^1], state)

    of nkBracketExpr:
      ctx.registerUses(node[0], state + rskBracketHead)
      for subnode in node[1..^1]:
        ctx.registerUses(subnode, state + rskBracketArgs)

    of nkRecCase:
      var state = state
      state.switchId = ctx[node[0][1]]
      ctx.registerUses(node[0], state + rskObjectBranch)
      for branch in node[1 .. ^1]:
        for expr in branch[0 .. ^2]:
          ctx.registerUses(expr, state + rskObjectBranch)

        ctx.registerUses(branch[^1], state + rskObjectFields)

    of nkRaiseStmt:
      # TODO get type of the raised expression and if it is a concrete type
      # record `dokRaised` usage.
      for subnode in node:
        ctx.registerUses(subnode, state)

    of nkOfInherit:
      ctx.registerUses(node[0], state + rskInheritList)

    of nkOpenSymChoice:
      # QUESTION I have no idea what multiple symbol choices mean *after*
      # semcheck happened, so discarding for now.
      discard

    of nkTypeDef:
      let decl =
        if node.isAliasDecl(): rskAliasHeader
        elif node.isEnum():    rskEnumHeader
        else:                  rskTypeHeader

      ctx.registerUses(node[0], state + decl)
      ctx.registerUses(node[1], state + decl)


      ctx.registerUses(node[2], state)

    of nkDistinctTy:
      ctx.registerUses(node[0], state)

    else:
      var state = state
      case node.kind:
        of nkEnumTy:
          state += rskEnumFields

        of nkObjectTy, nkRecList:
          state += rskObjectFields

        else:
          discard

      for subnode in node:
        ctx.registerUses(subnode, state)



proc toDocType(ctx; ntype: NType): DocType =
  case ntype.kind:
    of ntkIdent:
      if ntype.declNode.get().kind == nkIdent:
        result = DocType(
          name: ntype.head,
          kind: dtkGenericParam,
          paramName: $ntype.declNode.get())

      else:
        result = DocType(
          name: ntype.head,
          kind: dtkIdent, head: ctx[ntype])

      for param in ntype.genParams:
        result.genParams.add ctx.toDocType(param)

    of ntkAnonTuple:
      result = DocType(kind: dtkAnonTuple)
      for param in ntype.genParams:
        result.genParams.add ctx.toDocType(param)

    of ntkGenericSpec:
      result = DocType(kind: dtkGenericSpec)
      for param in ntype.genParams:
        result.genParams.add ctx.toDocType(param)

    of ntkRange:
      result = DocType(
        kind: dtkRange, rngStart: $ntype.rngStart,
        rngEnd: $ntype.rngEnd)

    of ntkVarargs:
      result = DocType(
        kind: dtkVarargs,
        vaType: ctx.toDocType(ntype.vaType()))

      if ntype.vaConverter.isSome():
        result.vaConverter = some $ntype.vaConverter.get()

    of ntkNamedTuple, ntkProc:
      if ntype.kind == ntkNamedTuple:
        result = DocType(kind: dtkNamedTuple)

      else:
        result = DocType(kind: dtkProc)

      for arg in ntype.arguments:
        let t = ctx.toDocType(arg.vtype)
        for ident in arg.idents:
          result.arguments.add DocIdent(
            ident: $ident, identType: t)

    of ntkNone:
      result = DocType(kind: dtkNone)

    of ntkValue:
      result = DocType(kind: dtkValue, value: $ntype.value)

    of ntkTypeofExpr:
      result = DocType(kind: dtkTypeofExpr, value: $ntype.value)

    else:
      raiseImplementKindError(ntype, $ntype)

proc classifiyKind(decl: PProcDecl): DocEntryKind =
  case decl.declNode.get().kind:
    of nkProcDef: dekProc
    of nkTemplateDef: dekTemplate
    of nkMacroDef: dekMacro
    of nkMethodDef: dekMethod
    of nkIteratorDef: dekIterator
    of nkFuncDef: dekFunc
    else:
      raiseImplementKindError(decl.declNode.get())

proc classifyKind(ctx; decl: PObjectDecl): DocEntryKind =
  result = dekObject
  case decl.name.head:
    of "CatchableError": result = dekException
    of "Defect": result = dekDefect
    of "RootEffect": result = dekEffect
    elif decl.base.isSome():
      let baseId = ctx[decl.base.get()]
      if baseId in ctx.db:
        result = ctx.db[baseId].kind

proc classifyKind(nt: NType, asAlias: bool): DocEntryKind =
  if asAlias:
    if nt.kind != ntkGenericSpec:
      return dekAlias

    else:
      return dekTypeclass

  case nt.kind:
    else:
      raiseImplementKindError(nt)

proc convertComment(ctx: DocContext, text: string; node: PNode): SemOrg =
  let file = AbsFile($ctx.graph.getFilePath(node))
  try:
    let org = text.strip().parseRstString(file).toOrgNode()
    return toSemOrg(org)

  except EParseError as e:
    err e.msg
    return onkRawText.newTree(e.msg).toSemOrg()


proc registerProcDef(ctx: DocContext, procDef: PNode) =
  let procDecl = parseProc(procDef)

  var entry = ctx.module.newDocEntry(
    procDecl.classifiyKind(), procDecl.name)
  ctx.addSigmap(procDef, entry)
  ctx.setLocation(entry, procDef)
  entry.rawDoc.add procDecl.docComment
  entry.docBody = ctx.convertComment(procDecl.docComment, procDef)

  for argument in arguments(procDecl):
    let argType = ctx.toDocType(argument.vtype)
    for ident in argument.idents:
      entry.lastIdentPart.argTypes.add argType
      var arg = entry.newDocEntry(dekArg, ident.getStrVal())
      arg.identType = some argType
      arg.identTypeStr = some $argument.vtype
      ctx.setLocation(arg, ident)

  let procType = ctx.toDocType(procDecl.signature)


proc registerTypeDef(ctx; node) =
  if isObjectDecl(node):
    let objectDecl: PObjectDecl = parseObject(node)
    var entry = ctx.module.newDocEntry(
      ctx.classifyKind(objectDecl), objectDecl.name.head)

    if objectDecl.base.isSome():
      entry.superTypes.add ctx[objectDecl.base.get()]

    ctx.setLocation(entry, node)
    ctx.addSigmap(node, entry)
    entry.rawDoc.add objectDecl.docComment
    entry.docBody = ctx.convertComment(objectDecl.docComment, node)

    for param in objectDecl.name.genParams:
      var p = entry.newDocEntry(dekParam, param.head)

    for nimField in iterateFields(objectDecl):
      var field = entry.newDocEntry(dekField, nimField.name)
      field.rawDoc.add nimField.docComment

      with field:
        docBody = ctx.convertComment(
          nimField.docComment, nimField.declNode.get())

        identType = some ctx.toDocType(nimField.fldType)
        identTypeStr = some $nimField.fldType

      ctx.setLocation(field, nimField.declNode.get())

  elif node[2].kind == nkEnumTy:
    let enumDecl: PEnumDecl = parseEnum(node)
    var entry = ctx.module.newDocEntry(dekEnum, enumDecl.name)
    ctx.setLocation(entry, node)
    ctx.addSigmap(node, entry)

    for enField in enumDecl.values:
      var field = entry.newDocEntry(dekEnumField, enField.name)
      ctx.setLocation(field, enField.declNode.get())

  elif node[2].kind in {
      nkDistinctTy, nkSym, nkPtrTy, nkRefTy, nkProcTy, nkTupleTy,
      nkBracketExpr, nkInfix, nkVarTy
    }:

    let baseNType = parseNType(node[2])
    let baseType = ctx.toDocType(baseNType)

    let kind =
      if node[2].kind == nkDistinctTy:
        dekDistinctAlias
      else:
        classifyKind(baseNType, true)

    var entry = ctx.module.newDocEntry(kind, $node.declHead())
    ctx.setLocation(entry, node)
    ctx.addSigmap(node, entry)
    entry.baseType = baseType

    for param in parseNType(node[0]).genParams:
      var p = entry.newDocEntry(dekParam, param.head)


  elif node[0].kind in {nkPragmaExpr}:
    var entry = ctx.module.newDocEntry(dekBuiltin, $node[0][0])
    ctx.setLocation(entry, node)
    ctx.addSigmap(node, entry)

  elif node[2].kind in {nkCall}:
    # `Type = typeof(expr())`
    discard

  elif node[2].kind in {nkTypeClassTy}:
    # IMPLEMENT concept indexing
    discard

  else:
    warn node[2].kind
    debug node
    debug treeRepr(node)


proc registerToplevel(ctx: DocContext, node: PNode) =
  case node.kind:
    of nkProcDeclKinds:
      ctx.registerProcDef(node)

    of nkTypeSection:
      for typeDecl in node:
        registerToplevel(ctx, typeDecl)

    of nkTypeDef:
      ctx.registerTypeDef(node)

    of nkStmtList:
      for subnode in node:
        registerTopLevel(ctx, subnode)

    of nkEmpty, nkCommentStmt, nkIncludeStmt, nkImportStmt,
       nkPragma, nkExportStmt:
      discard

    else:
      discard

  ctx.registerUses(node, initRegisterState())


proc generateDocDb*(
    file: AbsFile,
    stdpath: AbsDir,
    otherPaths: seq[AbsDir],
  ): DocDb =

  info "input file:", file
  if exists(stdpath):
    info "stdpath:", stdpath
  else:
    err "Could not find stdlib at ", stdpath
    debug "Either explicitly specify library path via `--stdpath`"
    debug "Or run trail analysis with choosenim toolchain for correct version"

  var db {.global.}: DocDb
  db = newDocDb()
  db.addKnownLib(AbsDir(($stdPath).dropSuffix("lib")), "std")

  var sigmap {.global.}: TableRef[SigHash, DocId]

  sigmap = newTable[SigHash, DocId]()

  var graph {.global.}: ModuleGraph
  graph = newModuleGraph(file, stdpath,
    proc(config: ConfigRef; info: TLineInfo; msg: string; level: Severity) =
      if config.errorCounter >= config.errorMax:
        err msg
        err info, config.getFilePath(info)
  )

  registerPass(graph, semPass)
  registerPass(
    graph, makePass(
      (
        proc(graph: ModuleGraph, module: PSym): PPassContext {.nimcall.} =
          var context = DocContext(db: db, graph: graph, sigmap: sigmap)
          context.module = db.newDocEntry(dekModule, module.getStrVal())
          context.allModules.add context.module
          return context
      ),
      (
        proc(c: PPassContext, n: PNode): PNode {.nimcall.} =
          result = n
          var ctx = DocContext(c)
          registerToplevel(ctx, n)
      ),
      (
        proc(graph: ModuleGraph; p: PPassContext, n: PNode): PNode {.nimcall.} =
          discard
      )
    )
  )

  logIndented:
    compileProject(graph)

  return db

proc main() =
  let dir = getTempDir() / "from_nim_code2"
  # rmDir dir
  mkDir dir
  let file = dir /. "a.nim"
  file.writeFile("""
type
  MalTypeKind* = enum Nil, True, False, Number, Symbol, String,
    List, Vector, HashMap, Fun, MalFun, Atom

type
  FunType = proc(a: varargs[MalType]): MalType

  MalFunType* = ref object
    fn*:       FunType
    ast*:      MalType
    params*:   MalType
    is_macro*: bool

  MalType* = ref object
    case kind*: MalTypeKind
    of Nil, True, False: nil
    of Number:           number*:   int
    of String, Symbol:   str*:      string
    of List, Vector:     list*:     seq[MalType]
    of HashMap:          hash_map*: int
    of Fun:
                         fun*:      FunType
                         is_macro*: bool
    of MalFun:           malfun*:   MalFunType
    of Atom:             val*:      MalType

    meta*: MalType

type
  Base = ref object of RootObj

  A = ref object of Base
    b: B

  B = ref object of Base
    a: A
""")



  let stdpath = getStdPath()


  startColorLogger()
  startHax()

  let db = generateDocDb(file, getStdPath(), @[])

  block:
    var writer = newXmlWriter(dir /. "compile-db.hxde")
    writer.writeXml(db, "main")
    writer.close()

  for file in db.files:
    let outFile = dir /. file.path.withExt("hxda").splitFile2().file
    var writer = newXmlWriter(outFile)
    writer.writeXml(file, "file")
    writer.close()

  for file in walkDir(dir, AbsFile, exts = @["hxda"]):
    var inFile: DocFile
    var reader = newHXmlParser(file)
    reader.loadXml(inFile, "file")

  for file in walkDir(dir, AbsFile, exts = @["hxde"]):
    info "Loading DB", file
    var inDb: DocDb
    block:
      var reader = newHXmlParser(file)
      reader.loadXml(inDb, "main")

    block:
      var writer = newXmlWriter(file.withExt("xml"))
      writer.writeXml(inDb, "file")

  echo "done"

when isMainModule:
  main()
