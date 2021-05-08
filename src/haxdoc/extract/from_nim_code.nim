import ../docentry, ../docentry_io
import hnimast/compiler_aux
import hmisc/hdebug_misc
import hmisc/helpers
import std/[strutils, strformat, tables, sequtils, with]
import packages/docutils/[rst]
import hnimast
import hmisc/helpers
import hmisc/other/[oswrap, colorlogger]
import hmisc/algo/[hstring_algo, halgorithm]
import compiler/sighashes
import haxorg/[semorg, ast, importer_nim_rst]

proc headSym(node: PNode): PSym =
  case node.kind:
    of nkProcDeclKinds, nkDistinctTy, nkVarTy, nkAccQuoted,
       nkBracketExpr, nkTypeDef, nkPragmaExpr, nkPar, nkEnumFieldDef,
       nkIdentDefs, nkRecCase:
      headSym(node[0])

    of nkCommand, nkCall, nkDotExpr, nkPrefix, nkPostfix:
      headSym(node[1])

    of nkSym:
      node.sym

    of nkRefTy, nkPtrTy:
      if node.len == 0:
        nil

      else:
        headSym(node[0])

    of nkIdent, nkEnumTy, nkProcTy, nkObjectTy, nkTupleTy,
       nkTupleClassTy, nkIteratorTy:
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
    rskAsgn

    rskImport


  RegisterState = object
    state: seq[RegisterStateKind]
    switchId: DocId
    moduleId: DocId
    user: Option[DocId]

using
  ctx: DocContext
  node: PNode

proc nodePosDisplay(ctx; node): string =
  let info = node.getInfo()
  return $ctx.graph.getFilePath(node) & "(" & $info.line & ":" & $info.col & ")"


proc `+`(state: RegisterState, kind: RegisterStateKind): RegisterState =
  result = state
  result.state.add kind

proc `+`(state: RegisterState, user: DocId): RegisterState =
  result = state
  if not user.isValid():
    result.user = some user

proc `+`(state: RegisterState, user: Option[DocId]): RegisterState =
  result = state
  if result.user.isNone() or (result.user.isSome() and user.isSome()):
    if user.isSome() and not user.get().isValid():
      discard

    else:
      result.user = user

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
  initDocSlice(
    node.getInfo().line.int,
    node.getInfo().col.int,
    node.getInfo().col.int + l - 1
  )


proc nodeExprSlice(node: PNode): DocCodeSlice =
  ## Return source code slice for `node`.
  let l = len($node)
  let i = node.getInfo()
  result = initDocSlice(i.line.int, i.col.int, i.col.int + l - 1)
  case node.kind:
    of nkDotExpr:
      result -= len($node[0]) - 1

    else:
      discard

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
      discard

proc addSigmap(ctx; node; entry: DocEntry) =
  try:
    let sym = node.headSym()
    if not isNil(sym):
      let hash = sym.sigHash()
      ctx.sigmap[hash] = entry.id()

  except IndexDefect as e:
    discard

proc sigHash(t: NType): SigHash =
  result = t.declNode.get().headSym().trySigHash()

proc sigHash(t: PNode): SigHash =
  result = t.headSym().trySigHash()

proc sigHash(t: PSym): SigHash =
  result = t.trySigHash()

proc contains(ctx; ntype: NType | PNode | PSym): bool =
  ntype.sigHash() in ctx.sigmap

proc `[]`(ctx; ntype: NType | PNode | PSym): DocId =
  let hash = ntype.sigHash()
  if hash in ctx.sigmap:
    return ctx.sigmap[hash]

proc occur(ctx; node: PNode, kind: DocOccurKind, user: Option[DocId]) =
  var occur = DocOccur(user: user, kind: kind)
  if kind == dokLocalUse:
    raiseImplementError("")

  else:
    occur.refid = ctx[node]

  let file = ctx.graph.getFilePath(node)
  if exists(file):
    ctx.db.newOccur(node.nodeSlice(), file, occur)

