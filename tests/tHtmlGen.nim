import hmisc/other/[oswrap]
import hmisc/hdebug_misc
import
  haxdoc/[docentry, docentry_io],
  haxdoc/process/[docentry_query, docentry_group],
  haxdoc/generate/html_full

startHax()

let dir = getTempDir() / "tFromSimpleCode"
let db = loadDbXml(dir, "compile-db")

for entry in db.allMatching(docFilter("seq")):
  let procs = entry.getProcsForType()
  for pr in procs:
    echo pr.name, " ", pr.procType(), " ", pr.fullIdent.toLink()
