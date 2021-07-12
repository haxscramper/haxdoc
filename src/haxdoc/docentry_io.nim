## Serialization and deserialization for documentation entries

import ./docentry
import std/[macros, streams, strutils, strformat, sequtils]
import nimtraits, nimtraits/trait_xml
export trait_xml
import hmisc/other/[hshell, oswrap]
import hmisc/algo/halgorithm
import hmisc/hdebug_misc

import haxorg/semorg
import haxorg/serialize_xml
export trait_xml

storeTraits(SemMetaTag)
storeTraits(ShellCmd)

using
  w: var XmlWriter
  r: var HXmlParser
  tag: string

proc loadXml*(r; it: var DocEntryKind, tag) =
  loadEnumWithPrefix[DocEntryKind](r, it, tag, "dek")

proc loadXml*(r; it: var DocOccurKind, tag) =
  r.loadEnumWithPrefix(it, tag, "dok")


proc writeXml*(w; cmd: ShellCmd, tag: string) = raiseImplementError("")
proc writeXml*(w; cmd: SemMetaTag, tag: string) = raiseImplementError("")

proc xmlAttribute*(w; key: string, use: seq[DocTypeUseKind]) =
  if use.len > 0:
    w.xmlAttribute(key, mapIt(use, $it).join(":"))

# proc xml


proc xmlAttribute*(w; key: string, id: DocId) =
  xmlAttribute(w, key, $id.id)

proc xmlAttribute*(w; key: string, file: AnyPath) =
  xmlAttribute(w, key, file.getStr())

proc xmlAttribute*(w; key: string, pos: DocPos) =
  xmlAttribute(w, key, &"{pos.line}:{pos.column}")

proc writeXml*(w; it: DocAdmonition, tag)
proc loadXml*(r; it: var DocAdmonition, tag)

proc writeXml*(w; it: DocMetatag, tag)
proc loadXml*(r; it: var DocMetatag, tag)

proc writeXml*(w; it: DocOccur, tag)
proc loadXml*(r; it: var DocOccur, tag)

proc writeXml*(w; it: DocId, tag)
proc loadXml*(r; it: var DocId, tag)

proc writeXml*(w; it: DocText, tag)
proc loadXml*(r; it: var DocText, tag)

proc writeXml*(w; it: DocLinkPart, tag)
proc loadXml*(r; it: var DocLinkPart, tag)

proc writeXml*(w; it: DocLink, tag)
proc loadXml*(r; it: var DocLink, tag)

proc writeXml*(w; it: DocType, tag)
proc loadXml*(r; it: var DocType, tag)

proc writeXml*(w; it: DocEntry, tag)
# proc loadXml*(r; it: var DocEntry, tag)

proc writeXml*(w; it: DocFile, tag)
proc loadXml*(r; it: var DocFile, tag)

proc writeXml*(w; it: DocDb, tag)
proc loadXml*(r; it: var DocDb, tag)

proc writeXml*(w; it: DocIdent, tag)
proc loadXml*(r; it: var DocIdent, tag)

proc writeXml*(w; it: DocPragma, tag)
proc loadXml*(r; it: var DocPragma, tag)

proc writeXml*(w; it: DocCode, tag)
proc loadXml*(r; it: var DocCode, tag)

proc writeXml*(w; it: DocCodePart, tag)
proc loadXml*(r; it: var DocCodePart, tag)

proc writeXml*(w; it: DocCodeSlice, tag)
proc loadXml*(r; it: var DocCodeSlice, tag)

proc writeXml*(w; it: DocLocation, tag)
proc loadXml*(r; it: var DocLocation, tag)

proc writeXml*(w; it: DocCodeLine, tag)
proc loadXml*(r; it: var DocCodeLine, tag)

proc writeXml*(w; it: DocExtent, tag)
proc loadXml*(r; it: var DocExtent, tag)

proc writeXml*(w; it: DocPos, tag)
proc loadXml*(r; it: var DocPos, tag)

# ~~~~ DocLocation ~~~~ #

proc loadXml*(r; it: var DocLocation, tag) =
  genXmlLoader(DocLocation, it, r, tag, newObjExpr = DocLocation())

proc writeXml*(w; it: DocLocation, tag) = genXmlWriter(DocLocation, it, w, tag)

# ~~~~ DocCode ~~~~ #

proc loadXml*(r; it: var DocCode, tag) =
  genXmlLoader(DocCode, it, r, tag, newObjExpr = DocCode())

