import ../docentry
import std/[tables]
import hmisc/[base_errors, hdebug_misc]

type
  DocFilterKind = enum
    dfkKindFilter
    dfkNameFilter
    dfkSigFilter

  DocSigPatternKind = enum
    dspkTrail
    dspkTypeId
    dspkPattern

  DocSigPattern = object
    case kind*: DocSigPatternKind
      of dspkTrail:
        discard

      of dspkTypeId:
        typeId*: DocId

      of dspkPattern:
        headKind*: DocTypeKind
        arguments*: seq[DocSigPattern]

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

    of dspkTypeId:
      result = etype.head == sig.typeId

    of dspkPattern:
      result = (etype.kind == sig.headKind)

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

func sigPatt*(typeKind: DocTypeKind, args: seq[DocSigPattern]): DocSigPattern =
  DocSigPattern(kind: dspkPattern, headKind: typeKind, arguments: args)

func sigPatt*(id: DocId): DocSigPattern =
  DocSigPattern(kind: dspkTypeId, typeId: id)

func sigPatt*(kind: DocSigPatternKind): DocSigPattern =
  DocSigPattern(kind: kind)

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
    sigPatt(dtkProc, @[sigPatt(entry.id()), sigPatt(dspkTrail)])
  )):
    result.add entry
