## Create documentation database for a package

import
  haxdoc/extract/[from_nim_code],
  haxdoc/generate/[sourcetrail_db],
  haxdoc/process/[docentry_group],
  haxdoc/[docentry_io],
  hnimast/compiler_aux

import
  hmisc/[hdebug_misc],
  hmisc/other/[colorlogger, oswrap, hshell]

import
  hpprint

import std/[tables, sets, options]

startHax()
startColorLogger()

let
  outDir = getTempDir() / "tFromPackage"

mkDir outDir

let db = docDbFromPackage(
  findPackage("hmisc", newVRAny()).get(), getStdPath())

db.writeDbXml(outDir, "package")
writeSourcetrailDb(db, outDir /. "package")

if hasCmd(shellCmd("dot")):
  db.inheritDotGraph().toPng(AbsFile "/tmp/hmisc-inherit.png")