proc writeXml*(w; it: DocCode, tag) = genXmlWriter(DocCode, it, w, tag)

# ~~~~ DocCodePart ~~~~ #

proc loadXml*(r; it: var DocCodePart, tag) =
  r.skipOpen(tag)
  r.loadXml(it.slice.line, "line")
  r.loadXml(it.slice.column, "column")
  if r["kind"]:
    var kind: DocOccurKind
    r.loadXml(kind, "kind")
    it.occur = some DocOccur(kind: kind)

    if r["user"]:
      r.loadXml(it.occur.get().user, "user")

    case kind:
      of dokLocalKinds:
        r.loadXml(it.occur.get().localId, "localId")

      else:
        r.loadXml(it.occur.get().refid, "refid")

  r.skipCloseEnd()

proc writeXml*(w; it: DocCodePart, tag) =
  w.xmlOpen(tag)
  w.xmlAttribute("line", it.slice.line)
  w.xmlAttribute("column", it.slice.column)
  if it.occur.getSome(occur):
    w.xmlAttribute("kind", occur.kind)
    w.xmlAttribute("user", occur.user)
    case occur.kind:
      of dokLocalKinds: w.xmlAttribute("localId", occur.localId)
      else: w.xmlAttribute("refid", occur.refId)


  w.xmlCloseEnd()

# ~~~~ DocCodeSlice ~~~~ #

proc loadXml*(r; it: var DocCodeSlice, tag) =
  genXmlLoader(DocCodeSlice, it, r, tag, newObjExpr = DocCodeSlice())

proc writeXml*(w; it: DocCodeSlice, tag) = genXmlWriter(DocCodeSlice, it, w, tag)

# ~~~~ DocCodeLine ~~~~ #

proc loadXml*(r; it: var DocCodeLine, tag) =
  r.skipStart(tag)
  r.loadXml(it.text, "text")
  r.loadXml(it.parts, "parts")
  r.loadXml(it.overlaps, "overlaps")
  r.skipEnd(tag)

proc writeXml*(w; it: DocCodeLine, tag) =
  w.xmlStart(tag)
  w.indent()
  w.xmlWrappedCdata(it.text, "text")
  for part in it.parts: w.writeXml(part, "parts")
  for part in it.overlaps: w.writeXml(part, "overlaps")
  w.dedent()
  w.xmlEnd(tag)

# ~~~~ DocPragma ~~~~ #

proc loadXml*(r; it: var DocPragma, tag) =
  genXmlLoader(DocPragma, it, r, tag, newObjExpr = DocPragma())

proc writeXml*(w; it: DocPragma, tag) =
  genXmlWriter(DocPRagma, it, w, tag)

# ~~~~ DocPos ~~~~ #

proc loadXml*(r; it: var DocPos, tag) =
  if r.atAttr():
    var sl: Slice[int]
    r.loadXml(sl, tag)
    it.line = sl.a
    it.column = sl.b

  else:
    genXmlLoader(DocPos, it, r, tag, newObjExpr = DocPos())

proc writeXml*(w; it: DocPos, tag) = genXmlWriter(DocPos, it, w, tag)

# ~~~~ DocExtent ~~~~ #

proc loadXml*(r; it: var DocExtent, tag) =
  genXmlLoader(DocExtent, it, r, tag, newObjExpr = DocExtent())

proc writeXml*(w; it: DocExtent, tag) =
  genXmlWriter(DocExtent, it, w, tag)

# ~~~~ DocIdent ~~~~ #

proc loadXml*(r; it: var DocIdent, tag) =
  genXmlLoader(DocIdent, it, r, tag, newObjExpr = DocIdent())

proc writeXml*(w; it: DocIdent, tag) =
  genXmlWriter(DocIdent, it, w, tag)

# ~~~~ DocText ~~~~ #

proc loadXml*(r; it: var DocText, tag) =
  genXmlLoader(DocText, it, r, tag, newObjExpr = DocText())

proc writeXml*(w; it: DocText, tag) =
  genXmlWriter(DocText, it, w, tag,
               skipFieldWrite = ["rawDoc"], addClose = false)

  for d in it.rawDoc:
    w.xmlWrappedCData(d, "rawDoc")

  w.dedent()
  w.xmlEnd(tag)

# ~~~~ DocAdmonition ~~~~ #

proc loadXml*(r; it: var DocAdmonition, tag) =
  genXmlLoader(DocAdmonition, it, r, tag, newObjExpr = DocAdmonition())

