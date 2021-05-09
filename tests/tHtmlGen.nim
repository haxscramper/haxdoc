import hmisc/other/[oswrap]
import hmisc/hdebug_misc
import
  haxdoc/[docentry, docentry_io],
  haxdoc/process/[docentry_query, docentry_group],
  haxdoc/generate/html_full

startHax()

let dir = getTempDir() / "tFromSimpleCode"
let db = loadDbXml(dir, "compile-db")

var w = newHtmlWriter(AbsFile "/tmp/page.html")

w.start(hHtml)
w.start(hHead)

w.style({
  "th": @{
    "text-align": "left"
  }
})

w.finish(hHead)

w.start hBody
w.wrap0 hCaption, w.text("Module list")

for module in allItems(db, {dekModule}):
  w.wrap hH1:
    w.wrap0 hCell, w.link(module, module.name)
    w.wrap0 hCell, w.text("some brief documentation")

  w.wrap hTable:
    for t in items(module, dekNewtypeKinds):
      w.wrap </[hRow, hTable]:
        w.wrap hRow:
          w.wrap0 hCell, w.link(t, t.name)
          w.wrap0 hCell, w.text("Type documentat")

        let procs = t.getProcsForType()
        w.wrap </[hRow, hCell{"colspan": "2"}, hTable]:
          for pr in procs:
            w.wrap hRow:
              w.wrap0 hCell, w.link(pr, pr.name & " " & $pr.procType())
              w.wrap0 hCell, w.text("proc")




w.finish hBody
w.finish(hHtml)

echo "compile done"
