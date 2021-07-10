import
  ../src/haxdoc

import
  hmisc/other/oswrap

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

withDir dir:
  haxdocCli(@["nim", "xml", "--outdir=" & $oldDbDir, $oldFile])
  haxdocCli(@["nim", "xml", "--outdir=" & $newDbDir, $newFile])
  haxdocCli(@["diff", $oldDbDir, $newDbDir])
