import
  ../src/haxdoc

import
  hmisc/other/oswrap

let file = getAppTempFile("intrail.nim")
file.writeFile("echo 12")
haxdocCli(@["nim", "trail", $file])
