import hmisc/other/[oswrap]
import hmisc/hdebug_misc
import
  haxdoc/[docentry, docentry_io],
  haxdoc/process/[docentry_query, docentry_group],
  haxdoc/generate/html_full

startHax()

let dir = getTempDir() / "tFromSimpleCode"
let db = loadDbXml(dir, "compile-db")


var w = stdout.newHtmlWriter()

for module in allItems(db, {dekModule}):
  w.link(module, module.name)

for docType in allItems(db, dekStructKinds):
  w.link(docType, docType.name)
  let procs = docType.getProcsForType()
  # for pr in procs:
  #   echo pr.name, " ", pr.procType(), " ", pr.fullIdent.toLink()