proc writeXml*(w; it: DocAdmonition, tag) =
  genXmlWriter(DocAdmonition, it, w, tag)

# ~~~~ DocMetaTag ~~~~ #

proc loadXml*(r; it: var DocMetatag, tag) =
  genXmlLoader(DocMetatag, it, r, tag, newObjExpr = DocMetaTag())

proc writeXml*(w; it: DocMetatag, tag) =
  genXmlWriter(DocMetatag, it, w, tag)


proc loadXml*(r; it: var DocOccur, tag) =
  genXmlLoader(DocOccur, it, r, tag, newObjExpr = DocOccur())

proc writeXml*(w; it: DocOccur, tag) =
  genXmlWriter(DocOccur, it, w, tag)


proc loadXml*(r; it: var DocId, tag) =
  if r.atAttr():
    r.loadXml(it.id, "id")

  else:
    r.skipOpen(tag)
    r.loadXml(it.id, "id")
    r.skipCloseEnd()

proc writeXml*(w; it: DocId, tag) =
  w.xmlOpen(tag)
  w.xmlAttribute("id", $it.id)
  w.xmlCloseEnd()


proc writeXml*(w; it: DocIdSet, tag) =
  if it.len == 0: return
  w.xmlStart(tag)
  w.indent()
  for id in it:
    w.writeXml(id, "id")
  w.dedent()
  w.xmlEnd(tag)

proc loadXml*(r; it: var DocIdSet, tag) =
  if not r[tag]: return
  r.skipStart(tag)
  while r["id"]:
    var id: DocId
    r.loadXml(id, "id")
    it.incl id

  r.skipEnd(tag)

proc loadXml*(r; it: var DocLinkPart, tag) =
  genXmlLoader(DocLinkPart, it, r, tag,
               newObjExpr = DocLinkPart(kind: kind))




proc writeXml*(w; it: DocLinkPart, tag) =
  genXmlWriter(
    DocLinkPart, it, w, tag,
    hasFieldsExpr = (it.kind in dekProcKinds))

proc loadXml*(r; it: var DocLink, tag) =
  genXmlLoader(DocLink, it, r, tag, newObjExpr = DocLink())

proc writeXml*(w; it: DocLink, tag) =
  genXmlWriter(DocLink, it, w, tag)

proc loadXml*(r; it: var DocType, tag) =
  genXmlLoader(DocType, it, r, tag, newObjExpr = DocType(kind: kind))

proc writeXml*(w; it: DocType, tag) =
  genXmlWriter(DocType, it, w, tag)

proc loadXml*(r; it: var DocFile, tag) =
  genXmlLoader(DocFile, it, r, tag, newObjExpr = DocFile())

proc writeXml*(w; it: DocFile, tag) =
  genXmlWriter(DocFile, it, w, tag)

proc writeXml*(w; it: DocDb, tag) =
  w.xmlStart(tag)
  for _, entry in it.top:
    w.writeXml(entry, "test")

  w.xmlEnd(tag)


proc loadNested*(r; db: var DocDb, tag; top: var DocEntry) =
  var entry: DocEntry

  genXmlLoader(
    DocEntry, entry, r, tag,
    skipFieldLoad = ["nested"],
    extraAttrLoad = { "decl": r.next() },
    newObjExpr = DocEntry(kind: kind),
    extraFieldLoad = {
      "nested": (
        while r.atOpenStart() and r["nested"]:
          loadNested(r, db, "nested", entry))})

  db.registerNested(top, entry)


proc loadXml*(r; it: var DocDb, tag) =
  if isNil(it):
    it = DocDb()

  r.skipStart(tag)
  while r["test"]:
    r.loadNested(it, "test", (var top: DocEntry; top))

  r.skipEnd(tag)


proc writeXml*(w; it: DocEntry, tag) =
  genXmlWriter(
    DocEntry, it, w, tag, ["nested", "rawDoc"], false,
    extraAttrWrite = (w.xmlAttribute("decl", true)))

  w.indent()
  for item in it.nested:
    w.writeXml(it.db[item], "nested")

  w.dedent()

  w.xmlEnd(tag)

proc loadDbXml*(
    dir: AbsDir, dbName: string, loadFiles: bool = false): DocDb =
  var reader = newHXmlParser(dir /. dbName &. "hxde")
  reader.loadXml(result, "dbmain")

  if loadFiles:
    for file in walkDir(dir, AbsFile, exts = @["hxda"]):
      var inFile: DocFile
      var reader = newHXmlParser(file)
      reader.loadXml(inFile, "file")

