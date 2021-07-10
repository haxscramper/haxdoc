import
  ../src/haxdoc

import
  hmisc/other/oswrap

let file = getAppTempFile("intrail.nim")
file.writeFile("echo 12")

let dir = getTempDir() / "tHaxdocCliProject"

mkWithDirStructure(dir):
  file "project.nimble":
    "srcDir = \"src\""

  dir "src":
    file "project.nim":
      "echo 12"

withDir dir:
  haxdocCli(@["nim", "trail", "project.nimble"])
