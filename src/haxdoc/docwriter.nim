import docentry
import std/[streams, strutils, tables, xmltree]
import hmisc/other/[oswrap]

type
  WriteContext = ref object
    stream: Stream
    indentWidth: int

using ctx: WriteContext

proc writeIndent*(ctx) = ctx.stream.write("  ".repeat(ctx.indentWidth))
proc write*(ctx; value: string) =
  ctx.stream.write(xmltree.escape(value))

proc writeRaw*(ctx; value: string) =
  ctx.stream.write(value)

proc indent*(ctx) = ctx.writeIndent(); inc ctx.indentWidth
proc dedent*(ctx) = dec ctx.indentWidth; ctx.writeIndent()

proc openTag*(
    ctx; tag: string, attrs: openarray[(string, string)] = @[]) =
  ctx.indent()
  ctx.writeRaw("<")
  ctx.write(tag)
  for (key, value) in attrs:
    ctx.write key
    ctx.writeRaw "=\""
    ctx.write value
    ctx.writeRaw "\" "

  ctx.writeRaw(">\n")


proc fullTag*(
    ctx; tag: string, attrs: openarray[(string, string)] = @[]) =
  ctx.writeIndent()
  ctx.writeRaw("<")
  ctx.write(tag)
  for (key, value) in attrs:
    ctx.write key
    ctx.writeRaw "=\""
    ctx.write value
    ctx.writeRaw "\" "

  ctx.writeRaw "/>\n"


proc closeTag*(ctx; tag: string) =
  ctx.dedent()
  ctx.writeRaw("</")
  ctx.write(tag)
  ctx.writeRaw(">\n")


proc writeXml*(ctx; part: DocIdentPart) =
  ctx.fullTag("part", {"name" : $part.name, "kind": $part.kind})

proc writeXml*(ctx; full: DocFullIdent) =
  ctx.openTag("indent")

  for part in full.parts:
    ctx.writeXml(part)

  ctx.closeTag("indent")

proc writeIdentMapXml*(ctx; db: DocDb) =
  for full, id in pairs(db.fullIdents):
    ctx.openTag("entry", { "id" : $id.id })
    ctx.writeXml(full)
    ctx.closeTag("entry")

proc newWriteContext*(file: AbsFile): WriteContext =
  # assertExists(file)
  WriteContext(stream: newFileStream(file.getStr(), fmWrite))
