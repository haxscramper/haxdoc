import ../docentry, ../process/[docentry_query, docentry_group]
import
  hmisc/[helpers, base_errors, hdebug_misc],
  hmisc/hasts/html_ast2

export html_ast2

import std/[streams, strformat]


func toLink*(t: DocType): string =
  case t.kind:
    of dtkProc:
      for idx, arg in t.arguments:
        if idx > 0: result &= ","
        result &= toLink(arg.identType)

    else:
      result = $t

func toLink*(full: DocFullIdent): string =
  for part in full.parts:
    case part.kind:
      of dekModule, dekPackage, dekNewtypeKinds:
        result &= part.name & "_"

      of dekProcKinds:
        result &= part.name & "(" & part.procType.toLink() & ")"

      else:
        raiseImplementKindError(part)

type
  HtmlWriter* = object
    indentBuf: string
    stream: Stream

using writer: var HtmlWriter

proc newHtmlWriter*(stream: Stream): HtmlWriter =
  HtmlWriter(stream: stream)

proc newHtmlWriter*(file: AbsFile): HtmlWriter =
  newHtmlWriter(newFileStream(file, fmWrite))

proc newHtmlWriter*(file: File): HtmlWriter =
  newHtmlWriter(newFileStream(file))

proc space*(writer) = writer.stream.write(" ")
proc line*(writer) = writer.stream.write("\n")

proc write*(writer; text: varargs[string]) = writer.stream.write(text)
proc indent*(writer) = writer.indentBuf.add "  "
proc dedent*(writer) =
  writer.indentBuf.setLen(max(writer.indentBuf.len - 2, 0))

proc writeInd*(writer) = writer.stream.write(writer.indentBuf)


proc finish*(writer; elem: HtmlNodeKind; useLine: bool = true) =
  if useLine:
    writer.dedent(); writer.writeInd()

  writer.write("</", $elem, ">")
  if useLine:
    writer.line()

proc open*(writer; elem: HtmlNodeKind, useLine: bool = true) =
  if useLine: writer.writeInd()
  writer.write("<", $elem)

func htmlEscape*(str: string): string =
  # TODO
  str

proc attr*(writer; attr, val: string) =
  writer.write(&" {attr}={htmlEscape(val)}")

type HAttrs = openarray[(string, string)]

proc start*(
    writer; elem: HtmlNodeKind; attrs: HAttrs = @[], useLine: bool = true) =

  if useLine: writer.writeInd(); writer.indent()
  writer.write("<", $elem)
  for (key, val) in attrs:
    writer.attr(key, val)
  writer.write(">")
  if useLine: writer.line()

proc start*(writer; elem: openarray[HtmlNodeKind]) =
  writer.writeInd()
  for e in items(elem):
    writer.start(e, useLine = false)

  writer.indent()
  writer.line()

proc finish*(writer; elems: openarray[HtmlNodeKind]) =
  writer.dedent()
  writer.writeInd()
  for e in ritems(elems):
    writer.finish(e, useLine = false)

  writer.line()


type
  HTagSpec = object
    tag: HtmlNodeKind
    attrs: seq[(string, string)]

import std/[macros, sequtils]

proc initHTagSpec*(tag: HtmlNodeKind, args: HAttrs = @[]): HTagSpec =
  HTagSpec(tag: tag, attrs: toSeq(args))

macro `</`*(args: untyped): untyped =
  result = nnkBracket.newTree()
  echo treeRepr(args)
  for arg in args:
    case arg.kind:
      of nnkIdent:
        result.add newCall("initHTagSpec", arg)

      of nnkCurlyExpr:
        result.add newCall(
          "initHTagSpec", arg[0],
          nnkTableConstr.newTree(toSeq(arg[1 .. ^1])))

      else:
        result.add newCall("initHTagSpec", toSeq(arg))

  echo result

proc start*(writer; elem: openarray[HTagSpec]) =
  writer.writeInd()
  for e in items(elem):
    writer.start(e.tag, e.attrs, useLine = false)

  writer.indent()
  writer.line()

proc finish*(writer; elems: openarray[HTagSpec]) =
  writer.dedent()
  writer.writeInd()
  for e in ritems(elems):
    writer.finish(e.tag, useLine = false)

  writer.line()


proc close*(writer) = writer.stream.write(">")
proc text*(writer; t: varargs[string]) = writer.stream.write(t)

proc closeEnd*(writer) =
  writer.stream.write("/>")

proc header*(writer) =
  writer.write("<!DOCTYPE html>\n")

const hInlineKinds* = {hB, hStrong, hI}

template wrap*(writer; t: HtmlNodeKind, body: untyped): untyped =
  writer.start(t)
  try: body finally: writer.finish(t)

template wrap*[N](writer; t: array[N, HtmlNodeKind], body: untyped): untyped =
  writer.start(t)
  try: body finally: writer.finish(t)

template wrap*[N](writer; t: array[N, HTagSpec], body: untyped): untyped =
  writer.start(t)
  try: body finally: writer.finish(t)

proc style*(writer; css: openarray[(string, seq[(string, string)])]) =
  writer.start(hStyle)
  for (select, properties) in css:
    writer.writeInd()
    writer.write(&"{select} ", "{")
    writer.line()
    writer.indent()
    for (key, val) in properties:
      writer.writeInd()
      writer.write(key, ": ", val, ";")
      writer.line()

    writer.dedent()

    writer.writeInd()
    writer.write("}")
    writer.line()

  writer.finish(hStyle)

const
  hRow* = hTr
  hCell* = hTh

template wrap*(writer; t: HtmlNodeKind, attrs: HAttrs, body: untyped): untyped =
  writer.start(t, attrs)
  try:
    body
  finally:
    writer.finish(t)


template wrap0*(writer; t: HtmlNodeKind; body: untyped): untyped =
  writer.writeInd()
  writer.start(t, useLine = false)
  try:
    body
  finally:
    writer.finish(t, false)
    writer.line()

proc link*(writer; url: string; text: string; class: string = "") =
  writer.open(hA, false)
  writer.attr("href", url)
  if class != "":
    writer.attr("class", class)
  writer.close()
  writer.text(text)
  writer.finish(hA, false)


proc link*(writer; entry: DocEntry; text: string) =
  writer.link(entry.fullIdent.toLink, text, $entry.kind)
