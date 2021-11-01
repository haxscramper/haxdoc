import
  hmisc/other/[oswrap, hshell, hlogger],
  hmisc/core/all


import
  haxdoc/extract/from_nim_code,
  haxdoc/process/[docentry_group],
  haxdoc/[docentry, docentry_io],
  haxdoc/generate/sourcetrail_db


import cxxstd/cxx_common
import nimtrail/nimtrail_common
import hnimast/[compiler_aux]

let
  outDir = getTempDir() / "tFromCompiler"

startHax()


let
  compDir = getStdPath().dir()
  compFile = compDir /. "compiler/nim.nim"
  l = newTermLogger()

mkDir outDir

l.info "Using compiler source dir ", compDir
l.info "Starting compilation from ", compFile

let db = generateDocDb(
  compFile,
  fileLib = some("compiler"),
  defines = @["nimpretty", "haxdoc", "nimdoc"],
  logger  = l
)

echo "Db compilation done"

let dot = db.inheritDotGraph()
if hasCmd(shellCmd(dot)):
  dot.toPng(AbsFile "/tmp/compiler-inherit.png")
  echo "Inhertiance graph for compiler done"
else:
  echo "no dot installed, skipping graph generation"

db.writeSourcetrailDb(outDir /. "tFromCompiler")
echo "Registered sourcetrail DB"
