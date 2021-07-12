## Definition of shared documentable entry

import haxorg/[ast, semorg]
import hmisc/other/[oswrap, hjson]
import hmisc/types/hmap
import hmisc/algo/[hseq_mapping, halgorithm, hlex_base, clformat]
import hmisc/[hdebug_misc, helpers, hexceptions]
import std/[options, tables, hashes, enumerate,
            strformat, sequtils, intsets]
import nimtraits

import ./docentry_types
export docentry_types

storeTraits(DocEntry, dekAliasKinds, dekProcKinds, dekStructKinds)

storeTraits(DocExtent)
storeTraits(DocText)
storeTraits(DocPos)
storeTraits(DocLocation)
storeTraits(DocAdmonition)
storeTraits(DocMetatag)
storeTraits(DocTypeKind)
storeTraits(DocOccurKind)
storeTraits(DocOccur, dokLocalKinds)
storeTraits(DocTypeHeadKind)
storeTraits(DocIdentKind)
storeTraits(DocId)
storeTraits(DocLinkPart, dekProcKinds)
storeTraits(DocLink)
storeTraits(DocType)
storeTraits(DocFile)
storeTraits(DocDb)
storeTraits(DocIdent)
storeTraits(DocPragma)
storeTraits(DocCode)
storeTraits(DocCodePart)
storeTraits(DocCodeSlice)
storeTraits(DocCodeLine)
# storeTraits(DocRequires)

proc newDocIdent*(name: string, idType: DocType): DocIdent =
  DocIdent(ident: name, identType: idType)

proc newDocType*(args: seq[DocType], returnType: Option[DocType]): DocType =
  result = DocType(kind: dtkProc)
  for arg in args:
    result.arguments.add newDocIdent("", arg)

  result.returnType = returnType



proc newDocType*(kind: DocTypeKind, head: DocEntry): DocType =
  result = DocType(kind: kind)
  result.head = head.fullIdent.docId

proc newDocType*(kind: DocTypeKind, name: string, id: DocId): DocType =
  result = DocType(kind: kind, name: name)
  result.head = id

proc newDocType*(kind: DocTypeKind, name: string = ""): DocType =
  result = DocType(kind: kind, name: name)

proc newDocRequires*(): DocRequires = discard

proc vaType*(t: DocType): DocType =
  assertKind(t, {dtkVarargs})
  return t.genParams[0]

proc vaConverter*(t: DocType): Option[DocType] =
  assertKind(t, {dtkVarargs})
  if t.genParams.len > 1:
    return some t.genParams[1]

func `$`*(dk: DocEntryKind): string = toString(dk)[3 ..^ 1]
func `$`*(dk: DocOccurKind): string = toString(dk)[3 ..^ 1]
func `$`*(t: DocType): string
func `$`*(t: DocIdent): string =
  result = t.ident & ": " & $t.identType
  if t.value.isSome():
    result &= " = " & t.value.get()

func `$`*(t: DocType): string =
  case t.kind:
    of dtkIdent:
      result = t.name
      if t.genParams.len > 0:
        result &= t.genParams.mapIt($it).join(", ").wrap("[", "]")

    of dtkGenericSpec:
      result = t.name
      result &= t.genParams.mapIt($it).join(" | ")

    of dtkGenericParam:
      result = t.paramName

    of dtkNone:
      result = ""

    of dtkRange:
      result = "range[" & t.rngStart & " .. " & t.rngEnd & "]"

    of dtkTypeofExpr:
      result = "typeof(" & t.value & ")"

    of dtkValue:
      result = t.value

    of dtkNamedTuple:
      result &= "tuple[" & t.arguments.mapIt($it).join(", ") & "]"

    of dtkAnonTuple:
      result &= "(" & t.genParams.mapIt($it).join(", ") & ")"

    of dtkProc:
      result &= "proc(" & t.arguments.mapIt($it).join(", ") & ")"
      if t.returnType.isSome():
        result &= ": " & $t.returnType.get()

    of dtkVarargs:
      result = "varargs[" & $t.vaType
      if t.vaConverter.isSome():
        result &= ", " & $t.vaConverter.get()

      result &= "]"

    else:
      raiseImplementKindError(t)

