import
  ../docentry

import
  std/[
    strformat, with, macros, hashes, options,
    sequtils, intsets, sugar, strutils
  ]

import
  hmisc/other/[oswrap, sqlite_extra],
  hmisc/core/all

import
  hnimast, hnimast/store_decl

import
  haxorg/[semorg]

startHax()


proc bindParam(ps: SqlPrepared, idx: int, id: DocId) =
  bindParam(ps, idx, id.id.int)

# proc bindParam(ps: SqlPrepared, idx: int, id: Hash) =
#   bindParam(ps, idx, id.int)

const
  entriesTable = "entries"
  typeInstanceTable = "typeInstances"
  doctextTable = "doctext"
  occurTable = "occurs"
  signaturesTable = "procedureSignatures"
  pragmaListTable = "pragmaLists"
  genericInstTable = "genericSpecializations"
  argListTable = "argLists"
  idKey = "integer primary key unique not null"

var
  registerPrep: SqlPrepared

proc finalizePrepared() =
  finalize(registerPrep)





proc toSQLite*(t: typedesc[DocType]): string =
  &"integer references {typeInstanceTable}(id)"

proc toSqlite*(t: typedesc[DocText]): string =
  &"integer references {doctextTable}(id)"

proc toSqlite*(t: typedesc[SemOrg]): string = "blob"

proc toSqlite*(t: typedesc[DocId]): string =
     &"integer references {entriesTable}(id)"


proc createTables(sq: DbConn) =
  let q =
    @[
      sql fmt("""
create table {doctextTable} (
  id {idKey},
  docBrief {sq(DocText().docBrief)},
  docBody {sq(DocText().docBody)},
  rawDoc text
);
"""),
    sql fmt("""create table {entriesTable} (
  id {idKey},
  parentId {toSqlite(typeof DocEntry().id)},
  depth integer not null,
  name {toSqlite(typeof DocEntry().name)},
  kind {toSqlite(typeof DocEntry().kind)},
  docText {toSqlite(typeof DocEntry().docText)},
  docType {sq(DocType())}
);
"""),
    sql fmt("""create table {occurTable} (
  user {sq(DocOccur().user)},
  kind {sq(DocOccur().kind)} not null,
  localId {sq(DocOccur().localId)},
  withInit {sq(DocOccur().withInit)},
  refid {sq(DocOccur().refid)}
);
"""),
    sql fmt("""create table {typeInstanceTable} (
  id {idKey},
  kind {sq(DocType().kind)},
  headEntry {sq(DocType().head)},
  procType integer references {signaturesTable}(id),
  paramTypes integer references {genericInstTable}(id)
);
"""),
    sql fmt("""create table {genericInstTable} (
  id integer not null,
  type {sq(DocType)},
  pos integer not null
);
"""),
    sql fmt("""create table {signaturesTable} (
  id {idKey},
  returnType {sq(DocType)},
  argList integer references {arglistTable}(id),
  pragmaList integer references {pragmaListTable}(id)
);
"""),
    sql fmt("""create table {argListTable} (
  id integer not null,
  pos integer not null,
  name text,
  type {sq(DocType)}
);
""")

    ]

  for q in q:
    sq.exec(q)


type
  PrepStore = object
    entry, docText, docType, sig, docProc, docGeneric: SqlPrepared


proc register(sq: DbConn, text: DocText, prep: var PrepStore): int =
  var docIdx {.global.}: int
  result = docIdx
  inc docIdx
  once:
    let q = &"""
insert into {doctextTable} (
  rawDoc
) values (
  ?1 -- rawDoc
)
"""

    prep.docText = sq.prepare(q)

  prep.docText.bindParam(1, text.rawDoc.join("\n"))


  sq.doExec(prep.docText)

template checkSeen(hash: Hash): bool =
  var store {.global.}: IntSet
  if hash in store:
    true

  else:
    store.incl hash
    false





