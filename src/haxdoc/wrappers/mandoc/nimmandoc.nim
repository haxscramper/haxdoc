import make_wrap
import hmisc/other/oswrap
import hpprint
import hmisc/algo/clformat

const dir = sourceDir / "mandoc-1.14.5"
const included = "-I" & $dir

{.passc: included.}
{.passc: "-lz".}
{.passl: "-lz".}

const compileFlags = ""

{.compile(dir /. "compat_err.c", compileFlags).}
{.compile(dir /. "mdoc_markdown.c", compileFlags).}
{.compile(dir /. "tbl_term.c", compileFlags).}
{.compile(dir /. "tbl_html.c", compileFlags).}
{.compile(dir /. "compat_strlcat.c", compileFlags).}
{.compile(dir /. "mandoc_aux.c", compileFlags).}
{.compile(dir /. "term_ps.c", compileFlags).}
{.compile(dir /. "man_html.c", compileFlags).}
{.compile(dir /. "roff_term.c", compileFlags).}
{.compile(dir /. "compat_getsubopt.c", compileFlags).}
{.compile(dir /. "mdoc_validate.c", compileFlags).}
{.compile(dir /. "msec.c", compileFlags).}
{.compile(dir /. "compat_isblank.c", compileFlags).}
{.compile(dir /. "man_macro.c", compileFlags).}
{.compile(dir /. "compat_reallocarray.c", compileFlags).}
{.compile(dir /. "att.c", compileFlags).}
{.compile(dir /. "mandoc.c", compileFlags).}
{.compile(dir /. "compat_strtonum.c", compileFlags).}
{.compile(dir /. "dbm.c", compileFlags).}
{.compile(dir /. "tbl_data.c", compileFlags).}
{.compile(dir /. "mdoc_macro.c", compileFlags).}
{.compile(dir /. "compat_strsep.c", compileFlags).}
{.compile(dir /. "dbm_map.c", compileFlags).}
{.compile(dir /. "tbl_layout.c", compileFlags).}
{.compile(dir /. "man_validate.c", compileFlags).}
{.compile(dir /. "mdoc.c", compileFlags).}
{.compile(dir /. "mdoc_argv.c", compileFlags).}
{.compile(dir /. "compat_strlcpy.c", compileFlags).}
{.compile(dir /. "read.c", compileFlags).}
{.compile(dir /. "mdoc_man.c", compileFlags).}
{.compile(dir /. "mdoc_state.c", compileFlags).}
{.compile(dir /. "eqn_term.c", compileFlags).}
{.compile(dir /. "dba_write.c", compileFlags).}
{.compile(dir /. "eqn.c", compileFlags).}
{.compile(dir /. "arch.c", compileFlags).}
{.compile(dir /. "mandoc_xr.c", compileFlags).}
{.compile(dir /. "dba_read.c", compileFlags).}
{.compile(dir /. "dba_array.c", compileFlags).}
{.compile(dir /. "out.c", compileFlags).}
{.compile(dir /. "tag.c", compileFlags).}
{.compile(dir /. "st.c", compileFlags).}
{.compile(dir /. "compat_recallocarray.c", compileFlags).}
{.compile(dir /. "dba.c", compileFlags).}
{.compile(dir /. "preconv.c", compileFlags).}
{.compile(dir /. "mandoc_ohash.c", compileFlags).}
{.compile(dir /. "compat_mkdtemp.c", compileFlags).}
{.compile(dir /. "compat_vasprintf.c", compileFlags).}
{.compile(dir /. "eqn_html.c", compileFlags).}
{.compile(dir /. "tbl_opts.c", compileFlags).}
{.compile(dir /. "compat_strcasestr.c", compileFlags).}
{.compile(dir /. "compat_fts.c", compileFlags).}
{.compile(dir /. "mdoc_html.c", compileFlags).}
{.compile(dir /. "mandoc_msg.c", compileFlags).}
{.compile(dir /. "term_ascii.c", compileFlags).}
{.compile(dir /. "man.c", compileFlags).}
{.compile(dir /. "term_tab.c", compileFlags).}
{.compile(dir /. "term.c", compileFlags).}
{.compile(dir /. "tree.c", compileFlags).}
{.compile(dir /. "tbl.c", compileFlags).}
{.compile(dir /. "chars.c", compileFlags).}
{.compile(dir /. "compat_stringlist.c", compileFlags).}
{.compile(dir /. "man_term.c", compileFlags).}
{.compile(dir /. "roff.c", compileFlags).}
{.compile(dir /. "roff_validate.c", compileFlags).}
{.compile(dir /. "compat_ohash.c", compileFlags).}
{.compile(dir /. "compat_progname.c", compileFlags).}
{.compile(dir /. "mansearch.c", compileFlags).}
{.compile(dir /. "lib.c", compileFlags).}
{.compile(dir /. "roff_html.c", compileFlags).}
{.compile(dir /. "mdoc_term.c", compileFlags).}
{.compile(dir /. "compat_getline.c", compileFlags).}
{.compile(dir /. "manpath.c", compileFlags).}
{.compile(dir /. "html.c", compileFlags).}
{.compile(dir /. "compat_strndup.c", compileFlags).}

