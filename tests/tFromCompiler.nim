import hmisc/other/[oswrap, colorlogger]
import
  haxdoc/extract/from_nim_code,
  haxdoc/[docentry, docentry_io],
  haxdoc/generate/sourcetrail_db


import cxxstd/cxx_common
import nimtrail/nimtrail_common
import hnimast/compiler_aux

let
  outDir = getTempDir() / "tFromCompiler"
  compDir = getInstallationPath()
  compFile = compDir /. "compiler/nim.nim"

mkDir outDir

startColorLogger()

info compFile

let db = generateDocDb(compFile, compDir / "lib", @[])
echo "Db compilation done"
# db.writeDbXml(outDir, "compile-db")
# echo "Wrote db xml"

var writer: SourcetrailDbWriter
writer.open(outDir /. "tFromCompiler" &. sourcetrailDbExt)

writer.registerFullDb(db)
echo "Registered sourcetrail DB"
discard writer.close()
