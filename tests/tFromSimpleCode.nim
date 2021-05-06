import hmisc/other/[oswrap, colorlogger]
import haxdoc/extract/from_nim_code, haxdoc/[docentry, docentry_io]
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
    b: B

  B = ref object of Base
    a: A

proc zz(a: A) = discard
proc zz(b: B) = discard

zz(A())
zz(B())

"""

let dir = getTempDir() / "tFromSimpleCode"
mkDir dir
let file = dir /. "a.nim"
file.writeFile code

startColorLogger()

let db = generateDocDb(file, getStdPath(), @[])
db.writeDbXml(dir, "compile-db")

for file in walkDir(dir, AbsFile, exts = @["hxda"]):
  var inFile: DocFile
  var reader = newHXmlParser(file)
  reader.loadXml(inFile, "file")

for file in walkDir(dir, AbsFile, exts = @["hxde"]):
  info "Loading DB", file
  var inDb: DocDb
  block:
    var reader = newHXmlParser(file)
    reader.loadXml(inDb, "dbmain")

  block:
    var writer = newXmlWriter(file.withExt("xml"))
    writer.writeXml(inDb, "file")

echo "done"