func `$`*(part: DocCodePart): string =
  if part.occur.isSome():
    let occur = part.occur.get()
    result.add hshow(occur.kind)
    result.add " "
    if occur.kind in dokLocalKinds:
      result.add hshow(occur.localId)
      result.add " "

  result.add hshow(part.slice.line .. part.slice.column)

func hasRefid*(part: DocCodePart): bool =
  part.occur.isSome() and
  part.occur.get().kind notin dokLocalKinds

func getRefid*(part: DocCodePart): DocId =
  part.occur.get().refid


func `[]`*(line: DocCodeLine, part: DocCodePart): string =
  let
    rangeMin = part.slice.column.a.clamp(0, line.text.high)
    rangeMax = part.slice.column.b.clamp(0, line.text.high)

  if line.text.len == 0:
    result = repeat(" ", part.slice.column.b - part.slice.column.a)

  else:
    result = line.text[rangeMin .. rangeMax]

func hash*(id: DocId): Hash = hash(id.id)
func hash*[T](o: Option[T]): Hash =
  if o.isSome(): return hash(o.get())


func hash*(t: DocType): Hash

func hash*(p: DocPragma): Hash =
  !$(hash(p.name) !& hash(p.entry)
  # !& hash(p.args) # FIXME hash arguments

  )

func hash*(i: DocIdent): Hash =
  !$(
    hash(i.ident) !&
    hash(i.kind) !&
    hash(i.identType) !&
    hash(i.value) !&
    hash(i.entry)
  )

func hash*(t: DocType): Hash =
  if isNil(t): return
  result = hash(t.name) !& hash(t.useKind) !& hash(t.kind)
  case t.kind:
    of dtkIdent, dtkGenericSpec, dtkAnonTuple, dtkVarargs:
      result = result !& hash(t.head) !&
        hash(t.identKind) !& hash(t.genParams)

    of dtkGenericParam:
      result = result !& hash(t.paramName)

    of dtkProc, dtkNamedTuple:
      result = result !&
        hash(t.returnType) !&
        hash(t.arguments) !&
        hash(t.pragmas) !&
        hash(t.effects) !&
        hash(t.raises)

    of dtkRange:
      result = result !& hash(t.rngStart) !& hash(t.rngEnd)

    of dtkValue, dtkTypeofExpr:
      result = result !& hash(t.value)

    of dtkNone:
      discard

    of dtkFile, dtkDir, dtkString:
      result = result !& hash(t.strVal)

  return !$result

func contains*(table: DocIdTableN, id: DocId): bool {.inline.} =
  contains(table.table, id)

func `[]`*(table: DocIdTableN, id: DocId): DocIdSet {.inline.} =
  if id in table:
    return table.table[id]

func `[]=`*(table: var DocIdTableN, id: DocId, idset: DocIdSet) =
  table.table[id] = idset

proc hash*(part: DocLinkPart): Hash =
  result = hash(part.kind) !& hash(part.name)
  if part.kind in dekProcKinds:
    result = result !& hash($part.procType)

  return !$result

func mutHash*(full: var DocLink) =
  # Full identifier hash should be very stable (only changed if the name of
  # the entry is changed)
  var h: Hash
  {.cast(noSideEffect).}:
    for part in full.parts:
      h = h !& hash(part)

  full.docId.id = !$h
  full.parts[^1].id = full.docId

func hash*(full: DocLink): Hash = full.docId.id
func `==`*(a, b: DocLinkPart): bool = a.kind == b.kind
func `==`*(a, b: DocLink): bool = a.parts == b.parts