proc occur(ctx; node; id: DocId, kind: DocOccurKind, user: Option[DocId]) =
  var occur = DocOccur(kind: kind, user: user)
  occur.refid = id
  let file = ctx.graph.getFilePath(node)
  if exists(file):
    ctx.db.newOccur(node.nodeSlice(), file, occur)

proc subslice(parent, node: PNode): DocCodeSlice =
  let main = parent.nodeExprSlice()
  case parent.kind:
    of nkDotExpr: result = main[^(len($node)) .. ^1]
    else: result = main

proc occur(
    ctx; node; parent: PNode; id: DocId,
    kind: DocOccurKind, user: Option[DocId]
  ) =
  var occur = DocOccur(kind: kind, user: user)
  occur.refid = id
  let file = ctx.graph.getFilePath(parent)
  if exists(file):
    ctx.db.newOccur(parent.subslice(node), file, occur)

proc occur(ctx; node; localId: string) =
  ctx.db.newOccur(
    node.nodeSlice(),
    ctx.graph.getFilePath(node).string.AbsFile(),
    DocOccur(kind: dokLocalUse, localId: localId))


proc impl(
    ctx; node; state: RegisterState, parent: PNode
  ): Option[DocId] {.discardable.} =
  case node.kind:
    of nkSym:
      case node.sym.kind:
        of skType:
          let useKind =
            case state.top():
              of rskTopLevel, rskPragma, rskAsgn:  dokTypeDirectUse
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
                echo node.treeRepr1()
                echo ctx.graph.getFilePath(node), node.getInfo()
                raiseImplementKindError(state.top())

          ctx.occur(node, useKind, state.user)

          if useKind in {dokEnumDeclare, dokObjectDeclare, dokAliasDeclare}:
            result = some ctx[node]

        of skEnumField:
          if state.top() == rskEnumFields:
            ctx.occur(node, dokEnumFieldDeclare, state.user)

          else:
            ctx.occur(node, dokEnumFieldUse, state.user)

        of skField:
          if node.sym.owner.notNil:
            let id = ctx[node.sym.owner]
            if id.isValid():
              let field = ctx.db[id].getSub($node)
              ctx.occur(node, parent, field, dokFieldUse, state.user)

        of skProcDeclKinds:
          if state.top() == rskProcHeader:
            let disp = ctx.nodePosDisplay(node)
            ctx.occur(node, dokCallDeclare, state.user)
            result = some ctx[node]

          else:
            ctx.occur(node, dokCall, state.user)

        of skParam, skVar, skConst, skLet, skForVar:
          let sym = node.headSym()
          if sym in ctx:
            if state.top() == rskAsgn:
              ctx.occur(node, dokGlobalWrite, state.user)

            elif state.top() == rskToplevel:
              ctx.occur(node, dokGlobalDeclare, state.user)
              result = some ctx[sym]

            else:
              ctx.occur(node, dokGlobalRead, state.user)

          else:
            ctx.occur(node, $node.headSym())

        of skResult:
          # IDEA can be used to collect information about `result` vs
          # `return` uses
          discard

        of skLabel, skTemp, skUnknown, skConditional, skDynLib,
           skGenericParam, skStub, skPackage, skAlias:
          discard # ???

        of skModule:
          ctx.occur(node, dokImport, some(state.moduleId))

    of nkIdent:
      if state.switchId.isValid():
        let sub = ctx.db[state.switchId].getSub($node)
        if sub.isValid():
          ctx.occur(node, sub, dokEnumFieldUse, state.user)

      elif state.top() == rskDefineCheck:
        let def = ctx.db.getOrNew(dekCompileDefine, $node)
        ctx.occur(node, def.id(), dokDefineCheck, state.user)

      elif state.top() == rskPragma:
        let def = ctx.db.getOrNew(dekPragma, $node)
        ctx.occur(node, def.id(), dokAnnotationUsage, state.user)

      elif state.top() == rskObjectFields:
        let def = ctx.db[state.user.get()].getSub($node)
        ctx.occur(node, def, dokFieldDeclare, state.user)

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
            ctx.occur(node, sub, dokEnumFieldUse, state.user)


    of nkPragmaExpr:
      result = ctx.impl(node[0], state, node)
      ctx.impl(node[1], state + rskPragma + result, node)

    of nkIdentDefs, nkConstDef:
      result = ctx.impl(node[0], state, node) # Variable declaration
      ctx.impl(node[1], state + result, node)
      ctx.impl(node[2], state + result, node)

    of nkImportStmt:
      for subnode in node:
        ctx.impl(subnode, state + rskImport, node)

    of nkIncludeStmt:
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
        result = ctx.impl(subnode, state + rskPragma, node)

    of nkAsmStmt:
      # IDEA possible analysis of passthrough code?
      discard

    of nkCall:
      if "defined" in $node:
        ctx.impl(node[1], state + rskDefineCheck, node)

      else:
        for subnode in node:
          ctx.impl(subnode, state, node)

    of nkProcDeclKinds:
      result = ctx.impl(node[0], state + rskProcHeader, node)
      # IDEA process TRM macros/pattern susing different state constraints.
      ctx.impl(node[1], state + rskProcHeader + result, node)
      ctx.impl(node[2], state + rskProcHeader + result, node)
      ctx.impl(node[3][0], state + rskProcReturn + result, node)
      for n in node[3][1 ..^ 1]:
        ctx.impl(n, state + rskProcArgs + result, node)

      ctx.impl(node[4], state + rskProcHeader + result, node)
      ctx.impl(node[5], state + rskProcHeader + result, node)
      ctx.impl(node[6], state + result, node)

    of nkBracketExpr:
      ctx.impl(node[0], state + rskBracketHead, node)
      for subnode in node[1..^1]:
        ctx.impl(subnode, state + rskBracketArgs, node)

    of nkRecCase:
      var state = state
      state.switchId = ctx[node[0][1]]
      ctx.impl(node[0], state + rskObjectBranch, node)
      for branch in node[1 .. ^1]:
        for expr in branch[0 .. ^2]:
          ctx.impl(expr, state + rskObjectBranch, node)

        ctx.impl(branch[^1], state + rskObjectFields, node)

    of nkRaiseStmt:
      # TODO get type of the raised expression and if it is a concrete type
      # record `dokRaised` usage.
      for subnode in node:
        ctx.impl(subnode, state, node)

    of nkOfInherit:
      ctx.impl(node[0], state + rskInheritList, node)

    of nkOpenSymChoice:
      # QUESTION I have no idea what multiple symbol choices mean *after*
      # semcheck happened, so discarding for now.
      discard

    of nkTypeDef:
      let decl =
        if node.isAliasDecl(): rskAliasHeader
        elif node.isEnum():    rskEnumHeader
        else:                  rskTypeHeader

      result = ctx.impl(node[0], state + decl, node)
      ctx.impl(node[1], state + decl + result, node)
      ctx.impl(node[2], state + result, node)

    of nkDistinctTy:
      ctx.impl(node[0], state, node)

    of nkAsgn:
      result = ctx.impl(node[0], state + rskAsgn, node)
      if result.isSome():
        ctx.impl(node[1], state + result.get(), node)

      else:
        ctx.impl(node[1], state, node)

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
        ctx.impl(subnode, state, node)


