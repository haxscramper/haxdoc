import
  ../docentry,
  ../docentry_io,
  ../parse/docentry_link

import
  hnimast/[compiler_aux],
  compiler/[trees, types, sighashes, scriptconfig, wordrecg],
  packages/docutils/[rst]

import std/[
  strutils, strformat, tables, sequtils, with, sets, options, hashes]

export options

import
  hnimast,
  hmisc/core/[all, code_errors],
  hmisc/other/[oswrap, hlogger, hpprint],
  hmisc/algo/[hstring_algo, halgorithm, hseq_distance, hlex_base]

import
  haxorg/importer_nim_rst,
  haxorg/defs/defs_all

import haxorg

type
  DocContext = ref object of PPassContext
    db: DocDb
    graph: ModuleGraph
    allModules: seq[DocEntry]
    module: DocEntry
    sigmap: TableRef[PSym, DocId]
    conf: NimDocgenConf
    logger: HLogger

  NimDocgenConf* = object
    isOrgCommentSyntax*: proc(lib: DocLib): bool
    orgConf*: OrgConf
    rstConvertConf*: OrgConf

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
    rskCallHead

    rskImport
    rskExport
    rskInclude


  RegisterState = object
    state: seq[RegisterStateKind]
    switchId: DocId
    moduleId: DocId
    user: Option[DocId]
    hasInit: bool

DocContext.loggerField(logger)

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

    of nkAccQuoted:
      result = node[0].startPos()
      inc result.column

    else:
      result = node[0].startPos()

proc finishPos(node): DocPos =
  case node.kind:
    of nkTokenKinds:
      result = toDocPos(node.getInfo())
      result.column += len($node) - 1

    of nkAccQuoted:
      result = toDocPos(node.getInfo())
      result.column += len($node)

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

proc setLocation(ctx; entry: DocEntry, sym: PSYm) =
  entry.setLocation DocLocation(
    pos: sym.info.toDocPos(),
    absFile: AbsFile($ctx.graph.getFilePath(sym))
  )

  # entry.extent = some nodeExtent(node)
  # entry.declHeadExtent = some nodeExtent(node.declHead())

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
      ctx.sigmap[sym] = entry.id()

  except IndexDefect as e:
    discard

proc sigHash(t: NType): SigHash =
  result = t.declNode.get().headSym().trySigHash()

proc sigHash(t: PNode): SigHash =
  result = t.headSym().trySigHash()

proc sigHash(t: PSym): SigHash =
  result = t.trySigHash()

proc headSym(s: PSym): PSym = s
proc headSym(t: NType): PSym = t.declNode.get().headSym()

proc contains(ctx; ntype: NType | PNode | PSym): bool =
  ntype.headSym() in ctx.sigmap

proc `[]`(ctx; ntype: NType | PNode | PSym): DocId =
  let sym = headSym(ntype)
  if sym in ctx.sigmap:
    return ctx.sigmap[sym]

proc occur(ctx; node: PNode, kind: DocOccurKind, user: Option[DocId]) =
  var occur = DocOccur(user: user, kind: kind)
  if kind in dokLocalKinds:
    raise newUnexpectedKindError(kind)

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
    let slice = node.nodeSlice()
    ctx.db.newOccur(slice, file, occur)


proc subslice(parent, node: PNode): DocCodeSlice =
  let main = parent.nodeExprSlice()
  case parent.kind:
    of nkDotExpr: result = main[^(len($node)) .. ^1]
    of nkExprColonExpr:
      result.line = main.line
      result.column.b = main.column.a
      result.column.a = main.column.a - len($node)

    else:
      result = main


proc occur(
    ctx; node; parent: PNode; id: DocId,
    kind: DocOccurKind, user: Option[DocId]
  ) =
  var occur = DocOccur(kind: kind, user: user)
  occur.refid = id
  let file = ctx.graph.getFilePath(parent)
  if exists(file):
    let slice = parent.subslice(node)
    ctx.db.newOccur(slice, file, occur)

proc occur(
    ctx; node; kind: DocOccurKind,
    localid: string, withInit: bool = false
  ) =
  let path = ctx.graph.getfilepath(node).string.AbsFile()
  if not isabsolute(path):
    ctx.warn "invalid file position for", ctx.nodeposdisplay(node)

  else:
    var occur = DocOccur(kind: kind)
    occur.localId = localId
    occur.withInit = withInit


    if kind in dokLocalDeclKinds:
      if notNil(node.typ):
        let et = node.typ.skipTypes(skipPtrs)
        if notNil(et.sym):
          let id = ctx[et.sym]
          if id.isValid():
            occur.user = some id

    ctx.db.newOccur(node.nodeSlice(), path, occur)


    # let pragma = sym.ast[pragmasPos]
    # return effectSpec(pragma, word)


