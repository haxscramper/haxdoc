import hmisc/other/[oswrap, colorlogger]
import hmisc/hdebug_misc
import
  haxdoc/[docentry, docentry_io],
  haxdoc/process/[docentry_query, docentry_group]

startHax()

let dir = getTempDir() / "tFromSimpleCode"
let db = loadDbXml(dir, "compile-db")

for entry in db.allMatching(docFilter("seq")):
  let procs = entry.getProcsForType()
  for pr in procs:
    echo pr.name, " ", pr.procType()

let (groups, other) = db.procsByTypes()

for group in groups:
  echo group.typeEntry.name
  for pr in group.procs:
    echo "  ", pr.name, " ", pr.procType()
