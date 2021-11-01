import
  hmisc/other/[oswrap, hshell, hlogger],
  hmisc/algo/halgorithm,
  hmisc/preludes/unittest

import
  haxdoc/extract/from_nim_code,
  haxdoc/[docentry, docentry_io],
  haxdoc/generate/[sourcetrail_db, docentry_hext, sqlite_db],
  haxdoc/process/[docentry_query, docentry_group],
  nimtrail/nimtrail_common

import std/[
  options, streams, strformat, strutils, sequtils
]

import hnimast/[compiler_aux, nimble_aux]

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

proc vDist(a: var Dist) = discard
proc vBase(a: var Base) = discard

const FooBar {.intdefine.}: int = 5
echo FooBar
"""

startHax()

let dir = getTempDir() / "tFromSimpleCode"

var l = newTermLogger()

suite "Generate DB":
  test "Generate DB":
    mkDir dir
    let file = dir /. "a.nim"
    file.writeFile code

    block: # Generate initial DB
      let db = generateDocDb(
        file, fileLIb = some("main"),
        logger = l)

      db.writeDbXml(dir, "compile-db")


    var inDb = newDocDb({file.dir(): "main"})

    block: # Load DB from xml
      for file in walkDir(dir, AbsFile, exts = @["hxde"]):
        l.info "Loading DB", file
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

        writer.registerUses(inFile, idMap, inDb)

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


suite "Generate sqlite db":
  test "SQlite from xml":
    if not exists(dir /. "compile-db" &. "hxde"): quit 0
    let db = loadDbXml(dir, "compile-db")
    db.writeDbSqlite(dir /. "compile.sqlite")


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



suite "Multiple packages":
  test "Multiple packages":
    let dir = getNewTempDir("tFromMultiPackage")
    var
      imports: seq[string]
      requires: seq[string]

    let count = 2
    for i in 0 .. count:
      let p = &"package{i}"
      imports.add &"import {p}/{p}_file1"
      requires.add &"{p}"
      mkWithDirStructure dir:
        dir &"{p}":
          file &"{p}.nimble":
            &"""
version       = "0.1.0"
author        = "haxscramper"
description   = "Brief documentation for a package {i}"
license       = "Apache-2.0"
srcDir        = "src"
packageName   = "package{i}"
"""

          # TODO test with package name that does not correspond to
          # existing package `packageName = "package{i}"`



          # no 'src/' dir because I'm emulating globally installed packages
          file &"{p}_main.nim"
          dir &"{p}":
            file &"{p}_file1.nim": &"import {p}_file2; export {p}_file2"
            file &"{p}_file2.nim": &"import {p}_file3; export {p}_file3"
            file &"{p}_file3.nim": &"proc {p}_proc*() = discard"

    let req = requires.joinq(", ")
    mkWithDirStructure dir:
      dir "main":
        # have 'src/' because I'm emulating package in development
        dir "src":
          file "main.nim":
            file.writeLine imports.joinl()
            for pack in 0 .. count:
              &"package{pack}_proc()\n"

        file "readme.org":
          "Sample readme for a package"
        file "main.nimble":
          &"""
version = "0.1.0"
author = "haxscramper"
description = "Description of the main package"
license = "Apache-2.0"
packageName = "main"
requires {req}
"""

    let db = docDbFromPackage(
      getPackageInfo(dir / "main"),
      searchDir = dir)

    db.writeDbSourcetrail(dir /. "multiPackage")
    db.writeDbXml(dir, "multiPackage")

    if hasCmd shellCmd("dot"):
      let graph = db.structureDotGraph()
      graph.toPng(dir /. "structure.png")