# proc getEffects*(body:)

proc registerProcBody(ctx; body: PNode, state: RegisterState, node) =
  let s = node[0].headSym()
  if isNil(s) or not isValid(ctx[s]): return
  let
    main = ctx.db[ctx[s]]
    decl = s.ast.asProcDecl()
    prag = decl.pragmas()
    mainRaise = s.typ.n.getEffects(exceptionEffects)
    mainEffect = s.typ.n.getEffects(tagEffects)

  if ?mainRaise:
    for r in mainRaise:
      main.raises.incl ctx[exprTypeSym(r)]
      let callSym = headSym(r)
      if notNil(callSym) and callSym.kind in skProcDeclKinds:
        # For `openarray[T]` `headSym` returns type symbol, but we are only
        # concerned with calls to other procedures here.
        main.raisesVia[ctx[callSym]] = DocIdSet()

  if ?mainEffect:
    for e in mainEffect:
      main.effects.incl ctx[exprTypeSym(e)]

      let callSym = headSym(e)
      if notNil(callSym) and callSym.kind in skProcDeclKinds:
        main.effectsVia[ctx[callSym]] = DocIdSet()

  let icpp = effectSpec(prag, {wImportc, wImportcpp, wImportJs, wImportObjC})
  if ?icpp: main.wrapOf = some icpp[0].getStrVal()

  let dyn = effectSpec(prag, wDynlib)
  if ?dyn: main.dynlibOf = some dyn[0].getStrVal()

  proc aux(node) =
    case node.kind:
      of nkTokenKinds - {nkSym}:
        discard

      of nkCall, nkCommand:
        let head = node[0].headSym()
        if not isNil(head):
          main.calls.incl ctx[head]
          let raises = head.effectSpec(wRaises)
          if ?raises:
            for r in raises:
              let id = ctx[r]
              if isValid(id) and id in main.raisesVia:
                main.raisesVia[id].incl ctx[head]

          let effects = head.effectSpec(wTags)
          if ?effects:
            for e in effects:
              let id = ctx[e]
              if isValid(id):
                main.effectsVia.mgetOrPut(id, DocIdSet()).incl id

        for sub in node:
          aux(sub)

      of nkRaiseStmt:
        if node[0].kind != nkEmpty and notNil(node[0].typ):
          let et = node[0].typ.skipTypes(skipPtrs)
          if notNil(et.sym):
            main.raisesDirect.incl ctx[et.sym]

      of nkSym:
        case node.sym.kind:
          of skVar, skLet:
            main.globalIO.incl ctx[node.sym]

          else:
            discard

      else:
        for sub in node:
          aux(sub)

  aux(body)





