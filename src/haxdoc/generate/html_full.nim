import ../docentry, ../process/[docentry_query, docentry_group]
import
  hmisc/[helpers, base_errors, hdebug_misc],
  hmisc/hasts/html_ast2,
  haxorg/[semorg, ast]

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

proc link*(writer; entry: DocEntry; text: string) =
  writer.link(entry.fullIdent.toLink, text, $entry.kind)

proc writeHtml*(sem: SemOrg, writer: var HtmlWriter) =
  writer.text("tree")