proc registerUses(ctx; node; state: RegisterState) =
  impl(ctx, node, state, nil)


proc toDocType(ctx; ntype: NType): DocType =
  case ntype.kind:
    of ntkIdent:
      if ntype.declNode.get().kind == nkIdent:
        result = DocType(
          name: ntype.head,
          kind: dtkGenericParam,
          paramName: $ntype.declNode.get())

      elif ntype.head in ["ref", "sink", "ptr", "var"]:
        result = DocType(name: ntype.head, kind: dtkIdent)

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

    of ntkCurly:
      result = ctx.toDocType(ntype.curlyHead())

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
        if result == dekRefAlias:
          result = dekObject


proc classifyKind(nt: NType, asAlias: bool): DocEntryKind =
  if asAlias:
    case nt.kind:
      of ntkIdent:
        if nt.head == "ref":
          return dekRefAlias

        else:
          return dekAlias

      of ntkGenericSpec:
        return dekTypeclass

      else:
        return dekAlias

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

  except ImplementKindError as e:
    err ctx.graph.getFilePath(node), node.getInfo()
    raise e


proc registerProcDef(ctx: DocContext, procDef: PNode) =
  let procDecl = try:
                   parseProc(procDef)
                 except ImplementKindError as e:
                   echo procDef.treeRepr1()
                   echo ctx.graph.getFilePath(procDef), procDef.getInfo()
                   raise e

  var entry = ctx.module.newDocEntry(
    procDecl.classifiyKind(), procDecl.name, ctx.toDocType(procDecl.signature))

  ctx.addSigmap(procDef, entry)
  ctx.setLocation(entry, procDef)
  entry.rawDoc.add procDecl.docComment
  entry.docBody = ctx.convertComment(procDecl.docComment, procDef)

  for argument in arguments(procDecl):
    let argType = ctx.toDocType(argument.vtype)
    for ident in argument.idents:
      var arg = entry.newDocEntry(dekArg, ident.getStrVal())
      arg.identType = some argType
      arg.identTypeStr = some $argument.vtype
      ctx.setLocation(arg, ident)

  let procType = ctx.toDocType(procDecl.signature)


