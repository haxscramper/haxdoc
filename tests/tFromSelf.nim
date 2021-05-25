# Generate documentation database for haxdoc itself.

import
  haxdoc/extract/[from_nim_code],
  haxdoc/generate/sourcetrail_db,
  hnimast/compiler_aux

import
  hmisc/other/[oswrap, colorlogger],
  hmisc/hdebug_misc,
  hmisc/algo/hseq_distance

startHax()
startColorLogger()

let dir = getNewTempDir("tFromSelf")

let db = docDbFromPackage(
  findPackage("haxdoc", newVRAny()).get(),
  ignored = @[**"**/haxdoc.nim"])

db.writeSourcetrailDb(dir /. "tFromSelf")
