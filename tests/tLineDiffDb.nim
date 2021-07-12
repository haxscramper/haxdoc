import
  ../src/haxdoc,
  ../src/haxdoc/[
    extract/from_nim_code,
    process/docdb_diff,
    docentry,
    docentry_io
  ]

import
  hmisc/other/[oswrap, hpprint],
  hmisc/hdebug_misc

import
  std/unittest

startHax()

let
  dir = getAppTempDir()
  oldDir = dir / "old"
  newDir = dir / "new"
  oldFile = oldDir /. "file.nim"
  newFile = newDir /. "file.nim"
  oldDbDir = oldDir / "oldDb"
  newDbDir = newDir / "newDb"
  commonMain = """

proc main() =
  changeSideEffect()
  changeRaiseAnnotation()
  changeImplementation()
  # proc1(); proc2(); proc3()
"""

  oldCode = """
proc writeIoEffect() {.tags: [ReadIoEffect].} = discard

proc changeSideEffect() = discard

proc changeRaiseAnnotation() = discard

proc changeImplementation() = discard

# proc proc1() = discard
# proc proc2() = discard
# proc proc3() = discard
"""

  newCode = """
proc writeIoEffect() {.tags: [ReadIoEffect].} = discard

proc changeSideEffect() =
  writeIoEffect()
  echo 12 #< Does not correctly track write io effect, idk why

proc changeRaiseAnnotation() = raise newException(OsError, "w23423")

proc changeImplementation() =
  for i in [0, 1, 3]:
    discard i

# proc proc1() {.raises: [OsError].} = discard
# proc proc2() {.tags: [IOEffect].} = discard
# proc proc3() = ##[ Documentation update ]## discard
"""

mkDir dir
mkDir oldDir
mkDir newDir
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

    # pprint oldDb.getFile(oldFile).body.codeLines, ignore = matchField("parts")
    # pprint newDb.getFile(newFile).body.codeLines, ignore = matchField("parts")

    # pprint diffLines, ignore = matchField("parts")

    echo formatDiff(diffDb, diffLines)


suite "Command line usage":
  test "Simple comparison":
    rmDir oldDbDir
    rmDir newDbDir
    withDir dir:
      haxdocCli(@["nim", "xml", "--outdir=" & $oldDbDir, $oldFile])
      haxdocCli(@["nim", "xml", "--outdir=" & $newDbDir, $newFile])
      haxdocCli(@["diff", $oldDbDir, $newDbDir])
