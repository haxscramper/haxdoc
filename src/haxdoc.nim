{.experimental: "caseStmtMacros".}

import std/[os, strformat, with, lenientops, strutils, sequtils, macros]
import hmisc/other/[colorlogger, oswrap]
import hmisc/helpers
import hmisc/types/[colortext, colorstring]
import hmisc/algo/htree_mapping

import hnimast, hnimast/obj_field_macros
import fusion/matching
import nimtrail/nimtrail_common
import cxxstd/cxx_common

import compiler /
  [ idents, options, modulegraphs, passes, lineinfos, sem, pathutils, ast,
    modules, condsyms, passaux, llstream, parser
  ]

import compiler/astalgo except debug

{.push inline.}

func `-`*[E](s1: set[E], s2: E): set[E] = s1 - {s2}
func `-=`*[E](s1: var set[E], v: E | set[E]) = (s1 = s1 - {v})

{.pop.}

template debug(node: PNode) {.dirty.} =
  log(lvlDebug, @[
    $instantiationInfo(),
    "\n",
    colorizeToStr($node, "nim")
    # "\n"
  ])

converter toAbsoluteDir*(dir: AbsDir): AbsoluteDir =
  AbsoluteDir(dir.string)

converter toAbsoluteFile*(file: AbsFile): AbsoluteFile =
  AbsoluteFile(file.string)

proc parsePNode(file: AbsFile): PNode =
  let cache: IdentCache = newIdentCache()
  let config: ConfigRef = newConfigRef()
  var pars: Parser

  pars.lex.errorHandler =
    proc(conf: ConfigRef; info: TLineInfo; msg: TMsgKind; arg: string) =
      warn msg

  openParser(
    p = pars,
    filename = file,
    inputStream = llStreamOpen(file, fmRead),
    cache = cache,
    config = config
  )

  result = parseAll(pars)
  closeParser(pars)

proc getFilePath(graph: ModuleGraph, node: PNode): AbsoluteFile =
  ## Get absolute file path for declaration location of `node`
  graph.config.m.fileInfos[node.info.fileIndex.int32].fullPath


proc getFilePath(config: ConfigRef, info: TLineInfo): AbsoluteFile =
  ## Get absolute file path for declaration location of `node`
  config.m.fileInfos[info.fileIndex.int32].fullPath

template excludeAllNotes(config: ConfigRef; n: typed) =
  config.notes.excl n
  when compiles(config.mainPackageNotes):
    config.mainPackageNotes.excl n
  when compiles(config.foreignPackageNotes):
    config.foreignPackageNotes.excl n

proc newModuleGraph(file: AbsFile): ModuleGraph =
  var
    cache: IdentCache = newIdentCache()
    config: ConfigRef = newConfigRef()

  let path = ~".choosenim/toolchains/nim-1.4.0/lib"

  with config:
    libpath = AbsoluteDir(path)
    cmd = cmdIdeTools

  config.verbosity = 0
  config.options -= optHints
  config.searchPaths.add @[
    config.libpath,
    path / "pure",
    path / "pure" / "collections",
    path / "impure",
    path / "std",
    path / "core",
    path / "posix"
  ]

  config.projectFull = file
  # config.excludeAllNotes(hintLineTooLong)

  config.structuredErrorHook =
    proc(config: ConfigRef; info: TLineInfo; msg: string; level: Severity) =
      discard
      # info level
      # err msg
      # err info, config.getFilePath(info)

  wantMainModule(config)

  initDefines(config.symbols)

  return newModuleGraph(cache, config)

type
  SourcetrailContext = ref object of PPassContext
    writer: ptr SourcetrailDBWriter
    module: PSym
    graph: ModuleGraph

converter toSourcetrailSourceRange*(
  arg: tuple[fileId: cint, ranges: array[4, int16]]): SourcetrailSourceRange =

  assert arg.fileId > 0

  result.fileId = arg.fileId
  result.startLine = arg.ranges[0].cint
  result.startColumn = arg.ranges[1].cint
  result.endLine = arg.ranges[2].cint
  result.endColumn = arg.ranges[3].cint

  # debug result


proc declHead(node: PNode): PNode =
  # debug node.treeRepr(indexed = true)
  case node.kind:
    of nkTypeDef, nkRecCase, nkIdentDefs, nkProcDeclKinds, nkPragmaExpr:
      result = declHead(node[0])

    of nkSym, nkIdent, nkEnumFieldDef:
      result = node

    of nkPostfix:
      result = node[1]

    else:
      debug node.kind
      debug node.treeRepr()
      raiseImplementError("")