{.push warning[UnusedImport]: off.}

import
  ./mansearch,
  ./mandoc_parse,
  ./mandoc_aux,
  ./mandoc,
  ./roff,
  ./mdoc,
  ./manconf,
  ./main,
  ./tbl

import
  std/[strformat, strutils, options, sequtils],
  hmisc/types/colorstring,
  hmisc/[hdebug_misc, helpers]

export
  mansearch, mandoc_parse, mandoc_aux, mandoc,
  roff, mdoc, manconf, main, tbl


type
  PRoffNode* = ptr RoffNode
  PTblSpan* = ptr TblSpan
  PTblDat* = ptr TblDat

func kind*(node: PRoffNode): RoffType = node.cxType.toRoffType()
func tokKind*(node: PRoffNode): RoffTok = node.tok.toRoffTok()

iterator items*(dat: PTblDat): PTblDat =
  var dat = dat
  while not isNil(dat):
    yield dat
    dat = dat.next

iterator pairs*(dat: PTblDat): (int, PTblDat) =
  var cnt = 0
  for dat in items(dat):
    yield (cnt, dat)
    inc cnt

template lenEqImpl(inNode: typed, val: typed): untyped =
  var result = false
  var found = false
  var over = false
  for idx, node in pairs(inNode):
    if idx == val:
      found = true

    if idx > val:
      # Overshot
      over = true
      break

  if over:
    result = false

  elif not found and val == 0:
    result = true

  else:
    result = found

  result

func len*(dat: PTblDat): int =
  for _ in items(dat):
    inc result


func lenEq*(dat: PTblDat, val: int): bool = lenEqImpl(dat, val)

iterator items*(node: PRoffNode): PRoffNode =
  if not isNil(node.child):
    var next = node.child
    while not isNil(next):
      yield next
      next = next.next

iterator pairs*(node: PRoffNode): (int, PRoffNode) =
  var cnt = 0
  for sub in items(node):
    yield (cnt, sub)
    inc cnt

func len*(node: PRoffNode): int =
  ## Get number of subnodes for `node`.
  ##
  ## - NOTE :: Due to how underlying AST subnodes are stored this
  ##   operation takes `O(n)`
  for sub in items(node):
    inc result


func lenEq*(node: PRoffNode, val: int): bool =
  ## Faster check for node len. Using `len(node) == 0` will make it compute
  ## full length of the node, but `node.lenEq(0)` will only traverse as
  ## much nodes as needed
  lenEqImpl(node, val)


func `[]`*(node: PRoffNode, idx: int): PRoffNode =
  for cnt, sub in pairs(node):
    if cnt == idx:
      return sub

func `[]`*(node: PRoffNode, slice: Slice[int]): seq[PRoffNode] =
  for cnt, sub in pairs(node):
    if cnt in slice:
      result.add sub

