{.experimental: "caseStmtMacros".}

import std/[os, strformat, with]
import hmisc/other/oswrap
# import hnimast except nkStrKinds
import fusion/matching
import nimtrail/cli/sourcetrail_nim
import nimtrail/[
  name_hierarchy, symbol_kind, definition_kind,
  reference_kind, sourcetrail_d_b_writer
]

import compiler /
  [ idents, options, modulegraphs, passes, lineinfos, sem, pathutils, ast,
    astalgo, modules, condsyms, passaux, llstream, parser, renderer
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

proc registerToplevel(ctx: SourcetrailContext, node: PNode) =
  # node.debug()
  case node:
    of ProcDef[@name, .._]:
      echo "Found proc declaration with name ", $name
      discard ctx.writer[].recordSymbol(
        ("::", @[("zzz", $name, "()")]), sskFunction)

proc passOpen(graph: ModuleGraph; module: PSym): PPassContext =
  SourcetrailContext(module: module)

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

const
  nkStrKinds* = { nkStrLit .. nkTripleStrLit }
  nkIntKinds* = { nkCharLit .. nkUInt64Lit }
  nkFloatKinds* = { nkFloatLit .. nkFloat128Lit }

proc annotateAst(graph: ModuleGraph, node: PNode) =
  case node.kind:
    of nkStrKinds, nkIntKinds, nkFloatKinds:
      discard

    of nkIdent:
      let sym = graph.symFromInfo(node.info)
      echo "------"
      if not sym.isNil:
        echo sym.ast

    else:
      for subnode in items(node):
        annotateAst(graph, subnode)

proc trailAst(writer: var SourcetrailDBWriter, ast: PNode) =
  discard

when isMainModule:

  let file = AbsFile("/tmp/file.nim")

  file.writeFile("""
proc hello(): int = 12
proc hello2(arg: int): int = 12
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
          return context
      ),
      passNode,
      passClose))

    compileProject(graph)

    discard context.writer[].close()