func `==`*(t1, t2: DocType): bool =
  t1.name == t2.name and
  t1.useKind == t2.useKind and
  t1.kind == t2.kind and (
    case t1.kind:
      of dtkIdent, dtkGenericSpec, dtkAnonTuple, dtkVarargs:
        # head* {.Attr.}: DocId ## Documentation entry
        t1.identKind == t2.identKind and
        t1.genParams == t2.genParams

      of dtkGenericParam:
        t1.paramName == t2.paramName

      of dtkProc, dtkNamedTuple:
        var res = true
        if (t1.returnType.isSome() and t2.returnType.isNone()) or
           (t1.returnType.isNone() and t2.returnType.isSome()):
          res = false

        if res:
          if t1.returnType.isSome():
            res = t1.returnType.get() == t2.returnType.get()

        if res:
          res = t1.arguments.len == t2.arguments.len

        if res:
          for idx in 0 ..< t1.arguments.len:
            res = t1.arguments[idx].identType ==
                  t2.arguments[idx].identType

            if not res:
              break

        # if res:
        # pragmas*: seq[DocPragma]
        # effects*: seq[DocId]
        # raises*: seq[DocId]



        res



      of dtkRange:
        t1.rngStart == t2.rngStart and
        t1.rngEnd == t2.rngEnd

      of dtkValue, dtkTypeofExpr:
        t1.value == t2.value

      of dtkNone:
        true

      of dtkFile, dtkDir, dtkString:
        t1.strVal == t2.strVal
  )


proc `$`*(ident: DocLinkPart): string =
 result = "[" & $ident.kind & " " & ident.name
 if ident.kind in dekProcKinds:
   result &= " "
   if ident.procType.isNil():
     result &= "<nil-proc-type>"

   else:
     result &= $ident.procType

 result &= "]"

proc `$`*(ident: DocLink): string =
  for idx, part in ident.parts:
    if idx > 0:
      result.add "/"

    result.add $part

func `$`*(e: DocEntry): string = $e.fullIdent

func len*(s: DocIdSet): int = s.ids.len
func incl*(s: var DocIdSet, id: DocId) =
  if id.id.int != 0:
    s.ids.incl id.id.int

func `*`*(s1, s2: DocIdSet): DocIdSet = DocIdSet(ids: s1.ids * s2.ids)
func `-`*(s1, s2: DocIdSet): DocIdSet = DocIdSet(ids: s1.ids - s2.ids)

func excl*(s: var DocIdSet, id: DocId) = s.ids.excl id.id.int
func contains*(s: DocIdSet, id: DocId): bool = id.id.int in s.ids
iterator items*(s: DocIdSet): DocId =
  for i in s.ids:
    yield DocId(id: i)

func pop*(s: var DocIdSet): DocId =
  for it in s:
    result = it
    s.excl result



func incl*(table: var DocIdTableN, idKey, idVal: DocId) =
  table.table.mgetOrPut(idKey, DocIdSet()).incl idVal

func id*(full: var DocLink): DocId {.inline.} = DocId(id: hash(full))
func id*(de: DocEntry): DocId {.inline.} = de.fullident.id
func incl*(s: var DocIdSet, entry: DocEntry) =
  s.incl entry.id()

func isExported*(e: DocEntry): bool = e.visibility in {dvkPublic}
func id*(docType: DocType): DocId =
  case docType.kind:
    of dtkIdent:
      result = docType.head

    of dtkAnonTuple, dtkGenericSpec:
      result = docType.genParams[0].id()

    of dtkVarargs:
      result = docType.vaType().head

    else:
      discard

func allId*(docType: DocType): DocIdSet =
  func aux(t: DocType, s: var DocIdSet) =
    case t.kind:
      of dtkIdent:
        s.incl t.head
        for param in t.genParams:
          aux(param, s)

      of dtkVarargs:
        aux(t.vaType(), s)

      of dtkAnonTuple, dtkGenericSpec:
        for param in t.genParams:
          aux(param, s)

      of dtkProc:
        for arg in t.arguments:
          aux(arg.identType, s)

      else:
        discard

  aux(docType, result)


func isValid*(id: DocId): bool = (id.id != 0)

func add*(db: var DocDb, entry: DocEntry) =
  entry.db = db
  db.fullIdents[entry.fullIdent] = entry.id
  db.entries[entry.id()] = entry

proc addTop*(db: var DocDb, entry: DocEntry) =
  db.add entry
  let part = entry.fullIdent.parts[0]
  db.top[part] = entry

