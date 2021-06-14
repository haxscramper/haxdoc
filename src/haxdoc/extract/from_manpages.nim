import
  ../wrappers/mandoc/nimmandoc,
  ../docentry,
  std/[strutils],
  hmisc/other/oswrap,
  hmisc/[base_errors, hdebug_misc],
  haxorg/semorg

type
  ConvertContext = enum
    ccNone
    ccDescription

  RegStack = object
    context: seq[ConvertContext]

  ManContext = object
    file: AbsFile
    db: DocDB
    top: DocEntry

using
  ctx: var ManContext
  node: NRoffNode



func `+`(reg: RegStack, conv: ConvertContext): RegStack =
  result = reg
  result.context.add conv

func top(reg: RegStack): ConvertContext = reg.context[^1]


proc toSemOrg(node): SemOrg = discard

func isOptStart(node): bool =
  case node.kind:
    of rnkText:
      echov node.textVal
      node.textVal.startsWith("-"):

    else:
      node[0].isOptStart()



func findLikeOpt(node): int =
  var
    failColumn = 0
    failLine = 0

  for idx, sub in pairs(node):
    if sub.kind == rnkText:
      if isOptStart(sub):
        return idx

      else:
        failColumn = sub.column
        failLine = sub.line
        result = -1

    else:
      if sub.findLikeOpt() != -1:
        return idx



func newOpts(ctx; node) =
  raise newUnexpectedKindError(node, node.treeRepr())

proc registerDesc(ctx; node; reg: RegStack) =
  var inOpts = false
  for sub in node:
    if not inOpts:
      case sub.kind:
        of rnkText: discard # TODO add text
        of rnkParagraph: discard
        of rnkSection, rnkStmtList:
          let idx = sub.findLikeOpt()
          echov idx
          if idx != -1:
            inOpts = true

        else:
          raise newUnexpectedKindError(sub.kind)

    if inOpts:
      let offset = sub.findLikeOpt()

      for idx, entry in sub:
        if idx < offset: continue
        ctx.newOpts(entry)

proc register(ctx; node; reg: RegStack) =
  case node.kind:
    of rnkStmtList:
      for sub in node:
        ctx.register(sub, reg)

    of rnkComment:
      discard

    of rnkSection:
      case node[0].textVal:
        of "NAME": ctx.top.docText.docBrief = node[1].toSemOrg()
        of "SYNOPSIS": discard
        of "DESCRIPTION":
          ctx.registerDesc(node, reg + ccDescription)

        else:
          raise newImplementKindError(
            node[0].textVal, node.treeRepr())


    else:
      raise newImplementKindError(node, node.treeREpr())

proc generateDocDb*(file: AbsFile, startDb: DocDb = newDocDb()): DocDb =
  let node = parseNRoff(file)

  var ctx = ManContext(db: startDb, file: file)

  ctx.top = ctx.db.newDocEntry(dekShellCmd, "zzzz")

  ctx.register(node, RegStack(context: @[ccNone]))

when isMainModule:
  startHax()
  let db = findManpage("ls").generateDocDb()
