import
  ../wrappers/mandoc/nimmandoc,
  ../docentry,
  ../docentry_io,
  std/[strutils, sequtils, tables, sets],
  hmisc/other/[oswrap, cliparse],
  hmisc/[base_errors, hdebug_misc],
  hmisc/algo/[hlex_base, htemplates, hstring_algo],
  haxorg/semorg,
  hpprint

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
      # echov node.textVal
      node.textVal.startsWith("-"):

    else:
      node[0].isOptStart()

func isPunctuation(node): bool =
  if node.kind == rnkText and
     node.textVal.allIt(it in PunctSentenceChars + AllSpace):
    true

  else:
    false

func isKvSeparator(node): bool =
  node.kind == rnkText and
  node.textVal.allIt(it in {'=', '['} + AllSpace) and
  node.textVal.anyIt(it in {'=', '[', ':'})

func isOptionalKv(node): bool =
  node.kind == rnkText and
  node.textVal.startsWith("[=")

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
        echov failColumn
        result = -1

    else:
      if sub.findLikeOpt() != -1:
        return idx


func toOpt(node): CliOpt =
  func aux(n: NRoffNode, opt: var CliOpt) =
    case n.kind:
      of rnkText:
        opt.keyPath = @[n.textVal]

      else:
        for sub in n:
          aux(sub, opt)

  aux(node, result)

func flatPlainText(node): string =
  case node.kind:
    of rnkText: result = node.textVal
    else:
      for sub in node:
        result &= sub.flatPlaintext()

func splitFlags(node): tuple[opts: seq[CliOpt], docs: NRoffNode] =
  var idx = 0
  while idx < node[0].len:
    let it = node[0][idx]
    if it.isOptStart():
      result.opts.add it.toOpt()

    elif it.isPunctuation():
      discard

    elif it.isKvSeparator():
      inc idx
      result.opts[^1].valStr = node[0][idx].flatPlaintext()
      if it.isOptionalKv():
        inc idx

    else:
      raise newUnexpectedKindError(
        it, node[0].treeRepr())

    inc idx

  result.docs = node[1]



func newOpts(ctx; node): DocEntry =
  let (opts, docs) = node.splitFlags()
  let name = opts.getMaxIt(it.key.len()).key.dropPrefix(
    toStrPart ["--", "-"])

  result = ctx.top.newDocEntry(dekShellOption, name)



proc registerDesc(ctx; node; reg: RegStack) =
  var lastOpt: DocEntry
  for sub in node:
    case sub.kind:
      of rnkText: discard # TODO add text
      of rnkParagraph: discard
      of rnkSection, rnkStmtList:
        if sub.isOptStart():
          lastOpt = ctx.newOpts(sub)

        else:
          registerDesc(ctx, sub, reg)

      of rnkIndented:
        let org = sub.toSemOrg()
        # TODO append documentation to last option

      else:
        raise newUnexpectedKindError(
          sub.kind, sub.treeREpr())


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
        of "SEE ALSO": discard # TODO implement mapping to code links
        of "AUTHOR", "REPORTING BUGS", "COPYRIGHT":
          discard
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

  return ctx.db

when isMainModule:
  startHax()
  let db = findManpage("ls").generateDocDb()
  # pprint db
  db.writeDbXml(getAppTempDir(), "ls")
  echov "ok"
