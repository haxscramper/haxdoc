import ../docentry, ../process/[docentry_query, docentry_group]
import hmisc/[helpers, base_errors, hdebug_misc]


func toLink*(t: DocType): string =
  case t.kind:
    of dtkProc:
      for arg in t.arguments:
        result &= "," & toLink(arg.identType)

    else:
      result = $t

func toLink*(full: DocFullIdent): string =
  for part in full.parts:
    case part.kind:
      of dekModule: result &= part.name & "_"
      of dekProc:
        result &= part.name & "(" & part.procType.toLink() & ")"

      else:
        raiseImplementKindError(part)
