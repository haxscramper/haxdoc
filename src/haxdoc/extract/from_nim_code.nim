import ../docentry, ../docentry_io
import hnimast/compiler_aux
import hmisc/hdebug_misc
import std/[strutils, strformat, tables, streams, sequtils]
import packages/docutils/[rst]
import hnimast
import hmisc/helpers
import hmisc/other/[oswrap, colorlogger]
import hmisc/algo/[hstring_algo, halgorithm]
import compiler/sighashes
import haxorg/[semorg, ast, importer_nim_rst]


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

proc nodeSlice(node: PNode): DocCodeSlice =
  let l = len($node)
  if l > 20 and not validIdentifier($node):
    warn node, "has len > 20", l

  initDocSlice(
    node.getInfo().line.int - 1, # Lines are indexed, not numbered
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

proc headSym(node): PSym =
  case node.kind:
    of nkProcDeclKinds, nkDistinctTy, nkVarTy, nkRefTy, nkPtrTy,
       nkBracketExpr, nkTypeDef, nkPragmaExpr:
      headSym(node[0])

    of nkCommand, nkCall:
      headSym(node[1])

    of nkSym:
      node.sym

    of nkIdent:
      nil

    else:
      raiseImplementKindError(node, node.treeRepr())

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

proc registerUses(ctx; node; state: RegisterState) =
  case node.kind:
    of nkSym:
      case node.sym.kind:
        of skType:
          case state.top():
            of rskTopLevel, rskPragma:
              ctx.occur(node, dokTypeDirectUse)

            of rskObjectFields, rskObjectBranch:
              ctx.occur(node, dokTypeAsFieldUse)

            of rskInheritList:
              ctx.occur(node, dokInheritFrom)

            of rskProcArgs, rskProcHeader:
              ctx.occur(node, dokTypeAsArgUse)

            of rskProcReturn:
              ctx.occur(node, dokTypeAsReturnUse)

            of rskBracketHead:
              ctx.occur(node, dokTypeSpecializationUse)

            of rskBracketArgs:
              ctx.occur(node, dokTypeAsParameterUse)

            else:
              raiseImplementKindError(state.top())

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
          # TODO local usage declaration
          discard

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

    of nkTypeSection,
       nkEnumTy, nkEnumFieldDef,

       # function calls and similar uses
       nkInfix, nkCommand, nkDotExpr, nkCast, nkConv, nkPrefix,
       nkFormalParams, nkIdentDefs,

       # Process all subnodes, no additional context required
       nkStmtList, nkStmtListExpr, nkPar, nkIfExpr, nkElifBranch,
       nkWhenStmt, nkElse, nkForStmt, nkWhileStmt, nkIfStmt, nkPragmaBlock,
       nkDerefExpr,

       # QUESTION should hidden nodes be ignored?
       nkHiddenStdConv, nkHiddenDeref, nkHiddenAddr, nkHiddenSubConv,

       nkTryStmt, nkFinally, nkExceptBranch, # Can create different context
                                             # for exception usage
       nkTupleTy, # Tracking particular uses of a tuple is most likely
                  # won't work, but this is another possible implementation
                  # IDEA

       nkPtrTy, nkRefTy, nkVarTy, # IDEA possible context information about
                                  # `ptr/ref` being used on a type.
       nkBracket,
       nkObjectTy, nkRecWhen,
       nkPostfix, nkObjConstr, nkTupleConstr,
       nkExprColonExpr,
       nkExprEqExpr, # Possible `dokFieldUse`
       nkDiscardStmt, nkReturnStmt, nkYieldStmt, nkBreakStmt,
       nkProcTy,
       nkAsgn, # Might create different contex when assigned to global
               # variable (track only /assignments/ to global variable)
       nkMixinStmt, nkBindStmt,
       nkAccQuoted,

       nkNone, nkType, nkComesFrom, nkDotCall, nkCallStrLit, nkHiddenCallConv,
       nkVarTuple, nkCurly, nkCurlyExpr, nkRange, nkCheckedFieldExpr, nkElifExpr,
       nkElseExpr, nkLambda, nkDo, nkTableConstr, nkBind, nkClosedSymChoice,
       nkStaticExpr, nkAddr, nkObjDownConv, nkObjUpConv, nkChckRangeF,
       nkChckRange64, nkChckRange, nkStringToCString, nkCStringToString,
       nkFastAsgn, nkImportAs, nkOfBranch, nkParForStmt, nkCaseStmt, nkConstDef,
       nkDefer, nkContinueStmt, nkBlockStmt, nkStaticStmt, nkImportExceptStmt,
       nkExportExceptStmt, nkFromStmt, nkUsingStmt, nkBlockExpr, nkStmtListType,
       nkBlockType, nkWith, nkWithout, nkTypeOfExpr, nkTupleClassTy,
       nkTypeClassTy, nkStaticTy, nkConstTy, nkMutableTy, nkIteratorTy,
       nkSharedTy, nkArgList, nkPattern, nkHiddenTryStmt, nkClosure, nkGotoState,
       nkState, nkBreakState,

       nkRecList,
         :

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
      # TODO register pragma uses in head but ignore symbol declaration
      # itself (add to registration context)
      ctx.registerUses(node[2], state)

    of nkDistinctTy:
      ctx.registerUses(node[0], state)


proc toDocType(ctx; ntype: NType): DocType =
  case ntype.kind:
    of ntkIdent:
      if ntype.declNode.get().kind == nkIdent:
        result = DocType(
          kind: dtkGenericParam,
          paramName: $ntype.declNode.get())

      else:
        result = DocType(kind: dtkIdent, head: ctx[ntype])

    else:
      result = DocType(kind: dtkIdent)

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
      field.docBody = ctx.convertComment(
        nimField.docComment, nimField.declNode.get())

      field.identType = some ctx.toDocType(nimField.fldType)
      field.identTypeStr = some $nimField.fldType

  elif node[2].kind == nkEnumTy:
    let enumDecl: PEnumDecl = parseEnum(node)
    var entry = ctx.module.newDocEntry(dekEnum, enumDecl.name)
    ctx.setLocation(entry, node)
    ctx.addSigmap(node, entry)

    for enField in enumDecl.values:
      var field = entry.newDocEntry(dekEnumField, enField.name)

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

    var entry = ctx.module.newDocEntry(kind, $node[0])
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
  db = newDocDb(@[AbsDir(($stdPath).dropSuffix("lib"))])

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