proc impl(
    ctx; node; state: RegisterState, parent: PNode
  ): Option[DocId] {.discardable.} =
  case node.kind:
    of nkSym:
      case node.sym.kind:
        of skType:
          if state.top() == rskExport:
            ctx.db[state.moduleId].exports.incl ctx[node]

          else:
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
                of rskCallHead: dokTypeConversionUse
                else:
                  echo node.treeRepr1()
                  echo ctx.graph.getFilePath(node), node.getInfo()
                  raise newImplementKindError(state.top())

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

          elif state.top() == rskExport:
            ctx.db[state.moduleId].exports.incl ctx[node]

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
            let (kind, ok) =
              case state.top():
                of rskAsgn:                    (dokLocalWrite, true)
                of rskProcHeader, rskProcArgs: (dokLocalArgDecl, true)
                of rskObjectFields, rskProcReturn:
                  # Local callback parameters or fields in return `tuple`
                  # values.
                  (dokLocalWrite, false)

                else:
                  (dokLocalUse, true)

            if ok:
              ctx.occur(node, kind, $node.headSym(), state.hasInit)

        of skResult:
          # IDEA can be used to collect information about `result` vs
          # `return` uses
          discard

        of skLabel, skTemp, skUnknown, skConditional, skDynLib,
           skGenericParam, skStub, skPackage, skAlias:
          discard # ???

        of skModule:
          ctx.occur(node, dokImport, some(state.moduleId))
          let module = ctx.db[state.moduleId]
          case state.top():
            of rskImport:
              module.imports.incl ctx[node]

            of rskExport:
              module.exports.incl ctx[node]

            of rskCallHead:
              # `module.proc`
              discard

            else:
              raise newUnexpectedKindError(state.top())


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
      var state = state
      state.hasInit = isEmptyNode(node[2])
      result = ctx.impl(node[0], state, node) # Variable declaration
      ctx.impl(node[1], state + result, node)
      ctx.impl(node[2], state + result, node)

    of nkImportStmt:
      for subnode in node:
        ctx.impl(subnode, state + rskImport, node)

    of nkIncludeStmt:
      for subnode in node:
        ctx.impl(subnode, state + rskInclude, node)

    of nkExportStmt:
      # QUESTION not really sure what `export` should be mapped to, so
      # discarding for now.
      for subnode in node:
        ctx.impl(subnode, state + rskExport, node)

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

    of nkCall, nkConv:
      if node.kind == nkCall and "defined" in $node:
        ctx.impl(node[1], state + rskDefineCheck, node)

      else:
        for idx, subnode in node:
          if idx == 0:
            ctx.impl(subnode, state + rskCallHead, node)

          else:
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

      ctx.registerProcBody(node[6], state, node)

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
      if node.safeLen > 0:
        ctx.impl(node[0], state, node)

    of nkAsgn:
      result = ctx.impl(node[0], state + rskAsgn, node)
      if result.isSome():
        ctx.impl(node[1], state + result.get(), node)

      else:
        ctx.impl(node[1], state, node)

    of nkObjConstr:
      if node[0].kind != nkEmpty and notNil(node[0].typ):
        let headType = node[0].typ.skipTypes(skipPtrs)
        if notNil(headType.sym):
          let headId = ctx[headType.sym]
          if headId in ctx.db:
            let head = ctx.db[headId]
            for fieldPair in node[1 ..^ 1]:
              let field = fieldPair[0]
              let fieldId = head.getSub(field.getStrVal())
              if fieldId.isValid():
                ctx.occur(field, fieldPair, fieldId, dokFieldSet, state.user)

      ctx.impl(node[0], state, node)
      for subnode in node[1 ..^ 1]:
        ctx.impl(subnode[1], state, node)

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
  discard impl(ctx, node, state, nil)



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
        genParams: @[ctx.toDocType(ntype.vaType())])

      if ntype.vaConverter.isSome():
        result.genParams.add DocType(
          kind: dtkValue,
          value: $ntype.vaConverter.get())

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
    of nkConverterDef: dekConverter
    else:
      raise newImplementKindError(decl.declNode.get())

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
      raise newImplementKindError(nt)

proc convertComment(ctx: DocContext, text: string; node: PNode): SemOrg =
  return newSem(orgEmpty)

  let package = ctx.db.getLibForPath(ctx.graph.getFilePath(node))
  if ctx.conf.isOrgCommentSyntax(package):
    let (sem, ctx) = orgSem(
      text,
      AbsFile($ctx.graph.getFilePath(node)),
      ctx.conf.orgConf)

    result = sem
    # parseOrg(text).toSemOrg(ctx.conf.orgOrgConf)

  else:
    let file = AbsFile($ctx.graph.getFilePath(node))
    try:
      return text.
        strip().
        parseRstString(file).
        toOrgNode().
        orgSem(file, ctx.conf.rstConvertConf).
        sem

    except EParseError as e:
      ctx.err e.msg
      return newTree(orgRawText, e.msg).
        orgSem(file, ctx.conf.rstConvertConf).
        sem

    except ImplementKindError as e:
      ctx.err ctx.graph.getFilePath(node), node.getInfo()
      raise e



proc setDeprecated(entry: var DocEntry, node) =
  let depr = node.getPragma("deprecated")
  if depr.getSome(depr):
    if depr.safeLen == 0:
      entry.deprecatedMsg = some ""

    else:
      entry.deprecatedMsg = some depr[1].getStrVal()


