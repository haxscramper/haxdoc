import ../docentry
import std/[tables, sequtils, pegs]
import hmisc/[base_errors, hdebug_misc]

type
  DocFilterKind = enum
    dfkKindFilter
    dfkNameFilter
    dfkSigFilter

  DocSigPatternKind = enum
    dspkTrail
    dspkTypeId
    dspkGenPattern
    dspkProcPattern
    dspkChoice

  DocSigPattern = object
    elements*: seq[DocSigPattern]
    case kind*: DocSigPatternKind
      of dspkTrail:
        discard

      of dspkTypeId:
        typeId*: DocId

      of dspkChoice, dspkProcPattern:
        discard

      of dspkGenPattern:
        headName*: Peg

  DocFilter = object
    isInverted*: bool
    case kind*: DocFilterKind
      of dfkKindFilter:
        targetKinds*: set[DocEntryKind]

      of dfkNameFilter:
        targetName*: string

      of dfkSigFilter:
        targetSig*: DocSigPattern

  DocFilterGroupKind = enum
    dfgkOrGroup
    dfgkAndGroup

  DocFilterGroup = object
    kind*: DocFilterGroupKind
    filters*: seq[DocFilter]

  DocFilterPath = object
    path*: seq[DocFilterGroup]


using
  entry: DocEntry
  group: DocFilterGroup

iterator items*(group): DocFilter =
  for it in group.filters:
    yield it

func len*(group): int = len(group.filters)

func isAnd*(group): bool = group.kind == dfgkAndGroup
func isOr*(group): bool = group.kind == dfgkOrGroup

func targetKinds*(group): set[DocEntryKind] =
  for filter in group:
    if filter.kind == dfkKindFilter:
      result.incl filter.targetKinds

  if len(result) == 0:
    result = { low(DocEntryKind) .. high(DocEntryKind) }

func matches*(etype: DocType, sig: DocSigPattern): bool =
  case sig.kind:
    of dspkTrail:
      result = true

    of dspkChoice:
      for patt in sig.elements:
        if etype.matches(patt):
          return true

      return false

    of dspkTypeId:
      case etype.kind:
        of dtkIDent:
          result = etype.head == sig.typeId

        of dtkVarargs:
          result = etype.vaType.matches(sig)

        else:
          result = false

    of dspkGenPattern:
      case etype.kind:
        of {dtkIdent, dtkVarargs}:
          result = (etype.name =~ sig.headName)

          var argIdx = 0
          var sigIdx = 0
          while argIdx < etype.genParams.len and
                sigIdx < sig.elements.len:

            if sig.elements[sigIdx].kind == dspkTrail:
              return true

            elif not etype.genParams[argIdx].matches(
              sig.elements[sigIdx]):
              return false

            inc argIdx
            inc sigIdx

          return etype.genParams.len == sig.elements.len

        else:
          result = false

    of dspkProcPattern:
      etype.assertKind(dtkProc)

      var argIdx = 0
      var sigIdx = 0
      while argIdx < etype.arguments.len and
            sigIdx < sig.elements.len:

        if sig.elements[sigIdx].kind == dspkTrail:
          return true

        elif not etype.arguments[argIdx].identType.matches(
          sig.elements[sigIdx]):
          return false

        inc argIdx
        inc sigIdx

      return etype.arguments.len == sig.elements.len

func matches*(entry; filter: DocFilter): bool =
  case filter.kind:
    of dfkNameFilter:
      result = (entry.name == filter.targetName)

    of dfkSigFilter:
      case entry.kind:
        of dekProcKinds:
          result = entry.procType.matches(filter.targetSig)

        else:
          result = false

    else:
      raiseImplementKindError(filter)

func matches*(entry; group): bool =
  for filter in group:
    result = entry.matches(filter)

    if filter.isInverted:
      result = not result

    if not result and group.isAnd():
      result = false
      break

    if result and group.isOr():
      result = true
      break


iterator matching*(entry; group): DocEntry =
  let targetKinds = group.targetKinds()
  for nested in entry:
    if entry.matches(group):
      yield nested

let
  nimTyHeadChoice*: Peg = `/`(
    term("var"),
    term("sink"),
    term("ptr"),
    term("ref")
  )

func procPatt*(args: varargs[DocSigPattern]): DocSigPattern =
  DocSigPattern(kind: dspkProcPattern, elements: toSeq(args))

func genPatt*(head: string, args: varargs[DocSigPattern]): DocSigPattern =
  DocSigPattern(kind: dspkGenPattern, elements: toSeq(args), headName: term(head))

func genPatt*(head: Peg, args: varargs[DocSigPattern]): DocSigPattern =
  DocSigPattern(kind: dspkGenPattern, elements: toSeq(args), headName: head)

func sigPatt*(id: DocId): DocSigPattern =
  DocSigPattern(kind: dspkTypeId, typeId: id)

func sigPatt*(kind: DocSigPatternKind): DocSigPattern =
  DocSigPattern(kind: kind)

func choice*(alts: varargs[DocSigPattern]): DocSigPattern =
  DocSigPattern(kind: dspkChoice, elements: toSeq(alts))

func docFilter*(kind: set[DocEntryKind]): DocFilter =
  DocFilter(kind: dfkKindFilter, targetKinds: kind)

func docFilter*(kind: DocEntryKind): DocFilter =
  DocFilter(kind: dfkKindFilter, targetKinds: { kind })

func docFilter*(name: string): DocFilter =
  DocFilter(kind: dfkNameFilter, targetName: name)

func toFilter*(patt: DocSigPattern): DocFilter =
  DocFilter(kind: dfkSigFilter, targetSig: patt)

func toGroup*(patt: DocSigPattern): DocFilterGroup =
  DocFilterGroup(kind: dfgkAndGroup, filters: @[toFilter(patt)])

func toGroup*(filter: DocFilter): DocFilterGroup =
  DocFilterGroup(kind: dfgkAndGroup, filters: @[filter])

func toGroup*(group: sink DocFilterGroup): DocFilterGroup = group

iterator topMatching*(db: DocDb; group: DocFilterGroup | DocFilter): DocEntry =
  for _, entry in db.top:
    if entry.matches(toGroup(group)):
      yield entry

iterator allMatching*(db: DocDb; group: DocFilterGroup | DocFilter): DocEntry =
  for _, entry in db.entries:
    if entry.matches(toGroup(group)):
      yield entry

proc getProcsForType*(entry): seq[DocEntry] =
  for entry in entry.db.allMatching(toGroup(
    procPatt(choice(
      sigPatt(entry.id()),
      genPatt(nimTyHeadChoice, sigPatt(entry.id()))
    ), sigPatt(dspkTrail))
  )):
    result.add entry
