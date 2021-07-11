import
  ../src/haxdoc,
  ../src/haxdoc/[
    extract/from_nim_code,
    process/docdb_diff,
    docentry
  ]

import
  hmisc/other/oswrap

import
  std/unittest

let
  dir = getAppTempDir()
  oldFile = dir /. "oldFile.nim"
  newFile = dir /. "newFile.nim"
  oldDbDir = dir / "oldDb"
  newDbDir = dir / "newDb"

  commonMain = """

proc main() =
  changeSideEffect()
  changeRaiseAnnotation()
  changeImplementation()
"""

  oldCode = """
proc changeSideEffect() = discard
proc changeRaiseAnnotation() = discard
proc changeImplementation() = discard
"""

  newCode = """
proc changeSideEffect() = echo "werwer"
proc changeRaiseAnnotation() = raise newException(OsError, "w23423")
proc changeImplementation() =
  for i in [0, 1, 3]:
    discard i
"""

oldFile.writeFile(oldCode & commonMain)
newFile.writeFile(newCode & commonMain)


suite "API usage":
  test "Simple comparison":
    let
      oldDb = generateDocDb(oldFile)
      newDb = generateDocDb(newFile)
      diffDb = diffDb(oldDb, newDb)

    let
      diffLines = diffDb.diffFile(
        oldDb.getFile(oldFile),
        newDb.getFile(newFile)
      )


suite "Command line usage":
  test "Simple comparison":
    rmDir oldDbDir
    rmDir newDbDir
    withDir dir:
      haxdocCli(@["nim", "xml", "--outdir=" & $oldDbDir, $oldFile])
      haxdocCli(@["nim", "xml", "--outdir=" & $newDbDir, $newFile])
      haxdocCli(@["diff", $oldDbDir, $newDbDir])