proc add*(de: DocEntry, other: DocEntry) = de.nested.add other.id
proc add*(de: DocEntry, id: DocID) = de.nested.add id

proc `[]`*(db: DocDb, entry: DocEntry): DocEntry = db.entries[entry.id()]

proc contains*(db: DocDb, id: DocId): bool = id in db.entries
proc `[]`*(db: DocDb, id: DocId): DocEntry = db.entries[id]

proc `[]`*(de: DocEntry, idx: int): DocEntry =
  de.db.entries[de.nested[idx]]

func formatCodePart*(db: DocDb, part: DocCodePart): string =
  result &= $part
  if part.occur.isSome() and
     part.occur.get().kind notin dokLocalKinds:
    result &= " "
    result &= $db[part.occur.get().refid]

iterator allItems*(
    db: DocDb, accepted: set[DocEntryKind] = dekAllKinds): DocEntry =
  for _, entry in db.entries:
    if entry.kind in accepted:
      yield entry

iterator topItems*(
    db: DocDb, accepted: set[DocEntryKind] = dekAllKinds): DocEntry =

  for _, entry in db.top:
    if entry.kind in accepted:
      yield entry

iterator items*(
    de: DocEntry, accepted: set[DocEntryKind] = dekAllKinds): DocEntry =
  for id in items(de.nested):
    if de.db[id].kind in accepted:
      yield de.db[id]

iterator items*(
    dg: DocEntryGroup, accepted: set[DocEntryKind] = dekAllKinds): DocEntry =
  for e in items(dg.entries):
    if e.kind in accepted:
      yield e

iterator items*(ident: DocLink): DocLinkPart =
  for part in items(ident.parts):
    yield part

iterator pairs*(
    de: DocEntry, accepted: set[DocEntryKind] = dekAllKinds): (int, DocEntry) =
  for idx, id in pairs(de.nested):
    if de.db[id].kind in accepted:
      yield (idx, de.db[id])

func lastName*(link: DocLink): string = link.parts[^1].name

func newEntryGroup*(e: DocEntry): DocEntryGroup =
  DocEntryGroup(entries: @[e])

func newEntryGroup*(): DocEntryGroup =
  DocEntryGroup()

func newEntryGroup*(nested: seq[DocEntryGroup]): DocEntryGroup =
  DocEntryGroup(nested: nested)


func add*(group: var DocEntryGroup, e: DocEntry) =
  if isNil(group): group = newEntryGroup(e)
  group.entries.add e

func procType*(de: DocEntry): DocType =
  assertKind(de, dekProcKinds)
  for part in de.fullIdent:
    if part.kind == de.kind:
      return part.procType


func add*(t: var DocType, ident: DocIdent) =
  case t.kind:
    of dtkProc, dtkNamedTuple:
      t.arguments.add ident

    else:
      raise newUnexpectedKindError(t.kind)

proc initIdentPart*(
    kind: DocEntryKind, name: string,
    procType: DocType = nil): DocLinkPart =
  result = DocLinkPart(kind: kind, name: name)
  if kind in dekProcKinds:
    result.procType = procType

proc initFullIdent*(parts: sink seq[DocLinkPart]): DocLink =
  result = DocLink(parts: parts)
  mutHash(result)

proc add*(ident: var DocLink, part: DocLinkPart) =
  ident.parts.add part

func len*(ident: DocLink): int = ident.parts.len
func hasParent*(ident: DocLink): bool = ident.parts.len > 1
func hasParent*(entry: DocEntry): bool = entry.fullIdent.parts.len > 1


proc lastIdentPart*(entry: var DocEntry): var DocLinkPart =
  if entry.fullIdent.parts.len == 0:
    raiseArgumentError("Cannot return last ident part")

  return entry.fullIdent.parts[^1]

proc parentIdentPart*(entry: DocEntry): DocLinkPart =
  let l = entry.fullIdent.parts.len
  if l < 2:
    raise newArgumentError(
      "Cannot return parent ident part for entry with", l, "elements")

  return entry.fullident.parts[^2]



