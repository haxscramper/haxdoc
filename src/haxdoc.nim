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
    astalgo, modules, condsyms, passaux, llstream, parser
  ]

{.push inline.}

func `-`*[E](s1: set[E], s2: E): set[E] = s1 - {s2}
func `-=`*[E](s1: var set[E], v: E | set[E]) = (s1 = s1 - {v})

{.pop.}


converter toAbsoluteDir*(dir: AbsDir): AbsoluteDir =
  AbsoluteDir(dir.string)

converter toAbsoluteFile*(file: AbsFile): AbsoluteFile =
  AbsoluteFile(file.string)

proc parsePNode(file: AbsFile): PNode =
  let cache: IdentCache = newIdentCache()
  let config: ConfigRef = newConfigRef()
  var pars: Parser

  openParser(
    p = pars,
    filename = file,
    inputStream = llStreamOpen(file, fmRead),
    cache = cache,
    config = config
  )

  result = parseAll(pars)
  closeParser(pars)

proc newModuleGraph(file: AbsFile): ModuleGraph =
  var
    cache: IdentCache = newIdentCache()
    config: ConfigRef = newConfigRef()

  let path = ~".choosenim/toolchains/nim-1.4.0/lib"

  with config:
    verbosity = 0
    libpath = AbsoluteDir(path)
    cmd = cmdIdeTools

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
  case node.kind:
    of nkTypeDef, nkRecCase, nkIdentDefs, nkProcDef:
      result = declHead(node[0])

    of nkSym, nkIdent:
      result = node

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

proc parseNidentDefs(node: PNode): NIdentDefs[PNode] =
  for arg in node[0..^3]:
    result.idents.add arg

proc `arguments=`(procDecl: var PProcDecl, arguments: seq[NIdentDefs[PNode]]) =
  procDecl.signature.arguments = arguments

proc `arguments`(procDecl: var PProcDecl): var seq[NIdentDefs[PNode]] =
  procDecl.signature.arguments

iterator argumentIdents*[N](procDecl: ProcDecl[N]): N =
  for argument in procDecl.signature.arguments:
    for ident in argument.idents:
      yield ident

proc parseProc*(node: PNode): PProcDecl =
  result = newPProcDecl(":tmp")

  case node.kind:
    of nkProcDef:
      case node[0]:
        of (kind: in {nkSym, nkIdent}, getStrVal: @name):
          result.name = name

        else:
          # err "Unexpected node structure"
          raiseImplementError("")


      case node[1]:
        of Empty():
          discard

        else:
          raiseImplementError("Term rewriting arguments")

      case node[2]:
        of Empty():
          discard

        else:
          raiseImplementError("Generic params parsing")

      for arg in node[3][1..^1]:
        result.arguments.add parseNidentDefs(arg)

      result.impl = node[6]

    else:
      err "Unexpected node kind", node.kind
      raiseImplementError("")

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

proc getFilePath(graph: ModuleGraph, node: PNode): AbsoluteFile =
  ## Get absolute file path for declaration location of `node`
  graph.config.m.fileInfos[node.info.fileIndex.int32].fullPath



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

  case node.kind:
    of nkSym:
      if node.sym.kind in routineKinds:
        let referencedSymbol = ctx.writer[].getProcId(parseProc(node.sym.ast))

        let referenceId = ctx.writer[].recordReference(callerId, referencedSymbol, srkCall)
        discard ctx.writer[].recordReferenceLocation(referenceId, (fileId, node))

      elif node.sym.kind in {skParam}:
        info "Found symbol", node.sym, "of kind", node.sym.kind

        let localId = ctx.writer[].recordLocalSymbol($node.sym)
        discard ctx.writer[].recordLocalSymbolLocation(localId, (fileId, node))


    of nkLiteralKinds:
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

