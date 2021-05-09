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
    ignoreIndent: int
    ignoreLine: int
    useLine: bool

using writer: var HtmlWriter

proc newHtmlWriter*(stream: Stream): HtmlWriter =
  HtmlWriter(stream: stream, useLine: true)

proc newHtmlWriter*(file: AbsFile): HtmlWriter =
  newHtmlWriter(newFileStream(file, fmWrite))

proc newHtmlWriter*(file: File): HtmlWriter =
  newHtmlWriter(newFileStream(file))

proc space*(writer) = writer.stream.write(" ")
proc line*(writer) =
  if writer.ignoreLine == 0:
    writer.stream.write("\n")

  else:
    dec writer.ignoreLine

proc write*(writer; text: varargs[string]) = writer.stream.write(text)
proc indent*(writer) = writer.indentBuf.add "  "
proc dedent*(writer) =
  writer.indentBuf.setLen(max(writer.indentBuf.len - 2, 0))

proc ignoreNextIndent*(writer) = inc writer.ignoreIndent
proc ignoreNextLine*(writer) = inc writer.ignoreLine

proc writeInd*(writer) =
  if writer.ignoreIndent > 0:
    dec writer.ignoreIndent

  else:
    writer.stream.write(writer.indentBuf)


proc start*(writer; elem: HtmlNodeKind) =
  if writer.useLine: writer.writeInd(); writer.indent()
  writer.write("<", $elem, ">")
  if writer.useLine: writer.line()

proc setLine*(writer; useLine: bool) = writer.useLine = useLine

proc finish*(writer; elem: HtmlNodeKind) =
  if writer.useLine: writer.dedent(); writer.writeInd()
  writer.write("</", $elem, ">")
  if writer.useLine: writer.line()

proc open*(writer; elem: HtmlNodeKind) =
  if writer.useLine: writer.writeInd()
  writer.write("<", $elem)

func htmlEscape*(str: string): string =
  # TODO
  str

proc attr*(writer; attr, val: string) =
  writer.write(&" {attr}={htmlEscape(val)}")

proc close*(writer) = writer.stream.write(">")
proc text*(writer; t: varargs[string]) = writer.stream.write(t)

proc closeEnd*(writer) =
  writer.stream.write("/>")
  if writer.useLine: writer.line()

const hInlineKinds* = {hB, hStrong, hI}

template wrap*(writer; t: HtmlNodeKind, body: untyped): untyped =
  writer.start(t)
  try:
    body
  finally:
    writer.finish(t)

template inline*(writer; body: untyped): untyped =
  writer.setLine(false)
  try:
    body
  finally:
    writer.ignoreNextIndent()
    writer.ignoreNextLine()
    writer.setLine(true)

proc link*(writer; url: string; text: string) =
  writer.open(hA)
  writer.attr("href", url)
  writer.close()
  writer.text(text)
  writer.finish(hA)


proc link*(writer; entry: DocEntry; text: string) =
  writer.link(entry.fullIdent.toLink, text)