proc newDocEntry*(
      db: var DocDb, kind: DocEntryKind, name: string,
      procType: DocType = nil
  ): DocEntry =
  ## Create new toplevel entry (package, file, module) directly using DB.
  let part = initIdentPart(kind, name, procType)
  result = DocEntry(
    fullIdent: initFullIdent(@[part]),
    db: db,
    name: name,
    kind: kind
  )

  result.fullIdent.parts[^1].id = result.id()

  db.entries[result.id()] = result
  db.fullIdents[result.fullIdent] = result.id()
  db.top[part] = result

proc newDocEntry*(
    parent: var DocEntry, kind: DocEntryKind, name: string,
    procType: DocType = nil
  ): DocEntry =
  ## Create new nested document entry. Add it to subnode of `parent` node.


  result = DocEntry(
    fullIdent: initFullIdent(
      parent.fullIdent.parts & initIdentPart(kind, name, procType)),
    db: parent.db,
    name: name,
    kind: kind
  )

  result.fullIdent.parts[^1].id = result.id()

  parent.db.entries[result.id()] = result
  parent.db.fullIdents[result.fullIdent] = result.id()
  parent.nested.add result.id()

proc newDocEntry*(db: var DocDb, ident: DocLink): DocEntry =
  for part in ident.parts:
    if part.id notin db:
      if isNil(result):
        if part.kind in dekProcKinds:
          result = db.newDocEntry(part.kind, part.name, part.procType)

        else:
          result = db.newDocEntry(part.kind, part.name)

      else:
        if part.kind in dekProcKinds:
          result = result.newDocEntry(part.kind, part.name, part.procType)

        else:
          result = result.newDocEntry(part.kind, part.name)

    else:
      result = db[part.id]


proc registerNested*(db: var DocDb, parent, nested: DocEntry) =
  nested.db = db
  db.entries[nested.id()] = nested
  db.fullIdents[nested.fullIdent] = nested.id()
  if isNil(parent):
    db.top[nested.fullIdent.parts[0]] = nested

  else:
    parent.nested.add nested.id()

proc getOrNew*(db: var DocDb, kind: DocEntryKind, name: string): DocEntry =
  let key = initIdentPart(kind, name)
  if key in db.top:
    result = db.top[key]

  else:
    result = db.newDocEntry(kind, name)

proc getSub*(parent: DocEntry, subName: string): DocId =
  for sub in parent.nested:
    if parent.db[sub].name == subName:
      return sub

proc getOptTop*(db: DocDb, kind: DocEntryKind, name: string): Option[DocId] =
  let part = initIdentPart(kind, name)

  if part in db.top:
    return some db.top[part].id()

const ignoredAbsFile* = AbsFile("ignoredFakeAbsFile")

proc getLibForPath*(db: DocDb, path: AbsFile): DocLib =
  if path == ignoredAbsFile: return

  for lib in db.knownLibs:
    if path.startsWith($lib.dir):
      return lib

  raiseArgumentError(
    "No known library for path " & $path)

proc getOrNewPackage*(db: var DocDb, path: AbsPath): DocEntry =
  let lib = db.getLibForPath(path)
  let path = initIdentPart(dekPackage, lib.name)
  if path notin db.top:
    result = db.newDocEntry(dekPackage, lib.name)
    result.visibility = dvkPublic

  else:
    return db.top[path]

proc getLibForName*(db: DocDb, name: string): DocLib =
  for lib in db.knownLibs:
    if lib.name == name:
      return lib

  raiseArgumentError(
    "No known library for name " & $name)

func package*(ident: DocLink): string =
  if ident.parts.len == 0 or
     ident.parts[0].kind != dekPackage:
    raiseArgumentError(
      "No package name in full identifier " & $ident)

  else:
    return ident.parts[0].name

func getPackage*(entry: DocEntry): DocId =
  if entry.fullIdent.parts.len == 0 or
     entry.fullIdent.parts[0].kind != dekPackage:
    raiseArgumentError(
      "No package name in full identifier " & $entry.fullIdent)

  else:
    return entry.fullIdent.parts[0].id