proc registerProcDef(ctx: DocContext, procDef: PNode) =
  let procDecl = try:
                   parseProc(procDef)
                 except ImplementKindError as e:
                   echo procDef.treeRepr1()
                   echo ctx.graph.getFilePath(procDef), procDef.getInfo()
                   raise e


  var entry = ctx.module.newDocEntry(
    procDecl.classifiyKind(), procDecl.name, ctx.toDocType(procDecl.signature))

  case entry.name:
    of "=destroy": entry.procKind = dpkDestructor
    of "=sink": entry.procKind = dpkMoveOverride
    of "=copy": entry.procKind = dpkCopyOverride
    of "=": entry.procKind = dpkAsgnOverride
    else:
      if entry.name[^1] == '=' and entry.name[0] in IdentStartChars:
        entry.procKind = dpkPropertySet

      elif entry.name[0] in IdentStartChars:
        if entry.name.startsWith(["init", "new"]):
          entry.procKind = dpkConstructor

        else:
          entry.procKind = dpkRegular

      else:
        entry.procKind = dpkOperator

  entry.setDeprecated(procDef)
  if procDecl.declNode.get().isExported():
    entry.visibility = dvkPublic

  ctx.addSigmap(procDef, entry)
  ctx.setLocation(entry, procDef)
  entry.docText.rawDoc.add procDecl.docComment
  entry.docText.docBody = ctx.convertComment(procDecl.docComment, procDef)

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

    # raise newImplementError("# TODO register type parameters for node")
    # raise newImplementError(
    #   "# TODO Separate fields into private and public. Do the same " &
    #     "for procedures and other entries in modules")
    # TODO Check for method overrides

    if node.isExported(): entry.visibility = dvkPublic
    if objectDecl.base.isSome():
      entry.superTypes.add ctx[objectDecl.base.get()]

    ctx.setLocation(entry, node)
    ctx.addSigmap(node, entry)
    entry.setDeprecated(node)
    entry.docText.rawDoc.add objectDecl.docComment
    entry.docText.docBody = ctx.convertComment(objectDecl.docComment, node)

    for param in objectDecl.name.genParams:
      var p = entry.newDocEntry(dekParam, param.head)

    for nimField in iterateFields(objectDecl):
      var field = entry.newDocEntry(dekField, nimField.name)
      field.docText.rawDoc.add nimField.docComment
      field.docText.docBody = ctx.convertComment(
        nimField.docComment, nimField.declNode.get())

      if nimField.declNode.get().isExported():
        field.visibility = dvkPublic

      with field:
        identType = some ctx.toDocType(nimField.fldType)
        identTypeStr = some $nimField.fldType

      ctx.setLocation(field, nimField.declNode.get())
      ctx.addSigmap(nimField.declNode.get(), field)

  elif node[2].kind == nkEnumTy:
    let enumDecl: PEnumDecl = parseEnum(node)
    var entry = ctx.module.newDocEntry(dekEnum, enumDecl.name)

    entry.setDeprecated(node)
    ctx.setLocation(entry, node)
    ctx.addSigmap(node, entry)
    entry.docText.docBody = ctx.convertComment(enumDecl.docComment, node)

    if enumDecl.exported:
      entry.visibility = dvkPublic

    for enField in enumDecl.values:
      var field = entry.newDocEntry(dekEnumField, enField.name)
      field.visibility = entry.visibility
      # info enField.docComment
      field.docText.docBody = ctx.convertComment(
        enField.docComment, enField.declNode.get())
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

    if node.isExported(): entry.visibility = dvkPublic

    entry.setDeprecated(node)
    ctx.setLocation(entry, node)
    ctx.addSigmap(node, entry)
    entry.baseType = baseType

    for param in parseNType(node[0]).genParams:
      var p = entry.newDocEntry(dekParam, param.head)


  elif node[0].kind in {nkPragmaExpr}:
    var entry = ctx.module.newDocEntry(dekBuiltin, $node[0][0])
    if node.isExported(): entry.visibility = dvkPublic

    entry.setDeprecated(node)
    ctx.setLocation(entry, node)
    ctx.addSigmap(node, entry)

  elif node[2].kind in {nkCall}:
    # `Type = typeof(expr())`
    discard

  elif node[2].kind in {nkTypeClassTy}:
    # IMPLEMENT concept indexing
    discard

  else:
    ctx.warn node[2].kind
    ctx.debug node
    ctx.debug treeRepr(node)

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
      let pragma = node.parseSomePragma()
      var nodeKind = nodeKind
      if pragma.isSome() and pragma.get().hasElem(@["intdefine", "strdefine", "booldefine"]):
        nodeKind = dekCompileDefine

      var def = ctx.module.newDocEntry(nodeKind, $node[0].declHead)
      if parseIdentName(node).exported:
        def.visibility = dvkPublic

      ctx.setLocation(def, node[0])
      ctx.addSigmap(node[0], def)
      # TODO extract comments

    of nkVarTuple:
      # TODO
      discard

    else:
      raise newImplementKindError(node, node.treeRepr1())


proc registerToplevel(ctx, node) =
  try:
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

  except:
    ctx.err ctx.nodePosDisplay(node)
    raise

template initLoggerCb(logger: untyped): untyped =
  proc cb(config: ConfigRef; info: TLineInfo; msg: string; level: Severity) =
    {.cast(gcsafe).}:
      if config.errorCounter >= config.errorMax:
        let path = config.getFilePath(info)
        if level == Severity.Error:

          `logger`.err msg
          `logger`.err path

        elif level == Severity.Warning:
          `logger`.warn msg
          `logger`.warn path

        else:
          `logger`.notice msg
          `logger`.notice path

        `logger`.logLines(path, info.line.int, "nim", info.col.int)

  cb

