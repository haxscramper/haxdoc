import hcparse/[wrap_common]
import std/[sugar, random]

import cstd/make_wrap as cstd_wrap

const sourceDir* = AbsDir(currentSourcePath()).splitDir().head

let
  resdir = cwd()
  inDir = toAbsDir("mandoc-1.14.5")

let parseConf = baseCppParseConf.withIt do:
  it.globalFlags = @[
    "-xc",
    "--include-with-prefix=/usr/include/c++/10.2.0/bits/",
    "--include=sys/types.h",
    "--include=stdio.h"
  ]

let wrapConf = baseCWrapConf.withDeepIt do:
  it.baseDir = toAbsDir(inDir)
  it.nimOutDir = resDir
  it.wrapName = some "mandoc"
  it.ignoreCursor = (
    proc(cursor: CXCursor, conf: WrapConf): bool {.closure.} =
      if cursor.isFromFile(inDir /. "main.h"):
        return $cursor in ["manoutput", "roff_meta"]

      if cursor.isFromFile(inDir /. "mdoc.h"):
        return $cursor in ["roff_node"]

      elif cursor.isFromFile(inDir /. "mandoc_parse.h"):
        return $cursor in ["roff_meta"]

      elif cursor.isFromFile(inDir /. "roff.h"):
        return $cursor in ["tbl_span"]

      else:
        baseCWrapConf.ignoreCursor(cursor, conf)
  )

  it.makeHeader = (
    proc(cursor: CXCursor, conf: WrapConf): NimHeaderSpec {.closure.} =
      # info cursor, "is from dir", inDir, "? :", cursor.isFromDir(inDir)
      if cursor.isFromDir(inDir):
        initHeaderSpec newPIdent("allHeaders")

      else:
        initHeaderSpec cursor.asIncludeFromDir(conf, inDir)
  )

  it.setPrefixForEnum @{
    "mandoclevel" : "ml",
    "mandocerr" : "me",
    "mandoc_esc" : "msc",
    "mandoc_os" : "mdos",
    "MANDOC": "mdc",
    "ASCII": "ma",
    "MODE": "mode",
    "TYPE": "mtype",
    "MPARSE": "mp",
    "NODE": "mn"
  }

  it.newProcCb = (
    proc(
      genProc: var GenProc, conf: WrapConf, cache: var WrapCache
    ): seq[WrappedEntry] =
      return errorCodesToException(genProc, conf, cache, @{
        toScopedIdent("mparse_open") : negativeError("Cannot open file"),
      })
  )

  it.getImport = (
    proc(dep: AbsFile, conf: WrapConf, isExternal: bool):
      NimImportSpec {.closure.} =

      return conf.getImportUsingDependencies(
        dep,
        @[cstd_wrap.wrapConf, baseCWrapCOnf],
        isExternal
      )
  )

  it.userCode = (
    proc(file: WrappedFile): tuple[node: PNode, postTypes: bool] =
      result.node = pquote do:
        import mandoc_common
  )


when isMainModule:
  startColorLogger(showFile = true)
  startHax()
  randomize()

  var files: seq[AbsFile]
  for file in walkDir(inDir, AbsFile, exts = @["h"]):
    if file.name() in [
      "mandoc", "roff", "mdoc", "manconf", "mansearch",
      "mandoc_aux", "mandoc_parse", "main", "tbl", "eqn"
    ]:
      files.add file

    # else:
    #   info "Skipping", file.name()

  wrapAllFiles(files, wrapConf, parseConf)

  # for file in files:
  #   info file
  #   let res = cwd() / file.withExt("nim")
  #   wrapWithConfig(inDir / file, res, wrapConf, parseCOnf)

  for file in wrapConf.nimOutDir.walkDir(AbsFile, exts = @["nim"]):
    execShell shellCmd(nim, check, warnings = off, errormax = 1, $file)

  # info "Nimmandoc wrapper finished"

  # execShell shCmd(nim, c, warnings=off, "../../tests/tUsingNim.nim")

echo "done"
