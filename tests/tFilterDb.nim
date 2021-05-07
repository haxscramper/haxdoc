import hmisc/other/[oswrap, colorlogger]
import hmisc/hdebug_misc
import
  haxdoc/[docentry, docentry_io],
  haxdoc/process/docentry_query

startHax()

let dir = getTempDir() / "tFromSimpleCode"
let db = loadDbXml(dir, "compile-db")

echo "db load done"

echo db.entries.len


for entry in db.allMatching(docFilter("seq")):
  echo entry.name
  let procs = entry.getProcsForType()
  for pr in procs:
    echo pr.name