converter toSourcetrailSourceRange*(
  arg: tuple[file: cint, name: PNode]): SourcetrailSourceRange =
  let head = arg.name.declHead()
  var loc = [
    arg.name.info.line.int16,
    arg.name.info.col + 1,
    arg.name.info.line.int16,
    arg.name.info.col + len($head).int16
  ]


  # info arg.name.kind
  if head.kind in {nkSym, nkIdent}:
    if arg.name.kind == nkTypeDef:
      loc[1] -= len($head).int16 + 1
      loc[3] -= len($head).int16 + 1

    elif arg.name.kind == nkRecCase:
      warn "Adjust case field"
      loc[1] += 5
      loc[3] += 5


  # info "Location for", toRed($head), loc, head.kind, arg.name.kind

  toSourcetrailSourcerange((arg.file, loc))

proc returnType*[N](ntype: NType[N]): Option[NType[N]] =
  if ntype.rtype.isSome():
    return some ntype.rType.get().getIt()

proc arguments*[N](procDecl: ProcDecl[N]): seq[NIdentDefs[N]] =
  procDecl.signature.arguments

proc returnType*[N](procDecl: ProcDecl[N]): Option[NType[N]] =
  procDecl.signature.returnType()

proc toNNode*[N](ntype: Option[NType[N]]): N =
  if ntype.isNone():
    newNTree[N](nnkEmpty)

  else:
    toNNode[N](ntype.get())




proc recordNodeLocation(
  ctx: SourcetrailContext, nodeSymbolId: cint, node: PNode): cint =
  ## Record location of `nodeSymbolId` using positional information from
  ## `node`

  let filePath = ctx.graph.getFilePath(node).string
  let fileId = ctx.writer[].recordFile(filePath)
  discard ctx.writer[].recordFileLanguage(fileId, "nim")
  discard ctx.writer[].recordSymbolLocation(nodeSymbolId, (fileId, node))
  discard ctx.writer[].recordSymbolScopeLocation(nodeSymbolId, (fileId, node))

  return fileId



proc getProcId(writer: var SourcetrailDBWriter, procDecl: PProcDecl): cint =
  let returnType = procDecl.returnType().toNNode()
  let arguments = procDecl.arguments.mapIt($it.toNNode()).join(", ").wrap("()")
  return writer.recordSymbol(sskFunction, ($returnType, procDecl.name, arguments))

proc registerCalls(
    ctx: SourcetrailContext,
    node: PNode,
    fileId, callerId: cint
  ) =
  assert fileId > 0
  # debug "", node.info
  # debug node.treeRepr()

  case node.kind:
    of nkSym:
      if node.sym.kind in routineKinds and
         (not node.sym.ast.isNil) and
         (not (node.sym.ast.kind == nkDo)):
        let parsed =
          try:
            parseProc(node.sym.ast)
          except ImplementError:
            echo node.sym.ast.treeRepr
            echo node.kind
            echo node.sym.kind
            echo node.sym.ast
            raise

        let referencedSymbol = ctx.writer[].getProcId(parsed)

        let referenceId = ctx.writer[].recordReference(
          callerId, referencedSymbol, srkCall)

        discard ctx.writer[].recordReferenceLocation(referenceId, (fileId, node))

      elif node.sym.kind in {skParam}:
        let localId = ctx.writer[].recordLocalSymbol($node.sym)
        discard ctx.writer[].recordLocalSymbolLocation(localId, (fileId, node))


    of nkLiteralKinds:
      discard

    of nkIdent:
      discard

    else:
      for subnode in mitems(node.sons):
        ctx.registerCalls(subnode, fileId, callerId)



proc registerProcDef(ctx: SourcetrailContext, fileId: cint, procDef: PNode): cint =
  let procDecl = parseProc(procDef)
  result = ctx.writer[].getProcId(procDecl)

  let fileId = ctx.recordNodeLocation(result, procDef)

  for argument in argumentIdents(procDecl):
    let localId = ctx.writer[].recordLocalSymbol($argument.sym)
    discard ctx.writer[].recordLocalSymbolLocation(localId, (fileId, argument))

  logIndented:
    ctx.registerCalls(procDecl.impl, fileId, result)

iterator iterateFields*(objDecl: PObjectDecl): PObjectField =
  proc getSubfields(field: PObjectField): seq[PObjectField] =
    for branch in field.branches:
      for field in branch.flds:
        result.add field

  for field in objDecl.flds:
    iterateItDFS(field, it.getSubfields(), it.isKind, dfsPostorder):
      yield it

