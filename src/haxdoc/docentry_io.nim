## Serialization and deserialization for documentation entries

import ./docentry
import std/[macros, streams, strutils]
import nimtraits, nimtraits/trait_xml
export trait_xml
import hmisc/other/hshell
import hmisc/hdebug_misc

import haxorg/semorg

storeTraits(SemMetaTag)
storeTraits(ShellCmd)

using w: var XmlWriter

proc writeXml*(w; id: SemOrg, tag: string) = discard
proc writeXml*(w; cmd: ShellCmd, tag: string) = discard
proc writeXml*(w; cmd: SemMetaTag, tag: string) = discard

using tag: string


# proc writeXml*(w; it: DocTypeKind, tag)
# proc writeXml*(w; it: DocIdentKind, tag)
# proc writeXml*(w; it: DocOccurKind, tag)
# proc writeXml*(w; it: DocTypeHeadKind, tag)
# proc writeXml*(w; it: DocOccurKind, tag) = genXmlWriter(DocOccurKind, it, w, tag)
# proc writeXml*(w; it: DocTypeKind, tag) = genXmlWriter(DocTypeKind, it, w, tag)
# proc writeXml*(w; it: DocIdentKind, tag) = genXmlWriter(DocIdentKind, it, w, tag)
# proc writeXml*(w; it: DocTypeHeadKind, tag) = genXmlWriter(DocTypeHeadKind, it, w, tag)


proc writeXml*(w; it: DocAdmonition, tag)
proc writeXml*(w; it: DocMetatag, tag)
proc writeXml*(w; it: DocOccur, tag)
proc writeXml*(w; it: DocId, tag)
proc writeXml*(w; it: DocIdentPart, tag)
proc writeXml*(w; it: DocFullIdent, tag)
proc writeXml*(w; it: DocType, tag)
proc writeXml*(w; it: DocEntry, tag)
proc writeXml*(w; it: DocFile, tag)
proc writeXml*(w; it: DocDb, tag)
proc writeXml*(w; it: DocIdent, tag)
proc writeXml*(w; it: DocPragma, tag)
proc writeXml*(w; it: DocCode, tag)
proc writeXml*(w; it: DocCodePart, tag)
proc writeXml*(w; it: DocLocation, tag)

proc writeXml*(w; it: DocLocation, tag)     =
  genXmlWriter(DocLocation, it, w, tag)

proc writeXml*(w; it: DocCode, tag)     =
  genXmlWriter(DocCode, it, w, tag)

proc writeXml*(w; it: DocCodePart, tag) =
  genXmlWriter(DocCodePart, it, w, tag)

proc writeXml*(w; it: DocPragma, tag)   =
  genXmlWriter(DocPRagma, it, w, tag)

proc writeXml*(w; it: DocIdent, tag)   =
  genXmlWriter(DocIdent, it, w, tag)

proc writeXml*(w; it: DocAdmonition, tag)   =
  genXmlWriter(DocAdmonition, it, w, tag)

proc writeXml*(w; it: DocMetatag, tag)   =
  genXmlWriter(DocMetatag, it, w, tag)

proc writeXml*(w; it: DocOccur, tag)   =
  genXmlWriter(DocOccur,it, w, tag)

proc writeXml*(w; it: DocId, tag) =
  w.xmlOpen(tag)
  w.space()
  w.xmlAttribute("id", $it.id)
  w.xmlCloseEnd()

proc writeXml*(w; it: DocIdentPart, tag) =
  genXmlWriter(DocIdentPart, it, w, tag)

proc writeXml*(w; it: DocFullIdent, tag) =
  when false:
    w.xmlOpen(tag)
    w.space()
    w.xmlAttribute("id", $it.docId.id)
    w.space()
    var parts: seq[string]
    for part in it.parts:
      parts.add $part.name & "::" & $part.kind

    w.xmlAttribute("parts", parts.join("/"))

    w.xmlCloseEnd()

  else:
    genXmlWriter(DocFullIdent, it, w, tag)

proc writeXml*(w; it: DocType, tag) =
  genXmlWriter(DocType, it, w, tag)


proc writeXml*(w; it: DocFile, tag) =
  genXmlWriter(DocFile, it, w, tag)

proc writeXml*(w; it: DocDb, tag) = discard # genXmlWriter(DocDb, it, w, tag)

proc writeXml*(w; it: DocEntry, tag) =
  startHaxComp()
  genXmlWriter(DocEntry, it, w, tag, ["nested", "db", "rawDoc"], false)

  w.indent()
  for item in it.nested:
    w.writeXml(it.db[item], "nested")

  for item in it.rawDoc:
    w.writeInd()
    w.xmlStart("rawDoc", false)
    w.xmlCData(item)
    w.xmlEnd("rawDoc", false)
    w.line()

  w.dedent()

  w.xmlEnd(tag)



when isMainModule:
  let doc = DocEntry()

  var w = newXmlWriter(newFileStream(stdout))
  w.writeXml(doc, "test")
