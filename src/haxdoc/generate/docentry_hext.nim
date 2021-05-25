import
  hmisc/hasts/hext_template,
  ../docentry

export hext_template



type
  DocBoxKind* = enum
    dbkDb
    dbkEntry

  DocBox* = object
    case kind*: DocBoxKind
      of dbkDb:
        db*: DocDb

      of dbkEntry:
        entry*: DocEntry

  DValue* = HextValue[DocBox]


func boxValue*(t: typedesc[DValue], val: DocEntry): DValue =
  boxValue(t, DocBox(kind: dbkEntry, entry: val), dbkEntry.int)

func boxValue*(t: typedesc[DValue], val: DocDb): DValue =
  boxValue(t, DocBox(kind: dbkDb, db: val), dbkDb.int)

proc getField*(t: typedesc[DValue], box: DocBox, name: string): DValue =
  case box.kind:
    of dbkEntry:
      case name:
        of "name": return boxValue(t, box.entry.name)

    else:
      assert false

iterator boxedItems*(t: typedesc[DValue], val: DocBox): DValue =
  case val.kind:
    of dbkDb:
      for _, entry in val.db.entries:
        yield boxValue(t, entry)

    else:
      assert false, "asfd"
