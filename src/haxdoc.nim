import haxdoc/[docentry, compiler_aux]
import std/[streams, json]

import hmisc/other/[colorlogger, oswrap, hjson]
import hmisc/helpers
import hmisc/types/[colortext, colorstring]
import hmisc/algo/htree_mapping
import hnimast


type
  DocContext = ref object of PPassContext
    db*: DocDB
    module*: PSym
    graph*: ModuleGraph

proc toJson*(doctype: DocType): JsonNode =
  %1

proc toJson*(doctext: DocText): JsonNode =
  %1

proc toJson*(entry: DocEntry): JsonNode =
  result = newJObject()
  for name, val in fieldPairs(entry[]):
    result[name] = toJson(val)

proc writeJson*(entry: DocEntry, s: Stream) =
  s.writeLine(pretty(toJson(entry)))

proc writeJson*(db: DocDB, target: AnyFile) =
  let file = openFileStream(target.getStr(), fmWrite)
  for entry in db.entries:
    writeJson(entry, file)

proc registerTopLevel(ctx: DocContext, n: PNode) =
  debug n
  debug n.kind

  case n.kind:
    of nkProcDef:
      let parsed = parseProc(n)

      ctx.db.entries.add DocEntry(
        plainName: parsed.name,
        kind: dekProc
      )

    else:
      discard

when isMainModule:
  startColorLogger()

  let file = AbsFile("/tmp/intest.nim")
  file.writeFile("""

proc hhh() =
  ## Documentation
  echo "123"

hhh()

""")


  var graph = newModuleGraph(file)
  graph.registerPass(semPass)

  var db = DocDB()

  graph.registerPass(makePass(
    (
      proc(graph: ModuleGraph, module: PSym): PPassContext =
        var context = DocContext(db: db)

        context.module = module
        context.graph = graph

        return context
    ),
    (
      proc(c: PPassContext, n: PNode): PNode =
        result = n
        var ctx = DocContext(c)

        if sfMainModule in ctx.module.flags:
          registerToplevel(ctx, n)
    ),
    (
      proc(graph: ModuleGraph; p: PPassContext, n: PNode): PNode =
        discard
    )
  ))

  compileProject(graph)

  db.writeJson(RelFile("doc.json"))
