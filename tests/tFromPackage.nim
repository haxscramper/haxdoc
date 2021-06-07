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

import std/[tables, sets, options, unittest]

startHax()
startColorLogger()


suite "From project dependency":
  test "From hmisc":
    let
      outDir = getTempDir() / "tFromPackage"

    mkDir outDir

    let db = docDbFromPackage(
      findPackage("hmisc", newVRAny()).get())

    db.writeDbXml(outDir, "package")
    writeSourcetrailDb(db, outDir /. "package")

    if hasCmd(shellCmd("dot")):
      db.inheritDotGraph().toPng(AbsFile "/tmp/hmisc-inherit.png")
      db.structureDotGraph().toPng(outDir /. "structure.png")

suite "From regular package":
  test "in /tmp":
    let
      inDir = getTempDir() / "inPackage"
      outDir = getTempDir() / "tFromTmpPackage"

    if exists(inDir):
      mkDir outDir
      let info = getPackageInfo(inDir)
      echo info.projectPath()
      echo info.projectImportPath()
      let db = docDbFromPackage(info)

      writeSourcetrailDb(db, outDir /. "fromPackage")
      writeDbXml(db, outDir, "fromPackage")

    else:
      echo "Directory ", inDir, " does not exist, skipping test"
