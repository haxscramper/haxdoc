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
db.writeDbXml(outDir, "compile-db")

var writer: SourcetrailDbWriter
writer.open(outDir /. "db" &. sourcetrailDbExt)

writer.registerFullDb(db)

discard writer.close()