func `[]`*(node: PRoffNode, slice: HSlice[int, BackwardsIndex]): seq[PRoffNode] =
  for cnt, sub in pairs(node):
    if slice.a <= cnt:
      result.add sub

  for _ in 0 ..< slice.b.int:
    discard result.pop

func strVal*(node: PRoffNode): string = $node.cxString

func mandocEscape*(str: string): Option[tuple[kind: MandocEsc, escLen: int]] =
  ## Parse optional leading roff escape character and return it's class
  ## together with total number of characters for escape, including
  ## backslash and identifier.
  ##
  ## - @ex{("\fItext") -> some((mscFontBi, 3))} - italic font, three characters
  ##   for the whole escape sequence.
  if str.len < 2 or str[0] != '\\':
    return

  var
    str = str
    pStart: cstring = cast[cstring](addr str[1])

    pFinish: ptr[cstring]
    lenVal: cint

  let esc = mandocEscape(
    cast[cstringarray](addr pStart),
    cast[cstringarray](addr pFinish),
    addr lenVal
  )

  return some((toMandocEsc(
    # FIXME font bold has number 7. Wrapped enum has the same order, but
    # for some reason all values are off-by-one, and this hack is needed to
    # differentiate between enum kinds.
    cast[MandocEscC](cast[int](esc))), int(lenVal) + 2))

type
  RoffText* = object
    str*: string
    escape*: Option[MandocEsc]
    escapeText*: string
    pos*: int

proc unescapeRoff*(str: string): string =
  var idx = 0
  while idx < str.len:
    if idx == str.high:
      result.add str[idx]

    elif str[idx] == '\\':
      case str[idx + 1]:
        of {'|', '&'}: inc idx
        else:
          inc idx
          result.add str[idx]

    else:
      result.add str[idx]

    inc idx


proc splitRoffText*(str: string): seq[RoffText] =
  var
    pos = 0
    start = 0
  while pos < str.len:
    if str[pos] == '\\':
      if pos < str.high and str[pos + 1] in {'-', '(', ',', '|', '&'}:
        inc pos

      else:
        if start != pos:
          result.add RoffText(
            str: str[start ..< pos].unescapeRoff(), pos: start)

        let escapeStart = pos
        let (kind, escLen) = mandocEscape(str[pos .. ^1]).get()

        let escapeText = str[
          (escapeStart + 1) ..< min(str.len, escapeStart + escLen)]

        result.add RoffText(
          escape: some(kind),
          escapeText: escapeText,
          pos: escapeStart
        )

        pos += escLen
        start = pos

    else:
      inc pos

  if start != pos:
    result.add RoffText(
      str: str[start ..< pos].unescapeRoff(), pos: start)


proc roffTextFormat*(str: string, colored: bool = true): string =
  let split = splitRoffText(str)
  for idx, elem in split:
    if result.len > 0 and result[^1] != ' ':
      result &= " "

    if elem.escape.isSome():
      result &= &"({toGreen($elem.escape.get())}"
      if elem.escapeText.len > 0:
        result &= " " & elem.escapeText

      result &= "))"

    if elem.str.len > 0:
      if result.len > 0 and result[^1] != ' ':
        result &= " "

      result &= &"\"{elem.str.toYellow(colored)}\""


proc treeRepr*(node: PRoffNode, colored: bool = true, level: int = 0): string
proc treeRepr*(tbl: PTblSpan, colored: bool = true, level: int = 0): string =
  let cols = tbl.opts.cols
  let pref = "  ".repeat(level)
  result = pref & "\n"

  for idx, dat in tbl.first:
    if idx > 0:
      result &= "\n"
    result &= &"{pref}[{idx}] {roffTextFormat($dat.cxString, colored)}"

  # var row = tbl.layout
  # while not isNil(row):
  #   result &= pref & "ROW\n" & pref & "  "
  #   var col = row.first
  #   while not isNil(col):
  #     result &= &"[{col.wstr}]"
  #     # result &= treeRepr()
  #     col = col.next

  #   result &= "\n"

  #   row = row.next