template debug(node: PNode) {.dirty.} =
  log(lvlDebug, @[
    $instantiationInfo(),
    "\n",
    colorizeToStr($node, "nim")
    # "\n"
  ])

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
    let objectDecl: PObjectDecl = parseObject(node, parsePPragma)
    info "Found object declaration", objectDecl.name.head

    let objNameHierarchy = ("", objectDecl.name.head, "")
    let objectSymbol = ctx.writer[].recordSymbol(sskStruct, objNameHierarchy)
    discard ctx.recordNodeLocation(objectSymbol, objectDecl.declNode.get())

    for fld in iterateFields(objectDecl):
      # info "Found field"
      # debug fld.declNode.get()
      let fieldSymbol = ctx.writer[].recordSymbol(
        sskField, objNameHierarchy, ("", fld.name, ""))

      discard ctx.recordNodeLocation(fieldSymbol, fld.declNode.get())

  elif node[2].kind == nkEnumTy:
    let enumDecl: PEnumDecl = parseEnum(node)
    info "Found eunm declaration", enumDecl.name

    let enumName = ("", enumDecl.name, "")
    let enumSymbol = ctx.writer[].recordSymbol(sskEnum, enumName)
    discard ctx.recordNodeLocation(enumSymbol, enumDecl.declNode.get())
    for fld in enumDecl.values:
      let valueSymbol = ctx.writer[].recordSymbol(
        sskEnumConstant,
        enumName, ("", fld.name, ""))

      discard ctx.recordNodeLocation(valueSymbol, fld.declNode.get())

  elif node[2].kind in {nkDistinctTy, nkSym}:
    info "Found type alias"
    let aliasSymbol = ctx.writer[].recordSymbol(sskTypedef, ("", $node[0], ""))
    discard ctx.recordNodeLocation(aliasSymbol, node)



proc registerToplevel(ctx: SourcetrailContext, node: PNode) =
  const procDecls = {nkProcDef}
  case node:
    of (kind: in procDecls, [@name, _, _, _, _, _, @implementation, .._]):
      let filePath = ctx.graph.getFilePath(node).string
      let fileId = ctx.writer[].recordFile(filePath)

      discard ctx.registerProcDef(fileId, node)
    of TypeSection():
      for typeDecl in node:
        registerToplevel(ctx, typeDecl)

    of TypeDef():
      let filePath = ctx.graph.getFilePath(node).string
      let fileId = ctx.writer[].recordFile(filePath)
      discard ctx.registerTypeDef(node, fileId)

    else:
      warn "Unmatched node", node.kind
      debug node


proc passNode(c: PPassContext, n: PNode): PNode =
  result = n
  if sfMainModule in SourcetrailContext(c).module.flags:
    registerToplevel(SourcetrailContext(c), n)

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
  let file = AbsFile("/tmp/file.nim")

  file.writeFile("""

type
  Obj = object
    fld1: int
    case isRaw: bool
      of true:
        fld2: float

      of false:
        fld3: string

  Enum = enum
    enFirst
    enSecond


  DistinctAlias = distinct int
  Alias = int

proc hello(): int =
  ## Documentation comment 1
  return 12

proc nice(): int =
  ## Documentation comment 2
  return 200

proc hello2(arg: int): int =
  return hello() + arg + nice()

proc hello3(obj: Obj): int =
  return obj.fld1

proc hello4(arg1, arg2: int, arg3: string): int =
  result = arg1 + hello3(Obj(fld1: arg2)) + hello2(arg3.len)
  if result > 10:
    echo "result > 10"

  else:
    result += hello4(arg1, arg2, arg3)

""")

  var graph: ModuleGraph = newModuleGraph(file)
  let fileAst: PNode = parsePNode(file)
  registerPass(graph, semPass)

  if false:
    compileProject(graph)
    annotateAst(graph, fileAst)

  else:
    var writer: SourcetrailDBWriter
    var context = SourcetrailContext(writer: addr writer)
    let file = "/tmp/test.srctrldb"
    rmFile AbsFile(file)
    discard context.writer[].open(file)

    registerPass(graph, makePass(
      (
        proc(graph: ModuleGraph, module: PSym): PPassContext =
          context.module = module
          context.graph = graph
          return context
      ),
      passNode,
      passClose))

    compileProject(graph)

    discard context.writer[].close()
