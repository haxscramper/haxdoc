import
  hmisc/other/[oswrap, colorlogger, hshell],
  hmisc/hdebug_misc

import
  haxdoc/extract/from_nim_code,
  haxdoc/[docentry, docentry_io],
  haxdoc/generate/[sourcetrail_db, docentry_hext],
  haxdoc/process/[docentry_query, docentry_group],
  nimtrail/nimtrail_common

import std/[unittest, options, streams]

import hnimast/compiler_aux

const code = """
type
  MalTypeKind* = enum Nil, True, False, Number, Symbol, String,
    List, Vector, HashMap, Fun, MalFun, Atom

type
  FunType = proc(a: varargs[MalType]): MalType

  MalFunType* = ref object
    fn*:       FunType
    ast*:      MalType
    params*:   MalType
    is_macro*: bool

  MalType* = ref object
    case kind*: MalTypeKind
    of Nil, True, False: nil
    of Number:           number*:   int
    of String, Symbol:   str*:      string
    of List, Vector:     list*:     seq[MalType]
    of HashMap:          hash_map*: int
    of Fun:
                         fun*:      FunType
                         is_macro*: bool
    of MalFun:           malfun*:   MalFunType
    of Atom:             val*:      MalType

    meta*: MalType

type
  Base = ref object of RootObj

  A = ref object of Base
    f1*, fDebugTrigger*: string
    debugTestB: B
    b: B

  B = ref object of Base
    a: A
    debugTestA: A


  Exc = object of CatchableError
  Exc2 = object of Exc
  Def = object of Defect

proc canRaise() {.raises: [Exc].} = discard
proc canDefect() {.raises: [Def].} = discard

proc newExc2(): ref Exc2 = new(result)

proc zz(b: B) {.deprecated("use somethign else").} =
  canRaise()
  canDefect()
  echo b.debugTestA.debugTestB.debugTestA[]
  let z = b.debugTestA.debugTestB
  let q = b.debugTestA

  let tmp: int = (@[0, 1, 3])[40]
  echo $tmp

  if 2 > 4:
    raise newException(Exc, "Some message")

  elif 3 > 4:
    raise newExc2()


var globalVar = 10
let globalLet = 20
const globalConst = 30

proc zz(a: A) =
  echo globalVar
  echo globalConst
  echo globalLet

zz(A())
zz(B())

proc qew() =
  var test: MalTypeKind
  test = Fun
  echo(test)

type Dist = distinct int

let
  aa = Dist(123)
  bb = 123.Dist
  cc = aa.int

type ObjectWithMethods = ref object of RootObj
method exampleMethod(obj: ObjectWithMethods) =
  discard

proc recFirst()
proc recFirst(a: int) = recFirst()


proc recOther() = echo "123123"

proc recFirst() =
  recFirst(1)
  recOther()

"""

startHax()


let dir = getTempDir() / "tFromSimpleCode"

suite "Generate DB":
  test "Generate DB":
    mkDir dir
    let file = dir /. "a.nim"
    file.writeFile code

    startColorLogger()

    block: # Generate initial DB
      let db = generateDocDb(file, fileLIb = some("main"))
      db.writeDbXml(dir, "compile-db")


    var inDb = newDocDb({file.dir(): "main"})

    block: # Load DB from xml
      for file in walkDir(dir, AbsFile, exts = @["hxde"]):
        info "Loading DB", file
        block:
          var reader = newHXmlParser(file)
          reader.loadXml(inDb, "dbmain")

        block:
          var writer = newXmlWriter(file.withExt("xml"))
          writer.writeXml(inDb, "file")


    var writer: SourcetrailDbWriter

    block: # Open sourcetrail DB
      inDb.addKnownLib(getStdPath().dropSuffix("lib"), "std")
      let trailFile = dir /. "fromSimpleCode" &. sourcetrailDbExt
      rmFile trailFile
      writer.open(trailFile)
      discard writer.beginTransaction()

    block: # Generate sourcetrail database
      let idMap = writer.registerDb(inDb)

      for file in walkDir(dir, AbsFile, exts = @["hxda"]):
        var inFile: DocFile
        var reader = newHXmlParser(file)
        reader.loadXml(inFile, "file")

        writer.registerUses(inFile, idMap)

    block: # Close sourcetrail DB
      discard writer.commitTransaction()
      discard writer.close()


    echo "done"

suite "Filter DB":
  test "Filter db":
    if not exists(dir /. "compile-db" &. "hxde"): quit 0

    let db = loadDbXml(dir, "compile-db")

    for entry in db.allMatching(docFilter("seq")):
      let procs = entry.getProcsForType()
      for pr in procs:
        echo pr.name, " ", pr.procType()

    let (groups, other) = db.procsByTypes()

    for group in groups:
      echo group.typeEntry.name
      let groups = group.splitCommonProcs()
      echo "  common procs"
      for pr in groups.procs.nested[0]:
        echo "    ", pr.name, " ", pr.procType()

      echo "  other procs"
      for pr in groups.procs.nested[1]:
        echo "    ", pr.name, " ", pr.procType()


    if hasCmd(shellCmd("dot")):
      db.inheritDotGraph().toPng(AbsFile "/tmp/inherit.png")
      db.usageDotGraph().toPng(AbsFile "/tmp/usage.png")

suite "Generate HTML":
  test "Generate HTML":
    if not exists(dir /. "compile-db" &. "hxde"): quit 0
    let db = loadDbXml(dir, "compile-db")

    const genTemplate = """
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>The HTML5 Herald</title>
  <meta name="description" content="The HTML5 Herald">
</head>

<body>
  <ul>
  {% for entry in db %}
  <li><b>{{entry.name}}</b></li>
  {% end %}
  </ul>
</body>
</html>

"""

    evalHext(genTemplate, newWriteStream(dir /. "page.html"), {
      "db": boxValue(DValue, db)
    })