proc writeDbXml*(db: DocDb, dir: AbsDir, dbName: string) =
  block:
    var writer = withExt(dir /. dbName, "hxde").newXmlWriter()
    writer.writeXml(db, "dbmain")
    writer.close()

  for file in db.files:
    let outFile = dir /. file.path.withExt("hxda").splitFile2().file
    var writer = newXmlWriter(outFile)
    writer.writeXml(file, "file")
    writer.close()

when isMainModule:
  let doc = DocEntry()

  var w = newXmlWriter(newFileStream(stdout))
  w.writeXml(doc, "test")


import flatty
import hnimast

macro genFlattyWriter(
    obj: typedesc, input, stream: untyped): untyped =

  let
    input = input.copyNimNode()
    stream = stream.copyNimNode()
    impl = getObjectStructure(obj)

  let kindWrite = impl.mapItKindFields(input.newDot(path)):
    newCall("toFlatty", stream, input.newDot(field))

  let reqInit = impl.mapItPlainFields(input.newDot(path)):
    if field.isReqInit():
      newCall("toFlatty", stream, input.newDot(field))

    else:
      newEmptyNode()

  let fieldWrite = impl.mapItPlainFields(input.newDot(path)):
    if field.isSkipField("IO") or field.isReqInit():
      newEmptyNode()

    else:
      newCall("toFlatty", stream, input.newDot(field))

  result = newStmtList(kindWrite, reqInit, fieldWrite)


macro genFlattyReader(obj: typedesc, target, stream, index: untyped): untyped =
  let
    impl = getObjectStructure(obj)
    target = target.copyNimNode()
    stream = stream.copyNimNode()
    index = index.copyNimNode()

  var
    declareKind = impl.getKindFields.mapIt(newVar(it.name, it.fldType))
    loadKind = newCaseStmt(stream.newCall("attrKey"))
    newObject = impl.newCall()


  result = newStmtList(declareKind)

  echo result.repr


template castWrite(s: var string, obj: typed) =
  s.setLen(s.len + sizeof(obj))
  cast[ptr typeof(obj)](addr s[s.len - sizeof(obj)])[] = obj

template castRead(s: string, i: var int, x: typed) =
  x = cast[ptr typeof(x)](unsafeAddr s[i])[]
  i += sizeof(x)

import std/times


proc fromFlatty[E: enum](s: string, i: var int, en: var set[E]) =
  castRead(s, i, en)

proc fromFlatty(str: string, i: var int, cstr: var cstring) =
  var buf: string
  fromFlatty(str, i, buf)
  cstr = buf.cstring

proc fromFlatty(str: string, i: var int, id: var DocId) =
  castRead(str, i, id)

proc fromFlatty(str: string, i: var int, ns: var int) =
  castRead(str, i, ns)

proc toFlatty[E: enum](s: var string, en: set[E]) = castWrite(s, en)
proc toFlatty(str: var string, cstr: cstring) = toFlatty(str, $cstr)
proc toFlatty(str: var string, id: DocId) = castWrite(str, id)
proc toFlatty(str: var string, ns: int) = castWrite(str, ns)

proc toFlatty(str: var string, ns: NanosecondRange) =
  castWrite(str, ns)

template flattyRefWrite(
    s: var string, entry: typed, writer: untyped): untyped =
  if isNil(entry):
    s.toFlatty(true)

  else:
    s.toFlatty(false)
    writer

template flattyRefRead(s, pos, reader: untyped): untyped =
  var isNil: bool
  fromFlatty(s, pos, isNil)
  if not isNil:
    reader

import haxorg/[semorg, ast]

proc fromFlatty(s: string, i: var int, sem: var SemOrg) =
  flattyRefRead(s, i, genFlattyReader(SemOrg, sem, s, i))

proc toFlatty(s: var string, entry: DocEntry) =
  flattyRefWrite(s, entry, genFlattyWriter(DocEntry, entry, s))


import supersnappy

proc writeDbFlatty*(db: DocDb, dir: AbsDir, dbName: string) =
  mkDir dir
  writeFile(dir /. dbName, toFlatty(db).compress())

proc loadDbFlatty*(dir: AbsDir, dbName: string): DocDb =
  when false:
    result = fromFlatty(readFile(dir /. dbName).uncompress(), DocDb)
