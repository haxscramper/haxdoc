import
  ../docentry


import
  std/[db_sqlite, strformat, with, sqlite3, macros,
       options, sequtils],
  hmisc/other/[oswrap],
  hmisc/[helpers, hdebug_misc, base_errors],
  hnimast, hnimast/store_decl

startHax()


proc genSqlPrepared(
    obj: NObjectDecl, input, prepared, allowFieldWriter: NimNode
  ): tuple[writer, stmtExpr: NimNode] =

  let
    input = input.copyNimNode()
    prepared = prepared.copyNimNode()
    allowed: seq[string] = allowFieldWriter.mapIt(it.strVal())

  var idx = 1
  var stmtCreate: seq[string]
  let fieldWrite = obj.mapItGroups(input.newDot(path[^1].name)):
    var res = newStmtList()
    for field in group:
      if not field.isExported or
         field.isMarkedWith("Skip", "IO") or
         field.name notin allowed:
        discard

      else:
        res.add newCall(
          "bindParam", prepared, newLit(idx),
          input.newDot(field))

        stmtCreate.add field.name

        inc idx

    return res

  var sCreate = "INSERT INTO {entryTableName} ("
  for idx, stmt in stmtCreate:
    if idx > 0: sCreate &= ", "
    sCreate.add stmt

  sCreate &= ") VALUES ("

  for idx, stmt in stmtCreate:
    if idx > 0: sCreate &= ", "
    sCreate.add "?"

  sCreate &= ");"

  return (fieldWrite, newLit(sCreate))

macro genSqlPreparedWriter*(
    obj: typedesc, input: typed, prepared: SqlPrepared,
    allowFieldWriter: openarray[string] = [""]
  ): untyped =

  result = getObjectStructure(obj).genSqlPrepared(
    input, prepared, allowFieldWriter).writer

  echo result.repr


macro genSqlPreparedCreate*(
    obj: typedesc, allowFieldWriter: openarray[string]): untyped =
  result = getObjectStructure(obj).genSqlPrepared(
    nil, nil, allowFieldWriter).stmtExpr

  echo result.repr

macro genSqlTableCreate*(
    obj: typedesc, allowFieldWriter: openarray[string]): untyped =
  let
    obj = getObjectStructure(obj)
    allowed: seq[string] = allowFieldWriter.mapIt(it.strVal())


  var fieldSpec: seq[string]
  for field in iterateFields(obj):
    if field.name in allowed:
      var tmp: string
      with tmp:
        add "  "
        add field.name
        add " "
        add "{toSqlite(typeof(" & obj.name.head & "." & field.name & "))}"

      fieldSpec.add tmp

  var res = "CREATE TABLE {entryTableName} ("
  for idx, f in fieldSpec:
    if idx > 0: res &= ",\n"
    if idx == 0: res &= "\n"

    res &= f

  res &= "\n)"

  echo res
  result = newLit(res)

proc bindParam[T](ps: SqlPrepared, idx: int, opt: Option[T]) =
  if opt.isSome():
    bindParam(ps, idx, opt.get())

  else:
    bindNull(ps, idx)

proc bindParam[E: enum](ps: SqlPrepared, idx: int, opt: E) =
  bindParam(ps, idx, opt.int)

proc bindParam(ps: SqlPrepared, idx: int, id: DocId) =
  bindParam(ps, idx, id.id.int)

const
  entryTableName = "entries"

var
  registerPrep: SqlPrepared

proc createPrepared(sq: DbConn) =
  registerPrep = sq.prepare(fmt(
    genSqlPreparedCreate(
      DocEntry,
      ["kind", "name", "visibility", "id"])))

proc finalizePrepared() =
  finalize(registerPrep)

proc toSqlite*(t: typedesc int): string = "INTEGER"
proc toSqlite*(t: typedesc DocId): string = "INTEGER"
proc toSqlite*(t: typedesc string): string = "TEXT"
proc toSqlite*(t: type string): string = "TEXT"
proc toSqlite*(t: type enum): string = "INTEGER"


proc createTables(sq: DbConn) =
  let entryTable = sql fmt(genSqlTableCreate(
    DocEntry, ["kind", "name", "visibility", "id"]))

  sq.exec(entryTable)


proc registerEntry(sq: DbConn, entry: DocEntry) =
  genSqlPreparedWriter(
    DocEntry, entry, registerPrep,
    ["kind", "name", "visibility", "id"])
  # registerPrep.bindParams(entry.id.id, entry.name, entry.kind.int)
  sq.exec(registerPrep)
  discard reset(registerPrep.PStmt)

proc registerFullDb*(db: DocDb, sq: DbConn) =
  for entry in allItems(db):
    sq.registerEntry(entry)

proc writeDbSqlite*(db: DocDb, outFile: AbsFile) =
  if exists(outFile): rmFile outFile

  let conn = open(outFile.string, "", "", "")
  createTables(conn)
  createPrepared(conn)
  try:
    db.registerFullDb(conn)

  except DbError:
    echo errmsg(conn)
    echo errcode(conn)
    raise

  finalizePrepared()
  db_sqlite.close(conn)
