import ../docentry
import ./docentry_query
import std/[tables, options, colors, strformat]

import
  hmisc/[hdebug_misc, helpers],
  hmisc/types/hgraph,
  hmisc/hasts/graphviz_ast

export hgraph, graphviz_ast


converter toDotNodeId*(id: DocId): DotNodeId =
  toDotNodeId(id.id.int)

type
  DocTypeGroup = object
    typeEntry*: DocEntry
    procs*: DocEntryGroup

# proc

proc newTypeGroup*(entry: DocEntry): DocTypeGroup =
  DocTypeGroup(typeEntry: entry)

proc procsByTypes*(db: DocDb): tuple[byType: seq[DocTypeGroup], other: DocEntryGroup] =
  var table: Table[DocId, DocTypeGroup]
  for _, entry in db.entries:
    if entry.kind in dekProcKinds:
      let id = entry.firstTypeId()
      if id in db:
        table.mgetOrPut(id, newTypeGroup(db[id])).procs.add entry

      else:
        # echov entry.name, entry.procType(), id
        result.other.add entry


  for _, group in table:
    result.byType.add group

proc inheritGraph*(db: DocDb): HGraph[DocId, NoProperty] =
  result = newHGraph[DocId, NoProperty]()
  for id, entry in db.entries:
    if entry.kind in dekStructTypes:
      for super in entry.superTypes:
        result.addOrGetEdge(id, super)

proc inheritDotGraph*(db: DocDb): DotGraph =
  let inherit = db.inheritGraph()

  result = inherit.dotRepr(
    proc(id: DocId): DotNode =
      if not id.isValid():
        result = makeDotNode(0, "--")

      else:
        result = makeDotNode(0, db[id].name)
        case db[id].kind:
          of dekException: result.color = some colRed
          of dekEffect: result.color = some colGreen
          of dekDefect: result.color = some colBlue
          else:
            discard

  )

  result.rankDir = grdLeftRight


proc usageDotGraph*(db: DocDb): DotGraph =
  result = makeDotGraph()
  result.rankDir = grdLeftRight
  for id, entry in db.entries:
    let userId = toDotNodeId(entry.id())
    case entry.kind:
      of dekBuiltin, dekEnum:
        result.add makeDotNode(userId, entry.name).withIt do:
          it.color = some colRed

      of dekAliasKinds:
        result.add makeDotNode(userId, &"{entry.name} = {entry.baseType}")
        for target in entry.baseType.allId():
          if target.isValid():
            result.add makeDotEdge(userId, target).withIt do:
              it.style = edsDashed

      of dekStructTypes:
        var typeFields: seq[RecordField] = @[makeDotRecord(0, &"[[ {entry.name} ]]")]
        for nested in entry:
          if nested.kind == dekField and nested.identType.isSome():
            let ftype = nested.identType.get()

            for ftypeId in ftype.allId():
              if ftypeId.isValid():
                let
                  fieldPath = toDotPath(userId, nested.id())
                  targetPath = toDotPath(ftypeId, 0)

                if db[ftypeId].kind != dekBuiltin:
                  result.add makeDotEdge(fieldPath, targetPath)

            typeFields.add makeDotRecord(
              nested.id(), &"{nested.name}: {ftype}")

        result.add makeRecordDotNode(userId, typeFields).withIt do:
          it.color = some colBlue

        for super in entry.superTypes:
          result.add makeDotEdge(userId, super).withIt do:
            it.style = edsBold

      else:
        discard