func getFile*(db: DocDb, path: AbsFile): DocFile =
  for file in db.files:
    if file.path == path:
      return file

  raise newArgumentError(
    "Cannot find file", path, "in the database")

proc getPathForPackage*(db: DocDb, ident: DocLink): AbsDir =
  let package = ident.package()
  for lib in db.knownLibs:
    if lib.name == package:
      return lib.dir

  raiseArgumentError(
    "Cannot find path for ident package " & $ident)

proc getPathInPackage*(entry: DocEntry): AbsFile =
  if entry.location.getSome(loc):
    if isAbsolute(AbsFile loc.file):
      return AbsFile(loc.file)

    else:
      return entry.db.getPathForPackage(entry.fullIdent) /. loc.file

  else:
    raiseArgumentError(
      "No location for entry " & $entry.fullIdent)


proc addKnownLib*(db: var DocDb, dir: AbsDir, name: string) =
  db.knownLibs.add DocLib(dir: dir, name: name)
  # NOTE I know it is not particularly efficient, but if I get to the point
  # where it becomes a bottleneck I simply replace it with `Map`
  sortIt(db.knownLibs, it.dir.len)

proc newDocDb*(extraLibs: openarray[(AbsDir, string)] = @[]): DocDb =
  result = DocDb()
  for (dir, name) in extraLibs:
    result.addKnownLib(dir, name)

proc setLocation*(de: DocEntry, location: DocLocation) =
  de.location = some location
  let lib = de.db.getLibForPath(location.absFile)

  let withLib = location.absFile.getStr()
  var nolib = withLib.dropPrefix($lib.dir)
  if nolib != withLib:
    noLib = nolib.dropPrefix("/")

  de.location.get().file = nolib
  # de.location.get().lib = some lib.name


proc contains(s1, s2: DocCodeSlice): bool =
  s1.line == s2.line and
  s1.column.a <= s2.column.a and s2.column.b <= s1.column.b

func `[]`*[R1, R2](slice: DocCodeSlice, split: HSlice[R1, R2]): DocCodeSlice =
  result = slice
  when R1 is BackwardsIndex:
    result.column.a = result.column.b - split.a.int

  else:
    result.column.a = result.column.a + split.a

  when R2 is BackwardsIndex:
    result.column.b = result.column.b - split.b.int

  else:
    result.column.a = result.column.a + split.b

func `-=`*(slice: var DocCodeSlice, shift: int) =
  slice.column.a -= shift
  slice.column.b -= shift

proc initDocSlice*(line, startCol, endCol: int): DocCodeSlice =
  if endCol == -1:
    DocCodeSlice(line: line, column: Slice[int](a: -1, b: -1))

  else:
    assert startCol <= endCol, &"{startCol} <= {endCol}"
    DocCodeSlice(line: line, column: Slice[int](a: startCol, b: endCol))

proc splitOn*(base, sep: DocCodeSlice):
  tuple[before, after: Option[DocCodeSlice]] =

  if base.column.a == sep.column.a and
     base.column.b == sep.column.b:
    discard

  else:
    if base.column.a < sep.column.a:
      # [base text  ... (anything)]
      #          < [separator text]
      result.before = some initDocSlice(
        base.line, base.column.a, sep.column.a - 1)

    elif base.column.a == sep.column.a:
      discard

    else:
      raiseImplementError("")

    if sep.column.b < base.column.b:
      # [... (anything)  base text]
      # [separator text] <
      result.after = some initDocSlice(
        base.line, sep.column.b + 1, base.column.b)

    elif sep.column.b == base.column.b:
      discard

    else:
      raiseImplementError("")



proc newCodePart*(slice: DocCodeSlice): DocCodePart =
  DocCodePart(slice: slice)

proc newCodePart*(slice: DocCodeSlice, occur: DocOccur): DocCodePart =
  DocCodePart(slice: slice, occur: some occur)

proc newCodeLine*(idx: int, line: string): DocCodeLine =
  DocCodeLine(
    lineHigh: line.high,
    text: line,
    parts: @[newCodePart(initDocSlice(idx, 0, line.high))])



