import ../docentry
import ./docentry_query
import std/[tables]
import hmisc/hdebug_misc


type
  DocTypeGroup = object
    typeEntry*: DocEntry
    procs*: DocEntryGroup

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
