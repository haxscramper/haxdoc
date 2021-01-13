{.experimental: "caseStmtMacros".}

import std/[os, strformat, with, lenientops, strutils, sequtils]
import hmisc/other/[colorlogger, oswrap]
import hmisc/types/colortext
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

  result.fileId = arg.fileId
  result.startLine = arg.ranges[0].cint
  result.startColumn = arg.ranges[1].cint
  result.endLine = arg.ranges[2].cint
  result.endColumn = arg.ranges[3].cint

converter toSourcetrailSourceRange*(
  arg: tuple[file: cint, name: PNode]): SourcetrailSourceRange =
  toSourcetrailSourcerange((arg.file, [
    arg.name.info.line.int16,
    arg.name.info.col + 1,
    arg.name.info.line.int16,
    arg.name.info.col + len($arg.name).int16
  ]))

const
  nkStrKinds* = { nkStrLit .. nkTripleStrLit }
  nkIntKinds* = { nkCharLit .. nkUInt64Lit }
  nkFloatKinds* = { nkFloatLit .. nkFloat128Lit }
  nkLiteralKinds* = nkStrKinds + nkIntKinds + nkFloatKinds

proc registerProc(writer: var SourcetrailDBWriter, procDef: PNode): cint =
  [@name, _, _, [@returnType, all @arguments], .._] := procDef

  result = writer.recordSymbol(
        ("::", @[($returnType,
                  $name,
                  "(" & arguments.mapIt($it).join(", ") & ")")]), sskFunction)

template debug(node: PNode) {.dirty.} =
  log(lvlDebug, @[
    $instantiationInfo(),
    "\n",
    colorizeToStr($node, "nim")
    # "\n"
  ])

proc registerCalls(
    writer: var SourcetrailDBWriter,
    node: PNode,
    fileId, callerId: cint
  ) =

  case node.kind:
    of nkSym:
      if node.sym.kind in routineKinds:
        debug "found proc call '", $node, "' "
        debug node.sym.ast
        let referencedSymbol = writer.registerProc(node.sym.ast)

        let referenceId = writer.recordReference(callerId, referencedSymbol, srkCall)
        discard writer.recordReferenceLocation(referenceId, (fileId, node))


    of nkLiteralKinds:
      discard

    else:
      for subnode in mitems(node.sons):
        writer.registerCalls(subnode, fileId, callerId)

iterator iterateFields*(objDecl: PObjectDecl): PObjectField =
  proc getSubfields(field: PObjectField): seq[PObjectField] =
    for branch in field.branches:
      for field in branch.flds:
        result.add field

  for field in objDecl.flds:
    iterateItDFS(field, it.getSubfields(), it.isKind, dfsPostorder):
      yield it

proc registerTypeDef(
  writer: var SourcetrailDBWriter, node: PNode, fileId: cint): cint =

  let objDecl: PObjectDecl = parseObject(node, parsePPragma)

  let name = objDecl.name

  info "Found type declaration"
  debug name.toNNode()

  for fld in iterateFields(objDecl):
    info "Found field"
    debug fld.toNNode()



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


proc registerToplevel(ctx: SourcetrailContext, node: PNode) =
  case node:
    of ProcDef[@name, _, _, _, _, _, @implementation, .._]:
      let symbolId = ctx.writer[].registerProc(node)
      let fileId = ctx.recordNodeLocation(symbolId, name)

      logIndented:
        ctx.writer[].registerCalls(implementation, fileId, symbolId)

    of TypeSection():
      for typeDecl in node:
        registerToplevel(ctx, typeDecl)

    of TypeDef():
      let filePath = ctx.graph.getFilePath(node).string
      let fileId = ctx.writer[].recordFile(filePath)
      discard ctx.writer[].registerTypeDef(node, fileId)

    else:
      info node.kind
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
    of nkStrKinds, nkIntKinds, nkFloatKinds:
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
