import
  ../docentry


import
  std/[db_sqlite, strformat, with, sqlite3, macros, hashes,
       options, sequtils, intsets, sugar],
  hmisc/other/[oswrap],
  hmisc/[helpers, hdebug_misc, base_errors],
  hnimast, hnimast/store_decl,
  haxorg/[semorg]

startHax()


proc bindParam[T](ps: SqlPrepared, idx: int, opt: Option[T]) =
  if opt.isSome():
    bindParam(ps, idx, opt.get())

  else:
    bindNull(ps, idx)

proc bindParam[E: enum](ps: SqlPrepared, idx: int, opt: E) =
  bindParam(ps, idx, opt.int)

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

proc toSqlite*(t: typedesc[int]): string = "integer"
proc toSqlite*(t: typedesc[bool]): string = "integer"
proc toSqlite*(t: typedesc[DocId]): string =
     &"integer references {entriesTable}(id)"

proc toSqlite*(t: typedesc[string]): string = "text"
proc toSqlite*(t: typedesc[enum]): string = "integer"

proc toSQLite*(t: typedesc[DocType]): string =
  &"integer references {typeInstanceTable}(id)"

proc toSqlite*(t: typedesc[DocText]): string =
  &"integer references {doctextTable}(id)"

proc toSqlite*(t: typedesc[SemOrg]): string = "blob"

proc toSqlite*[T](t: typedesc[Option[T]]): string =
  toSqlite(typeof Option[T]().get())

template sq*(expr: untyped): untyped =
  toSqlite(typeof expr)

proc sqlite3_expanded_sql(sqlite3_stmt: PStmt): cstring {.
  importc, dynlib: "libsqlite3.so(|.0)", cdecl.}



proc `$`*(pstmt: SqlPrepared): string =
  $sqlite3_expanded_sql(pstmt.PStmt)

proc reset*(p: SqlPrepared) =
  discard reset(p.PStmt)

proc doExec(sq: DbConn, prep: SqlPrepared) =
  sq.exec(prep)
  reset(prep)

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
    echo q.string
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

proc newInsert(table: string, columns: openarray[(string, int)]): string =
  "insert into " & table & " (\n  " &
    columns.mapIt(it[0]).join(", ") & "\n) values ( \n" & join(
      collect(
        newSeq,
        for idx, (name, val) in columns:
         "  ?" & $val & tern(idx < columns.high, ",", " ") & " -- " & name
      ), "\n"
    ) & "\n);"




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

    # echo q
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

proc registerFullDb*(db: DocDb, sq: DbConn) =
  var prep: PrepStore
  for entry in allItems(db):
    sq.register(entry, prep)

  for field in fields(prep):
    field.finalize()
  # prep.entry.finalize()
  # prep.docText.finalize()
  # prep.docType.finalize()

proc writeDbSqlite*(db: DocDb, outFile: AbsFile) =
  if exists(outFile): rmFile outFile

  let conn = open(outFile.string, "", "", "")
  createTables(conn)
  try:
    db.registerFullDb(conn)

  except DbError:
    echo errmsg(conn)
    echo errcode(conn)
    raise

  finalizePrepared()
  db_sqlite.close(conn)