proc registerTypeDef(
  ctx: SourcetrailContext, node: PNode, fileId: cint): cint =

  if node[2].kind == nkObjectTy:
    let objectDecl: PObjectDecl =
      try:
        parseObject(node, parsePPragma)

      except:
        echo node
        raise

    let objNameHierarchy = ("", objectDecl.name.head, "")
    let objectSymbol = ctx.writer[].recordSymbol(sskStruct, objNameHierarchy)
    discard ctx.recordNodeLocation(objectSymbol, objectDecl.declNode.get())

    for fld in iterateFields(objectDecl):
      let fldType = fld.fldType.declNode.get()
      # info "Found field", fld.declNode.get(), "of type", toGreen($fldType)

      let fieldSymbol = ctx.writer[].recordSymbol(
        sskField, objNameHierarchy, ("", fld.name, ""))

      if fldType.kind == nkSym:
        let targetHead: string =
          if fldType.sym.ast.isNil:
             $fldType

          else:
            $declHead(fldType.sym.ast)

        var targetType: cint = ctx.writer[].recordSymbol(
          sskStruct, ("", targetHead, ""))

        let referenceId = ctx.writer[].recordReference(
          fieldSymbol, targetType, srkTypeUsage)

        discard ctx.writer[].recordReferenceLocation(
          referenceId, (fileId, fldType))

      discard ctx.recordNodeLocation(fieldSymbol, fld.declNode.get())

  elif node[2].kind == nkEnumTy:
    let enumDecl: PEnumDecl = parseEnum(node)

    let enumName = ("", enumDecl.name, "")
    let enumSymbol = ctx.writer[].recordSymbol(sskEnum, enumName)
    discard ctx.recordNodeLocation(enumSymbol, enumDecl.declNode.get())
    for fld in enumDecl.values:
      let valueSymbol = ctx.writer[].recordSymbol(
        sskEnumConstant,
        enumName, ("", fld.name, ""))

      discard ctx.recordNodeLocation(valueSymbol, fld.declNode.get())

  elif node[2].kind in {nkDistinctTy, nkSym}:
    let aliasSymbol = ctx.writer[].recordSymbol(sskTypedef, ("", $node[0], ""))
    discard ctx.recordNodeLocation(aliasSymbol, node)



proc registerToplevel(ctx: SourcetrailContext, node: PNode) =
  case node.kind:
    of nkProcDeclKinds:
      let filePath = ctx.graph.getFilePath(node).string
      let fileId = ctx.writer[].recordFile(filePath)

      discard ctx.registerProcDef(fileId, node)
    of nkTypeSection:
      for typeDecl in node:
        registerToplevel(ctx, typeDecl)

    of nkTypeDef:
      let filePath = ctx.graph.getFilePath(node).string
      let fileId = ctx.writer[].recordFile(filePath)
      discard ctx.registerTypeDef(node, fileId)


    of nkConstSection:
      discard

    of nkStmtList:
      for subnode in node:
        registerTopLevel(ctx, subnode)

    of nkEmpty:
      discard

    else:
      warn "Unmatched node", node.kind
      debug node


proc passNode(c: PPassContext, n: PNode): PNode =
  result = n
  var ctx = SourcetrailContext(c)

  if sfMainModule in ctx.module.flags:
    registerToplevel(ctx, n)

proc passClose(graph: ModuleGraph; p: PPassContext, n: PNode): PNode =
  discard

proc findNode*(n: PNode; trackPos: TLineInfo): PSym =
  if n.kind == nkSym:
    if n.info.fileIndex == trackPos.fileIndex and
       n.info.line == trackPos.line:

      if trackPos.col in (n.info.col .. n.info.col + n.sym.name.s.len - 1):
        return n.sym

  else:
    for i in 0 ..< safeLen(n):
      let res = findNode(n[i], trackPos)
      if res != nil:
        return res

proc symFromInfo(graph: ModuleGraph; trackPos: TLineInfo): PSym =
  let m = graph.getModule(trackPos.fileIndex)
  if m != nil and m.ast != nil:
    result = findNode(m.ast, trackPos)


proc annotateAst(graph: ModuleGraph, node: PNode) =
  case node.kind:
    of nkLiteralKinds:
      discard

    of nkIdent:
      let sym = graph.symFromInfo(node.info)
      info "------"
      if not sym.isNil:
        echo sym.ast

    else:
      for subnode in items(node):
        annotateAst(graph, subnode)

proc trailAst(writer: var SourcetrailDBWriter, ast: PNode) =
  discard

when isMainModule:
  startColorLogger()

  var writer: SourcetrailDBWriter
  var ptrWriter = addr writer
  let file = "/tmp/test.srctrldb"
  rmFile AbsFile(file)
  discard writer.open(file)

  for file in walkDir(AbsDir "/home/test/tmp/Nim/compiler", AbsFile, recurse = false):
    if file.ext() != "nim" or
       file.name() in [
         "lambdalifting",
         "nimconf",
         "semfields",
         "ccgstmts",
         "semobjconstr"
       ]:
      continue

    info "Processing file", file

    var graph: ModuleGraph = newModuleGraph(file)
    let fileAst: PNode = parsePNode(file)
    registerPass(graph, semPass)

    registerPass(graph, makePass(
      (
        proc(graph: ModuleGraph, module: PSym): PPassContext =
          var context = SourcetrailContext(writer: ptrWriter)
          context.module = module
          context.graph = graph
          return context
      ),
      passNode,
      passClose))

    compileProject(graph)


    info "Finished source analysis for file", file

  discard writer.close()