let
  baseNimDocgenConf* = NimDocgenConf(
    orgConf: haxrunConf(),
    rstConvertConf: haxrunConf()
  )


proc registerDocPass(
    graph: ModuleGraph,
    file: AbsFile,
    stdpath: AbsDir,
    extraLibs: seq[(AbsDir, string)] = @[],
    startDb: DocDb                   = newDocDb(),
    conf: NimDocgenConf              = baseNimDocgenConf,
    orgComments: seq[string]         = @[],
    logger: HLogger                  = newTermLogger()
  ): DocDb =
  ## Create new documentation generator graph

  var
    db {.global.}: DocDb
    tmpConf {.global.}: NimDocgenConf
    doclogger {.global.}: HLogger

  tmpConf = conf
  db = startDb
  doclogger = logger

  tmpConf.isOrgCommentSyntax = proc(lib: DocLib): bool =
    lib.name in orgComments

  # tmpConf.orgConf.linkResolver = proc(
  #   linkName: string, linkText: PosStr): OrgLink =
  #     if linkName == "":
  #       raise newArgumentError(
  #         "Link name cannot be empty")
  #     db.resolveFullIdent(parseFullIdent(linkText)).newOrgLink()

  # tmpConf.rstConvertConf.linkResolver = proc(
  #   linkName: string, linkText: PosStr): OrgLink =
  #     discard

  db.addKnownLib(AbsDir(($stdPath).dropSuffix("lib")), "std")
  for (path, lib) in extraLibs:
    db.addKnownLib(path, lib)

  var sigmap {.global.}: TableRef[PSym, DocId]
  sigmap = newTable[PSym, DocId]()


  registerPass(graph, semPass)
  registerPass(
    graph, makePass(
      TPassOpen(
        proc(graph: ModuleGraph, module: PSym, idgen: IdGenerator): PPassContext {.nimcall.} =
          var
            context = DocContext(
              db: db, graph: graph, sigmap: sigmap,
              conf: tmpConf, logger: doclogger)
            file = graph.getFilePath(module)
            package = db.getOrNewPackage(file)

          context.info "Processing", module

          context.module = package.newDocEntry(dekModule, module.getStrVal())

          context.setLocation(context.module, module)

          context.module.visibility = dvkPublic
          sigmap[module] = context.module.id()
          context.db.setIdForFile(file, context.module.id())

          context.allModules.add context.module
          return context
      ),
      TPassProcess(
        proc(c: PPassContext, n: PNode): PNode {.nimcall.} =
          result = n
          var ctx = DocContext(c)
          registerToplevel(ctx, n)
      ),
      TPassClose(
        proc(graph: ModuleGraph; p: PPassContext, n: PNode): PNode {.nimcall.} =
          discard
      )
    )
  )

  return db


proc generateDocDb*(
    file: AbsFile,
    stdpath: AbsDir                  = getStdPath(),
    extraLibs: seq[(AbsDir, string)] = @[],
    fileLib: Option[string]          = some(file.name()),
    defines: seq[string]             = @["nimdoc", "haxdoc"],
    startDb: DocDb                   = newDocDB(),
    conf: NimDocgenConf              = baseNimDocgenConf,
    orgComments: seq[string]         = @[],
    logger: HLogger                  = newTermLogger()
  ): DocDb =

  assertExists(
    stdpath,
    "Could not find stdlib for nim database compilation"
  )

  var extraLibs = extraLibs
  if fileLib.isSome():
    extraLibs.add((file.dir(), fileLib.get()))


  var graph {.global.}: ModuleGraph
  graph = newModuleGraph(
    file, stdpath, initLoggerCb(logger), symDefines = defines)

  var db = graph.registerDocPass(
    file, stdpath, extraLibs, startDb = startDb,
    conf = conf, orgComments = orgComments)


  for (dir, name) in extraLibs:
    assertExists(dir, &"Path for package {name}")
    graph.config.searchPaths.add dir

  logger.indented:
    compileProject(graph)

  return db


proc projectFiles*(
    sourceDir: AbsDir,
    logger: HLogger,
    ignored: seq[GitGlob] = @[],
  ): seq[AbsFile] =
  ## Return list of project files.
  ##
  ## - TODO :: Allow user to specify lista of target files

  for file in walkDir(
    sourceDir, AbsFile, exts = @["nim"], recurse = true):
    if ignored.accept(file.string):
      result.add file

    else:
      logger.notice "Ignored", file
