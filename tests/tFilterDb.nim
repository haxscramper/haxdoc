import hmisc/other/[oswrap, colorlogger]
import hmisc/hdebug_misc
import std/[colors, options]
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
  let groups = group.splitCommonProcs()
  echo "  common procs"
  for pr in groups.procs.nested[0]:
    echo "    ", pr.name, " ", pr.procType()

  echo "  other procs"
  for pr in groups.procs.nested[1]:
    echo "    ", pr.name, " ", pr.procType()


db.inheritDotGraph().toPng(AbsFile "/tmp/inherit.png")
db.usageDotGraph().toPng(AbsFile "/tmp/usage.png")
