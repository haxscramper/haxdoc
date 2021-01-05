{.experimental: "caseStmtMacros".}

import std/[os, strformat]
import hmisc/other/oswrap
import fusion/matching
import compiler /
  [ idents, options, modulegraphs, passes, lineinfos, sem, pathutils, ast,
    astalgo, modules, condsyms, passaux
  ]

let file = "/tmp/ee.nim"

file.writeFile("""
proc test*(arg: int) =
  ## Documentation for proc `test`
  ##
  ## - @arg{arg} :: Input argument
  echo arg
""")


var graph: ModuleGraph = block:
  var
    cache: IdentCache = newIdentCache()
    config: ConfigRef = newConfigRef()

  let path = ~".choosenim/toolchains/nim-1.4.0/lib"

  config.libpath = AbsoluteDir(path)
  config.searchPaths.add config.libpath
  config.projectFull = AbsoluteFile(file)
  initDefines(config.symbols)

  newModuleGraph(cache, config)


type
  CustomContext = ref object of PPassContext
    module: PSym

proc passOpen(graph: ModuleGraph; module: PSym): PPassContext =
  CustomContext(module: module)

proc passNode(c: PPassContext, n: PNode): PNode =
  let c = CustomContext(c)
  result = n
  if sfMainModule in c.module.flags:
    case n:
      of ProcDef[^1 is [any @comments is CommentStmt()]]:
        for comment in comments:
          echo comment.comment

    # [any @comments is CommentStmt()] := n[^1]
    # debug(n)
    # echo n.comment
    # echo n.kind

proc passClose(graph: ModuleGraph; p: PPassContext, n: PNode): PNode =
  discard


registerPass(graph, semPass)
registerPass(graph, makePass(passOpen, passNode, passClose))
compileProject(graph)