proc treeRepr*(node: PRoffNode, colored: bool = true, level: int = 0): string =
  proc aux(node: PRoffNode, level: int): string =
    let pref = "  ".repeat(level)
    result = &"{pref}{node.kind} [{node.line}:{node.pos}]"
    # if node.
    case node.kind:
      of rtText:
        let str = node.strVal()
        if '\n' in str:
          result &= "\n"
          result &= str.indent(level * 2 + 2).toYellow(colored)

        else:
          result &= " " & roffTextFormat(str, colored)

      of rtElem, rtBlock, rtHead, rtBody:
        result &= " " & toCyan($node.tokKind())

      of rtTbl:
        if node.span.first.lenEq(0):
          return ""

        result &= treeRepr(node.span, colored, level + 1)

      else:
        discard

    result &= "\n"
    for sub in items(node):
      result &= aux(sub, level + 1)

  return aux(node, level)

type
  NRoffNodeKind* = enum
    rnkText
    rnkSection
    rnkStmtList
    rnkBlock
    rnkComment
    rnkParagraph
    rnkEmptyNode

    rnkFontBold
    rnkFontItalic
    rnkFontRoman
    rnkFontCw
    rnkFontMono
    rnkFontNf

    rnkIndented
    rnkRelativeInset
    rnkTaggedParagraph


  NRoffNode* = ref object
    line*: int
    column*: int
    case kind*: NRoffNodeKind
      of rnkText:
        textVal*: string

      else:
        subnodes*: seq[NRoffNode]

import std/sets
RS [indent]
              Start a new relative inset level, moving the left margin
              right

func treeRepr*(
    nr: NRoffNode, opts: HDisplayOpts = defaultHDisplay): string =

  var visited: HashSet[int]
  func aux(n: NRoffNode, level: int): string =
    if isNil(n):
      return "  ".repeat(level) & toRed("<nil>", opts.colored)

    if cast[int](n) notin visited:
      visited.incl cast[int](n)

    else:
      return "  ".repeat(level) & toBlue("<visited>", opts.colored)

    result = "  ".repeat(level) & hShow(n.kind, opts) & " " &
      hShow(n.line .. n.column) & " "
    case n.kind:
      of rnkText:
        result &= hShow(n.textVal, opts.withIt((
          it.indent = level * 2 + 2)))

      else:
        for sub in n.subnodes:
          result &= "\n" & aux(sub, level + 1)

  return aux(nr, 0)

func newTree*(kind: NRoffNodeKind, subnodes: varargs[NRoffNode]):
    NRoffNode =

  result = NRoffNode(kind: kind)
  if subnodes.len > 0:
    result.subnodes = toSeq(subnodes)

func newTree*(kind: NRoffNodeKind, str: string):
    NRoffNode =

  result = NRoffNode(kind: kind)
  result.textVal = str


func add*(r: var NRoffNode, other: NRoffNode | seq[NRoffNode]) =
  r.subnodes.add other

func len*(n: NRoffNode): int = n.subnodes.len
func `[]`*(n: NRoffNode, idx: int | BackwardsIndex): NRoffNode =
  n.subnodes[idx]


func mergeNode*(roff: var NRoffNode, other: NRoffNode, sep: char = '\n') =
  if roff.subnodes.len > 0 and
     other.kind == rnkText and
     roff.subnodes[^1].kind == rnkText:

    roff.subnodes[^1].textVal &= $sep & other.textVal

  else:
    roff.add other


