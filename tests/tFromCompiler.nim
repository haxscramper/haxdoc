import hmisc/other/[oswrap, colorlogger, hshell]
import
  haxdoc/extract/from_nim_code,
  haxdoc/process/[docentry_group],
  haxdoc/[docentry, docentry_io],
  haxdoc/generate/sourcetrail_db


import cxxstd/cxx_common
import nimtrail/nimtrail_common
import hnimast/compiler_aux

let
  outDir = getTempDir() / "tFromCompiler"
  compPackage = findPackage("compiler", newVRAny())


startColorLogger()

if compPackage.isNone():
  err "Failed to find package `compiler`, skipping compiler analysis test"


let
  compDir = compPackage.get().getRealDir().AbsDir()
  compFile = compDir /. "compiler/nim.nim"

mkDir outDir

info "Using compiler source dir ", compDir
info "Starting compilation from ", compFile

let db = generateDocDb(compFile, fileLib = some("compiler"))
echo "Db compilation done"

let dot = db.inheritDotGraph()
if hasCmd(shellCmd(dot)):
  dot.toPng(AbsFile "/tmp/compiler-inherit.png")
  echo "Inhertiance graph for compiler done"
else:
  echo "no dot installed, skipping graph generation"

db.writeSourcetrailDb(outDir /. "tFromCompiler")
echo "Registered sourcetrail DB"