proc add*(line: var DocCodeLine, other: DocCodePart) =
  var idx = 0
  while idx < line.parts.len:
    if other.slice in line.parts[idx].slice:
      let split =
        try:
          line.parts[idx].slice.splitOn(other.slice)

        except ImplementError:
          raise

      var offset = 0
      if split.before.isSome():
        line.parts.insert(newCodePart(split.before.get()), idx)
        inc offset

      line.parts[idx + offset] = other

      if split.after.isSome():
        line.parts.insert(newCodePart(split.after.get()), idx + 1 + offset)

      return

    inc idx


  line.overlaps.add other

proc add*(code: var DocCode, other: DocCodePart) =
  code.codeLines[other.slice.line - 1].add other

proc add*(code: var DocCode, line: DocCodeLine) =
  code.codeLines.add line

proc newCodeBlock*(text: seq[string]): DocCode =
  for idx, line in text:
    result.codeLines.add newCodeLine(idx + 1, line)

iterator lines*(path: AbsFile): string =
  assertExists(path)
  for line in lines(path.string):
    yield line

proc newDocFile*(path: AbsFile): DocFile =
  result.path = path
  for idx, line in enumerate(lines(path)):
    result.body.add newCodeLine(idx + 1, line)

proc setIdForFile*(db: var DocDb, path: AbsFile, id: DocId) =
  if path == ignoredAbsFile: return

  var found = false
  for file in mitems(db.files):
    if file.path == path:
      file.moduleId = some id
      found = true

  if not found:
    var file = newDocFile(path)
    file.moduleId = some id
    db.files.add file

proc newOccur*(
  db: var DocDb, position: DocCodeSlice, inFile: AbsFile, occur: DocOccur) =
  if inFile == ignoredAbsFile: return

  assertExists(inFile)
  var fileIdx = -1
  for idx, file in pairs(db.files):
    if file.path == inFile:
      fileIdx = idx
      break

  if fileIdx == -1:
    db.files.add newDocFile(inFile)
    fileIdx = db.files.high

  db.files[fileIdx].body.add newCodePart(position, occur)



proc toDocType*(j: JsonNode): DocType =
  case j["kind"].asStr():
    of "Ident":
      result = newDocType(dtkIdent, j["name"].asStr())

    of "Proc":
      result = newDocType(dtkProc)
      result.returnType = some toDocType(j["returnType"])
      for arg in j["arguments"]:
        result.add newDocIdent(
          arg["ident"].asStr(),
          arg["identType"].toDocType())


    else:
      raise newImplementError(j["kind"].asStr())



proc loadLocationMap*(file: AbsFile): DocLocationMap =
  let json = parseJson(file)

  for entry in json:
    var link: DocLink
    for part in entry[0]:
      let name = part["name"].asStr()
      case part["kind"].asStr():
        of "Class":     link.add initIdentPart(dekClass, name)
        of "Struct":    link.add initIdentPart(dekStruct, name)
        of "Field":     link.add initIdentPart(dekField, name)
        of "Enum":      link.add initIdentPart(dekEnum, name)
        of "EnumField": link.add initIdentPart(dekEnumField, name)

        of "Proc":
          link.add initIdentPart(
            dekProc, part["name"].asStr(), part["procType"].toDocType())

        else:
          raise newUnexpectedKindError(part["kind"].asStr())


    mutHash(link)

    let line = entry[1]["line"].asInt()
    result.files.mgetOrPut(
      AbsFile(entry[1]["file"].asStr()),
      initMap[int, seq[tuple[location: DocPos, link: DocLink]]]()
    ).mgetOrPut(line, @[]).add((
      location: DocPos(
        line: line,
        column: entry[1]["column"].asInt()),
      link: link
    ))


proc initDocLocation*(file: AbsFile, line, column: int): DocLocation =
  DocLocation(absFile: file, pos: DocPos(line: line, column: column))

proc findLinkForLocation*(
    map: DocLocationMap, loc: DocLocation, name: string): Option[DocLink] =
  if loc.absFile in map.files:
    for it in map.files[loc.absFile].valuesFrom(loc.pos.line - 2):
      for (location, link) in it:
        if link.lastName() == name:
          return some link