proc registerTypeDef(ctx; node) =
  if isObjectDecl(node):
    let objectDecl: PObjectDecl = try:
                                    parseObject(node)
                                  except ImplementError as e:
                                    echo node.treeRepr1()
                                    echo ctx.graph.getFilePath(node), node.getInfo()
                                    raise e

    let kind = ctx.classifyKind(objectDecl)
    var entry = ctx.module.newDocEntry(kind, objectDecl.name.head)

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
      ctx.addSigmap(nimField.declNode.get(), field)

  elif node[2].kind == nkEnumTy:
    let enumDecl: PEnumDecl = parseEnum(node)
    var entry = ctx.module.newDocEntry(dekEnum, enumDecl.name)
    ctx.setLocation(entry, node)
    ctx.addSigmap(node, entry)

    for enField in enumDecl.values:
      var field = entry.newDocEntry(dekEnumField, enField.name)
      ctx.setLocation(field, enField.declNode.get())
      ctx.addSigmap(enField.declNode.get(), field)

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

proc registerDeclSection(ctx; node; nodeKind: DocEntryKind = dekGlobalVar) =
  case node.kind:
    of nkConstSection, nkVarSection, nkLetSection:
      let nodeKind =
        case node.kind:
          of nkConstSection: dekGlobalConst
          of nkVarSection:  dekGlobalVar
          else: dekGlobalLet

      for subnode in node:
        ctx.registerDeclSection(subnode, nodeKind)

    of nkConstDef, nkIdentDefs:
      var def = ctx.module.newDocEntry(nodeKind, $node[0].declHead)
      ctx.setLocation(def, node[0])
      ctx.addSigmap(node[0], def)
      # TODO extract comments

    else:
      raiseImplementKindError(node, node.treeRepr1())


proc registerToplevel(ctx, node) =
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
        ctx.registerTopLevel(subnode)

    of nkVarSection, nkLetSection, nkConstSection:
      ctx.registerDeclSection(node)

    of nkEmpty, nkCommentStmt, nkIncludeStmt, nkImportStmt,
       nkPragma, nkExportStmt:
      discard

    else:
      discard

  var state = initRegisterState()
  state.moduleId = ctx.module.id()
  ctx.registerUses(node, state)


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
          info "Processing ", module
          var context = DocContext(db: db, graph: graph, sigmap: sigmap)
          context.module = db.newDocEntry(dekModule, module.getStrVal())
          sigmap[module.sigHash()] = context.module.id()
          context.db.setIdForFile(graph.getFilePath(module), context.module.id())

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
