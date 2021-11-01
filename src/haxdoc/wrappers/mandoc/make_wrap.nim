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
  it.baseDir   = toAbsDir(inDir)
  it.nimOutDir = resDir
  it.wrapName  = "mandoc"
  it.depsConf  = @[cstd_wrap.wrapConf, baseCWrapConf]

  it.getSavePathImpl = (
    proc(file: AbsFile, conf: WrapConf): LibImport =
      result = baseCWrapConf.getSavePathImpl(file, conf)
      result.addPathPrefix "tmp"
  )

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
        toScopedIdent("mparse_open") : negativeError("Cannot open file", {1}),
      })
  )

  it.userCode = (
    proc(file: WrappedFile): tuple[node: PNode, position: WrappedEntryPos] =
      result.position = wepBeforeAll
      result.node = pquote do:
        import mandoc_common
  )


when isMainModule:
  randomize()

  wrapConf.logger = newTermLogger(file = true, line = true)
  wrapConf.logger.leftAlignFiles = 18

  var files: seq[AbsFile]
  for file in walkDir(inDir, AbsFile, exts = @["h"]):
    if file.name() in [
      "mandoc", "roff", "mdoc", "manconf", "mansearch",
      "mandoc_aux", "mandoc_parse", "main", "tbl", "eqn"
    ]:
      files.add file

  discard wrapAllFiles(files, wrapConf, parseConf)

  wrapConf.notice "Conversion done"
  execShell shellCmd(
    nim, c, -r, warnings = off, "tests/tUsingNim.nim")

  wrapConf.notice "compilation ok"