proc registerProc(sq: DbConn, sig: DocType, prep: var PrepStore): Hash =
  result = hash(sig)
  if checkSeen(result): return

  once:
    let q = argListTable.newInsert({
      "id": 1,
      "pos": 2,
      "name": 3,
      "type": 4
    })

    prep.docProc = sq.prepare(q)


  for idx, arg in sig.arguments:
    with prep.docProc:
      bindParam(1, result)
      bindParam(2, idx)
      bindParam(3, arg.ident)
      bindParam(4, hash(arg.identType))

    sq.doExec(prep.docProc)



proc registerGeneric(sq: DbConn, sig: DocType, prep: var PrepStore): Hash =
  result = hash(sig)
  if checkSeen(result): return

  once:
    let q = genericInstTable.newInsert({
      "id": 1, "type": 2, "pos": 3})

    prep.docGeneric = sq.prepare(q)

  for idx, arg in sig.genParams:
    with prep.docGeneric:
      bindParam(1, result)
      bindParam(2, arg.hash())
      bindParam(3, idx)

    sq.doExec(prep.docGeneric)




proc register(sq: DbConn, dtype: DocType, prep: var PrepStore): Hash =
  if isNil(dtype): return

  result = dtype.hash()
  if checkSeen(result): return


  once:
    let q = typeInstanceTable.newInsert({
      "id": 1,
      "kind": 2,
      "headEntry": 3,
      "procType": 4,
      "paramTypes": 5
    })

    prep.docType = sq.prepare(q)

  with prep.docType:
    bindParam(1, result)
    bindParam(2, dtype.kind)

  case dtype.kind:
    of dtkProc:
      prep.docType.bindParam(4, sq.registerProc(dtype, prep))

    of dtkIdent:
      prep.docType.bindParam(3, dtype.head)
      prep.docType.bindParam(5, sq.registerGeneric(dtype, prep))

    else:
      discard

  sq.doExec(prep.docType)

proc register(sq: DbConn, entry: DocEntry, prep: var PrepStore) =
  var registered: DocIdSet
  if entry.id in registered:
    echov entry, "already registered"
    return

  else:
    registered.incl entry.id()

  once:
    let q = &"""
insert into {entriesTable} (
  id, name, kind, depth, parentId, doctext, docType
) values (
  ?1, -- id
  ?2, -- name
  ?3, -- kind
  ?4, -- depth
  ?5, -- parent id
  ?6, -- docText
  ?7
);
"""

    prep.entry = sq.prepare(q)

  with prep.entry:
    bindParam(1, entry.id())
    bindParam(2, entry.name)
    bindParam(3, entry.kind)
    bindParam(4, entry.fullIdent.len())
    bindParam(6, sq.register(entry.docText, prep))

  if entry.fullIdent.hasParent():
    prep.entry.bindParam(5, entry.parentIdentPart.id)

  case entry.kind:
    of dekProcKinds:
      prep.entry.bindParam(7, sq.register(entry.procType, prep))

    of dekAliasKinds:
      prep.entry.bindParam(7, sq.register(entry.baseType, prep))

    else:
      discard

  sq.doExec(prep.entry)

proc store*[E: enum](sq: DbConn, name: string, en: typedesc[E]) =
  sq.exec(sql &"create table {name} (kind int, name text);")
  for kind in low(E) .. high(E):
    sq.exec(sql &"insert into {name} (kind, name) values ({kind.int}, \"{kind}\");")


proc registerFullDb*(db: DocDb, sq: DbConn) =
  var prep: PrepStore
  for entry in allItems(db):
    sq.register(entry, prep)

  for field in fields(prep):
    field.finalize()

  sq.store("entryKinds", DocEntryKind)
  sq.store("occurKinds", DocOccurKind)
  sq.store("typeKinds", DocTypeKind)


proc writeDbSqlite*(db: DocDb, outFile: AbsFile) =
  if exists(outFile): rmFile outFile

  let conn = open(outFile.string, "", "", "")
  createTables(conn)
  try:
    db.registerFullDb(conn)

  except DbError:
    echo connError(conn)
    raise

  finalizePrepared()
  close(conn)
