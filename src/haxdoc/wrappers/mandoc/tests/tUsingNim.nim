import ../nimmandoc
import std/[strformat, strutils, options]
import hmisc/types/colorstring
import hmisc/[hdebug_misc, helpers]

type
  PRoffNode = ptr RoffNode
  PTblSpan = ptr TblSpan
  PTblDat = ptr TblDat

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
    cast[MandocEscC](cast[int](esc) - 1)), int(lenVal) + 2))

type
  RoffText = object
    str: string
    escape: Option[MandocEsc]
    escapeText: string

proc splitRoffText*(str: string): seq[RoffText] =
  var pos = 0
  while pos < str.len and str[pos] != '\\':
    inc pos

  result.add RoffText(str: str[0 ..< pos])

  while pos < str.len:
    let escapeStart = pos
    let kind = mandocEscape(str[pos .. ^1]).get()
    pos += kind.escLen

    let start = pos
    while pos < str.len and str[pos] != '\\':
      inc pos

    result.add RoffText(
      str: str[start ..< pos],
      escape: some(kind.kind),
      escapeText: str[(escapeStart + 1) ..<
                      min(str.len, escapeStart + kind.escLen)]
    )


proc roffTextFormat(str: string, colored: bool = true): string =
  let split = splitRoffText(str)
  for idx, elem in split:
    if result.len > 0 and result[^1] != ' ':
      result &= " "

    if elem.escape.isSome():
      result &= &"({toGreen($elem.escape.get())}"
      if elem.escapeText.len > 0:
        result &= " " & elem.escapeText

      result &= ")"

    if elem.str.len > 0:
      if result.len > 0 and result[^1] != ' ':
        result &= " "

      result &= &"\"{elem.str.toYellow(colored)}\""


proc treeRepr(node: PRoffNode, colored: bool = true, level: int = 0): string
proc treeRepr(tbl: PTblSpan, colored: bool = true, level: int = 0): string =
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

proc treeRepr(node: PRoffNode, colored: bool = true, level: int = 0): string =
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

mcharsAlloc()
var mp = mparseAlloc(
  toCInt({mpSO, mpUTF8, mpLatiN1, mpValidate}),
  mdosOther,
  "linux".cstring
)

# let file = "/usr/share/man/man3/write.3p.gz"
let file = "/tmp/write"

var fd = mp.mparseOpen(file.cstring)
mparseReadfd(mp, fd, file.cstring)
var meta = mparseResult(mp)
echo isNil(meta)
echo isNiL(meta.first.child)
treeMan(nil, meta)

startHax()
echo treeRepr(meta.first)