func toNRoffText*(text: string, line, column: int): NRoffNode =
  let parts = text.splitRoffText()
  if parts.len == 1:
    return NRoffNode(
      kind: rnkText, textVal: text.unescapeRoff(), line: line, column: column)

  var stack: seq[seq[tuple[
    pending: bool, node: NRoffNode]]] = @[@[(true, rnkParagraph.newTree())]]

  var column = column

  proc pushNode(node: NRoffNode) =
    let pending = node.kind != rnkText
    node.line = line
    node.column = column
    if stack.len > 0 and stack.last2().pending:
      stack.add @[@[(pending, node)]]

    else:
      stack.last().add (pending, node)

  proc closeLayer() =
    let layer = stack.pop()
    if (
      stack.len > 0 and
      stack.last().len > 0 and
      stack.last2.pending
    ):
      for it in layer:
        stack.last2.node.mergeNode(it.node, ' ')

      stack.last2.pending = false

    elif stack.len == 0:
      stack.add @[layer]

    else:
      stack.last.add layer

  # echov "--"
  # debugecho roffTextFormat(text)

  for part in parts:
    column = part.pos
    if part.escape.isSome():
      case part.escape.get():
        of mscFontBold: pushNode rnkFontBold.newTree()
        of mscFontItalic: pushNode rnkFontItalic.newTree()
        of mscFontCw: pushNode rnkFontCw.newTree()
        of mscSpecial: pushNode rnkText.newTree("\\")
        # of mscFontRt: pushNode rnkFontRt.newTree()
        of mscIgnore: discard
        of mscFontRoman:
          closeLayer()

        else:
          raise newImplementKindError(
            part.escape.get(), line, column)

    else:
      pushNode rnkText.newTree(part.str)


  while stack.len > 1:
    closeLayer()

  result = stack[0][0].node
  if result.len == 1:
    return result[0]


func toNRoffNode*(roff: PRoffNode): NRoffNode =
  if isNil(roff):
    return rnkEmptyNode.newTree()

  case roff.kind:
    of rtRoot, rtBody:
      result = rnkStmtList.newTree()

      for sub in roff:
        let node = toNRoffNode(sub)
        if not isNil(node):
          result.mergeNode node


    of rtBlock:
      if roff[0].kind == rtHead and
         roff[1].kind == rtBody:

        case roff.tokKind:
          of rtManSh, rtManSs, rtManTp:
            result = rnkSection.newTree(
              roff[0][0].toNRoffNode(),
              roff[1].toNRoffNode()
            )

          of rtManPp:
            result = roff[1].toNRoffNode()

          of rtManIp:
            # `.IP` "Set an indented paragraph with an optional tag."
            result = rnkIndented.newTree(roff[1].toNRoffNode)

          of rtManRs:
            # `.RS` Start a new relative inset level, moving the left
            # margin right
            result = rnkRelativeInset.newTree(roff[1].toNRoffNode())

          # of rtManTp:
          #   result = rnkTaggedParagraph.newTree(roff[1].toNRoffNode())

          else:
            raise newImplementKindError(
              roff.tokKind(), roff.line, roff.pos)


      else:
        result = rnkBlock.newTree()
        for sub in roff:
          let node = toNRoffNode(sub)
          if not isNil(node):
            result.mergeNode node

    of rtHead:
      result = rnkSection.newTree(roff[0].toNRoffNode())

    of rtText:
      result = toNRoffText(roff.strVal(), roff.line, roff.pos)

    of rtComment:
      result = rnkComment.newTree()

    of rtElem:
      case roff.tokKind():
        of rtManB: result = rnkFontBold.newTree(roff[0].toNRoffNode())
        of rtRoffBr, rtManPd: discard
        of rtRoffSp: result = rnkText.newTree(" ")
        of rtRoffFt: result = rnkFontMono.newTree(roff[0].toNRoffNode())
        of rtRoffNf: result = rnkFontNf.newTree(roff[0].toNRoffNode())
        of rtRoffFi: result = rnkFontItalic.newTree(roff[0].toNRoffNode())
        else:
          raise newImplementKindError(roff.tokKind, roff.treeRepr())

    else:
      raise newImplementKindError(roff, roff.treeRepr())

  if isNil(result):
    result = rnkEmptyNode.newTree()


  result.line = roff.line
  result.column = roff.pos
