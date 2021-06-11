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

proc splitCommonProcs*(group: DocTypeGroup): DocTypeGroup =
  result.typeEntry = group.typeEntry
  result.procs = newEntryGroup(@[newEntryGroup(), newEntryGroup()])
  for entry in group.procs:
    if entry.name in ["$", "==", "<", "items", "pairs", ">", "!=", "[]", "[]="]:
      result.procs.nested[0].add entry

    else:
      result.procs.nested[1].add entry


proc inheritGraph*(db: DocDb): HGraph[DocId, NoProperty] =
  result = newHGraph[DocId, NoProperty]()
  for id, entry in db.entries:
    if entry.kind in dekStructKinds:
      for super in entry.superTypes:
        result.addOrGetEdge(id, super)

proc inheritDotGraph*(db: DocDb): DotGraph =
  let inherit = db.inheritGraph()

  result = inherit.dotRepr(
    proc(id: DocId, _: HNode): DotNode =
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

      of dekStructKinds:
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

proc structureDotGraph*(db: DocDb): DotGraph =
  var sub: Table[DocId, DotGraph]
  for pack in allItems(db, {dekPackage}):
    sub[pack.id()] = makeDotGraph().withIt do:
      it.color = some colRed
      it.isCluster = true
      it.name = pack.name
      it.label = pack.name
      it.add makeDotNode(pack.id(), &"""
name: {pack.name}
auth: {pack.author}
vers: {pack.version}""").withIt do:
        it.labelAlign = nlaLeft


  for module in allItems(db, {dekModule}):
    let userId = toDotNodeId(module.id())
    let package = module.fullIdent.parts[0].id
    sub[package].add makeDotNode(userId, module.name)
    for imp in module.imports:
       sub[package].add makeDotEdge(userId, imp)

  result = makeDotGraph()
  result.compound = some true

  for _, graph in sub:
    result.add graph

  for pack in topItems(db, {dekPackage}):
    for req in pack.requires:
      if req.resolved.isSome():
        result.add makeDotEdge(pack.id(), req.resolved.get()).withIt do:
          it.ltail = some pack.name
          it.lhead = some db[db[req.resolved.get()].getPackage()].name
          it.label = some req.version
          it.style = edsBold
