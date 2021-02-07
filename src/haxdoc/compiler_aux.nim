import hmisc/other/[colorlogger, oswrap]
import hmisc/helpers
import hmisc/types/[colortext]

export colorizeToStr

export colorlogger

import std/[with]

import compiler /
  [ idents, options, modulegraphs, passes, lineinfos, sem, pathutils, ast,
    modules, condsyms, passaux, llstream, parser, nimblecmd
  ]

export idents, options, modulegraphs, passes, lineinfos, sem, pathutils,
    ast, modules, condsyms, passaux, llstream, parser

import compiler/astalgo except debug

export astalgo except debug

template debug*(node: PNode) {.dirty.} =
  log(lvlDebug, @[
    $instantiationInfo(),
    "\n",
    colorizeToStr($node, "nim")
  ])




proc newModuleGraph*(
    file: AbsFile,
    path: AbsDir,
    structuredErrorHook: proc(
      config: ConfigRef; info: TLineInfo; msg: string; level: Severity
    ) {.closure, gcsafe.} = nil
  ): ModuleGraph =

  var
    cache: IdentCache = newIdentCache()
    config: ConfigRef = newConfigRef()


  with config:
    libpath = AbsoluteDir(path)
    cmd = cmdIdeTools

  config.verbosity = 0
  config.options -= optHints
  config.searchPaths.add @[
    config.libpath,
    path / "pure",
    path / "pure" / "collections",
    path / "pure" / "concurrency",
    path / "impure",
    path / "std",
    path / "core",
    path / "posix",
    path / "wrappers"
  ]

  config.projectFull = file
  # config.excludeAllNotes(hintLineTooLong)


  config.structuredErrorHook = structuredErrorHook
    # proc(config: ConfigRef; info: TLineInfo; msg: string; level: Severity) =
    #   discard
    #   err msg

  wantMainModule(config)

  initDefines(config.symbols)
  defineSymbol(config.symbols, "nimcore")
  defineSymbol(config.symbols, "c")
  defineSymbol(config.symbols, "ssl")
  nimblePath(config, ~".nimble/pkgs", TLineInfo())

  return newModuleGraph(cache, config)
