## Definition of shared documentable entry

import haxorg/[ast, semorg]
import hmisc/other/[oswrap]
import hmisc/algo/[hseq_mapping, halgorithm]
import hmisc/[hdebug_misc, helpers]
import std/[options, tables, hashes, enumerate,
            strformat, sequtils, intsets]
import nimtraits

type
  DocNode* = ref object of OrgUserNode

  DocEntryKind* = enum
    ## - NOTE :: Different procedure kinds are also used to describe
    ##   operator implementations.
    # procedure kinds start
    dekProc ## \
    ## Procedure definition

    dekFunc ## \
    ## Function definition

    dekMacro ## Macro
    dekMethod ## Method
    dekTemplate ## \
    ## Template - simple code substitution.
    ##
    ## - NOTE :: C++ templates are mapped to `dekProc`, and macros are mapped
    ##   to `dekMacros`

    dekIterator ## \
    ## Iterator
    ##
    ## - NOTE :: C++ iterator classes are mapped to objects

    dekConverter ## User-defined implicit conversion
    dekSignal
    dekSlot
    # procedure kinds end

    dekParam ## Generic parameters
    dekArg ## Entry (function, procedure, macro, template) arguments

    dekInject ## Variable injected into the scope by template/macro
              ## instantiation.

    dekPragma ## Compiler-specific directives `{.pragma.}` in nim,
              ## `#pragma` in C++ and `#[(things)]` from rust.

    dekTrait # Added both traits and concepts because in nim you can have
             # `concept` and automatic trait-based.

    # new type kinds start
    dekBuiltin ## Builtin type, not defined using any other types
    dekObject ## class/structure/object definition
    dekException ## Exception object
    dekDefect ## Nim defect object
    dekConcept ## General concept
    dekInterface
    dekTypeclass
    dekUnion
    dekEnum ## Enumeration
    dekEffect ## Side effect tag
    dekAlias ## Typedef
    dekRefAlias
    dekDistinctAlias ## strong typedef
    # new type kinds end


    # variable-like entries
    dekCompileDefine ## Compile-time `define` that might affect compilation
                     ## of the program.

    dekGlobalConst ## Global immutable compile-time constant
    dekGlobalVar ## Global mutable variable
    dekGlobalLet ## Global immutable variable
    dekField ## object/struct field
    dekEnumField ## Enum field/constant
    # end

    dekNamespace ## Namespace
    dekGroup ## Documentable group of entries that is not otherwise grouped
             ## together by language constructs.

    dekTag ## Documentation tag


    dekModule ## Module (C header file, nim/python/etc. module)
    dekFile ## Global or local file
    dekDir ## System directory
    dekPackage ## System or programming language package (library). If
               ## present used as toplevel grouping element.

    dekImport ## 'modern' import semantics
    dekInclude ## C-style text-based include
    dekDepend ## Interpackage dependency relations


    dekEnv ## Environment variable
    dekShellCmd ## Shell command
    dekShellOption ## Shell command option (has value) or flag (no value)
    dekShellArg ## Positional shell argument
    dekShellSubCmd ## Shell subcommand


    dekSchema ## Serialization schema

const
  dekProcKinds* = { dekProc .. dekSlot }
  dekNewtypeKinds* = { dekObject .. dekDistinctAlias }
  dekAliasKinds* = { dekTypeclass, dekAlias, dekDistinctAlias,
                     dekRefAlias }
  dekStructTypes* = { dekObject, dekDefect, dekException, dekEffect }


type
  DocTypeKind* = enum
    dtkNone ## Default type kind

    dtkIdent ## Single, non-generic (or non-specialized generic) identifier
    dtkGenericParam ## Generic parameter used in type, not resolved to any
                    ## particular type
    dtkGenericSpec ## Generic object with one or more generic parameters
    dtkAnonTuple ## Anonymous (no named fields) tuple
    dtkProc ## Procedure
    dtkNamedTuple ## Tuple with named fields
    dtkRange ## Value range
    dtkVarargs ## Variadic arguments
    dtkValue ## Value (for generic parameters and typeof exressions)
    dtkTypeofExpr ## `typeof` for some value

    dtkString ## String input parameter (for CLI applications)

    dtkFile
    dtkDir

  DocOccurKind* = enum
    dokTypeDirectUse ## Direct use of non-generic type
    dokTypeAsParameterUse ## Use as a parameter in generic specialization
    dokTypeSpecializationUse ## Specialization of generic type using other
                             ## types

    dokTypeAsArgUse
    dokTypeAsReturnUse
    dokTypeAsFieldUse

    dokUsage
    dokCall

    dokInheritFrom
    dokOverride
    dokInclude
    dokImport
    dokMacroUsage
    dokAnnotationUsage

    dokLocalUse

    dokGlobalWrite ## Asign value to global variable
    dokGlobalRead ## Non-asign form of global variable usage. Taking
    ## address and mutating, passing to function that accepts `var`
    ## parameter etc. would count as 'read' action.
    dokGlobalDeclare

    dokFieldUse
    dokEnumFieldUse

    dokFieldDeclare
    dokCallDeclare
    dokAliasDeclare
    dokObjectDeclare
    dokEnumDeclare
    dokEnumFieldDeclare

    dokDefineCheck

  DocOccur* = object
    ## Single occurence of documentable entry
    user* {.Attr.}: Option[DocId]
    case kind*: DocOccurKind ## Type of entry occurence
      of dokLocalUse:
        localId* {.Attr.}: string

      else:
        refid* {.Attr.}: DocId ## Documentable entry id

  DocCodeSlice* = object
    line* {.Attr.}: int ## Code slice line /index/
    column* {.Attr.}: Slice[int]

  DocCodePart* = object
    ## Single code part with optional occurence link.
    slice*: DocCodeSlice ## Single-line slice of the code
    occur*: Option[DocOccur] ## 'link' to documentable entry

  DocCodeLine* = object
    lineHigh* {.Attr.}: int ## /max index/ (not just length) for target
                            ## code line
    text*: string
    parts*: seq[DocCodePart]
    overlaps*: seq[DocCodePart] ## \
    ##
    ## - WHY :: sometimes it is not possible to reliably determine extent
    ##   of the identifier, which leads to potentially overlapping code
    ##   segments. Determining 'the correct' one is hardly possible, so
    ##   they are just dumped in the overlapping section.

  DocCode* = object
    ## Block of source code with embedded occurence links.
    codeLines*: seq[DocCodeLine]

  DocTypeHeadKind* = enum
    dthGenericParam ## Unresolved generic parameter
    dthTypeclass ## Typeclass
    dthConcreteType ## Concrete resolved class

  DocIdentKind* = enum
    diValue ## Pass-by value function argument or regular identifier
    diPointer ## Identifier passed by pointer
    diMutReference ## Mutable reference
    diConstReference ## Immutable reference
    diSink ## rvalue/sink parameters

  DocIdent* = object
    ## Identifier.
    ##
    ## - WHY :: Callback itself is represented as a type, but it is also
    ##   possible to have named arguments for callback arguments (though
    ##   this is not mandatory). @field{entry} should only point to
    ##   documentable entry of kind [[code:dekField]].

    ident*: string ## Identifier name
    kind*: DocIdentKind ##
    identType*: DocType ## Identifier type
    value*: Option[string] ## Optional expression for initialization value
    entry*: DocId

  DocIdSet* = object
    ids: IntSet

  DocId* = object
    id* {.Attr.}: Hash

  DocEntryGroup* = ref object
    entries*: seq[DocEntry]
    nested*: seq[DocEntryGroup]

  DocIdentPart* = object
    ## Part of fully scoped document identifier.
    ##
    ## - DESIGN :: Format closely maps to
    ##   [[code:haxorg//semorg.CodeLinkPart]] but represents *concrete
    ##   path* to a particular documentable entry. Code link is a pattern,
    ##   FullIdent is a path.
    name* {.Attr.}: string
    case kind*: DocEntryKind
      of dekProcKinds:
        procType*: DocType

      else:
        discard

  DocFullIdent* = object
    ## Full scoped identifier for an entry
    docId*: DocId ## Cached identifier value
    parts*: seq[DocIdentPart]

  DocPragma* = object
    name* {.Attr.}: string
    entry* {.Attr.}: DocId
    args*: seq[DocCode]

  DocType* = ref object
    ## Single **use** of a type in any documentable context (procedure
    ## arguments, return types etc.). Plays structural role in
    ## documentation context - does not contain any additional information
    ## itself.
    name* {.Attr.}: string
    case kind*: DocTypeKind
      of dtkIdent, dtkGenericSpec, dtkAnonTuple, dtkVarargs:
        head* {.Attr.}: DocId ## Documentation entry
        identKind* {.Attr.}: DocTypeHeadKind ## `head` ident kind
        genParams*: seq[DocType]

      of dtkGenericParam:
        paramName* {.Attr.}: string

      of dtkProc, dtkNamedTuple:
        returnType*: Option[DocType]
        arguments*: seq[DocIdent]
        pragmas*: seq[DocPragma]
        effects*: seq[DocId]
        raises*: seq[DocId]

      of dtkRange:
        rngStart*, rngEnd*: string

      # of dtkVarargs:
      #   vaType*: DocType
      #   vaConverter*: Option[string]

      of dtkValue, dtkTypeofExpr:
        value*: string

      of dtkNone:
        discard

      of dtkFile, dtkDir, dtkString:
        strVal*: string

  DocAdmonition* = ref object
    kind*: OrgBigIdentKind
    body*: SemOrg

  DocMetatag* = ref object
    kind*: SemMetaTag
    body*: SemOrg

  DocPos* = object
    line* {.Attr.}: int
    column* {.Attr.}: int


  DocLocation* = object
    lib* {.Attr.}: Option[string]
    file* {.Attr.}: string
    absFile* {.Skip(IO).}: AbsFile
    pos* {.Attr.}: DocPos

  DocExtent* = object
    start* {.Attr.}: DocPos
    finish* {.Attr.}: DocPos

  DocEntry* = ref object
    location*: Option[DocLocation]
    extent*: Option[DocExtent]
    declHeadExtent*: Option[DocExtent] ## Source code extent for
    ## documentable entry 'head'. Points to single identifier - entry name
    ## in declaration.
    ## - WHY :: Used in sourcetrail
    nested*: seq[DocId] ## Nested documentable entries. Not all
    ## `DocEntryKind` is guaranteed to have one.

    db* {.Skip(IO).}: DocDb ## Parent documentable entry database

    name* {.Attr.}: string
    fullIdent*: DocFullIdent ## Fully scoped identifier for a name

    docBrief*: SemOrg
    docBody*: SemOrg
    admonitions*: seq[DocAdmonition]
    metatags*: seq[DocMetatag]
    rawDoc*: seq[string]

    case kind*: DocEntryKind
      of dekStructTypes:
        superTypes*: seq[DocId]

      of dekShellOption:
        isRequired*: bool
        optType*: Option[DocType]
        optRepeatRange*: Slice[int]

      of dekArg, dekField:
        identTypeStr* {.Attr.}: Option[string]
        identType*: Option[DocType] ## Argument type description
        identDefault*: Option[DocCode] ## Expression for argument default
                                       ## value.

      of dekAliasKinds:
        baseType*: DocType

      # of dekField:
      #   fieldType*: DocType

      # of dekProcKinds:
      #   procType*: DocType

      else:
        discard

  DocFile* = object
    ## Processed code file
    path* {.Attr.}: AbsFile ## Absolute path to the original file
    body*: DocCode ## Full text with [[code:DocOccur][occurrence]]
                   ## annotations
    moduleId* {.Attr.}: Option[DocId]

  DocLib* = object
    name*: string
    dir*: AbsDir


  DocDb* = ref object
    ## - DESIGN :: Two-layer mapping between full entry identifiers, their
    ##   hashes and documentable entries. Hashes are also mapped to full
    ##   identifiers using [[code:DocEntry.fullIdent]] field.

    # In order to resolve code links I must store all 'full identifiers'
    # somewhere, and it makes it easier to serialize if all elements are
    # resolved through iteger identifiers. This is slower but does not
    # require expensive `ref` graph reconstruction during serialization.
    entries*: Table[DocId, DocEntry]
    fullIdents*: OrderedTable[DocFullIdent, DocId]
    top*: OrderedTable[DocIdentPart, DocEntry]
    files*: seq[DocFile]
    knownLibs: seq[DocLib]

storeTraits(DocEntry, dekAliasKinds, dekProcKinds, dekStructTypes)

storeTraits(DocExtent)
storeTraits(DocPos)
storeTraits(DocLocation)
storeTraits(DocAdmonition)
storeTraits(DocMetatag)
storeTraits(DocTypeKind)
storeTraits(DocOccurKind)
storeTraits(DocOccur)
storeTraits(DocTypeHeadKind)
storeTraits(DocIdentKind)
storeTraits(DocId)
storeTraits(DocIdentPart, dekProcKinds)
storeTraits(DocFullIdent)
storeTraits(DocType)
storeTraits(DocFile)
storeTraits(DocDb)
storeTraits(DocIdent)
storeTraits(DocPragma)
storeTraits(DocCode)
storeTraits(DocCodePart)
storeTraits(DocCodeSlice)
storeTraits(DocCodeLine)

proc vaType*(t: DocType): DocType =
  assertKind(t, {dtkVarargs})
  return t.genParams[0]

proc vaConverter*(t: DocType): Option[DocType] =
  assertKind(t, {dtkVarargs})
  if t.genParams.len > 1:
    return some t.genParams[1]

proc `$`*(dk: DocEntryKind): string = toString(dk)[3 ..^ 1]
proc `$`*(dk: DocOccurKind): string = toString(dk)[3 ..^ 1]
proc `$`*(t: DocType): string
proc `$`*(t: DocIdent): string =
  result = t.ident & ": " & $t.identType
  if t.value.isSome():
    result &= " = " & t.value.get()

proc `$`*(t: DocType): string =
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


proc hash*(id: DocId): Hash = hash(id.id)
proc hash*(part: DocIdentPart): Hash =
  result = hash(part.kind) !& hash(part.name)
  if part.kind in dekProcKinds:
    result = result !& hash($part.procType)

  return !$result

func hash*(full: var DocFullIdent): Hash =
  # Full identifier hash should be very stable (only changed if the name of
  # the entry is changed)
  if full.docId.id != 0:
    return full.docId.id

  else:
    {.cast(noSideEffect).}:
      for part in full.parts:
        result = result !& hash(part)

    result = !$result
    full.docId.id = result

func hash*(full: DocFullIdent): Hash = full.docId.id
func `==`*(a, b: DocIdentPart): bool = a.kind == b.kind
func `==`*(a, b: DocFullIdent): bool = a.parts == b.parts



proc `$`*(ident: DocIdentPart): string =
 result = "[" & ident.name & " "
 if ident.kind in dekProcKinds:
   if ident.procType.isNil():
     result &= "<nil-proc-type> "

   else:
     result &= $ident.procType & " "

 result &= $ident.kind & "]"

proc `$`*(ident: DocFullIdent): string =
  for idx, part in ident.parts:
    if idx > 0:
      result.add "/"

    result.add $part


func incl*(s: var DocIdSet, id: DocId) = s.ids.incl id.id.int
func excl*(s: var DocIdSet, id: DocId) = s.ids.excl id.id.int
func contains*(s: DocIdSet, id: DocId): bool = id.id.int in s.ids
iterator items*(s: DocIdSet): DocId =
  for i in s.ids:
    yield DocId(id: i)


func id*(full: var DocFullIdent): DocId {.inline.} = DocId(id: hash(full))
func id*(de: DocEntry): DocId {.inline.} = de.fullident.id
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

iterator items*(de: DocEntry): DocEntry =
  for id in items(de.nested):
    yield de.db[id]

iterator items*(dg: DocEntryGroup): DocEntry =
  for e in items(dg.entries):
    yield e

iterator items*(ident: DocFullIdent): DocIdentPart =
  for part in items(ident.parts):
    yield part

iterator pairs*(de: DocEntry): (int, DocEntry) =
  for idx, id in pairs(de.nested):
    yield (idx, de.db[id])


func newEntryGroup*(e: DocEntry): DocEntryGroup =
  DocEntryGroup(entries: @[e])

func add*(group: var DocEntryGroup, e: DocEntry) =
  if isNil(group): group = newEntryGroup(e)
  group.entries.add e

func procType*(de: DocEntry): DocType =
  assertKind(de, dekProcKinds)
  for part in de.fullIdent:
    if part.kind == de.kind:
      return part.procType

proc newDocType*(kind: DocTypeKind, head: DocEntry): DocType =
  result = DocType(kind: kind)
  result.head = head.id()

proc initIdentPart*(
    kind: DocEntryKind, name: string, procType: DocType = nil): DocIdentPart =
  result = DocIdentPart(kind: kind, name: name)
  if kind in dekProcKinds:
    result.procType = procType

proc initFullIdent*(parts: sink seq[DocIdentPart]): DocFullIdent =
  result = DocFullIdent(parts: parts)
  discard hash(result)

proc lastIdentPart*(entry: var DocEntry): var DocIdentPart =
  if entry.fullIdent.parts.len == 0:
    raiseArgumentError("Cannot return last ident part")

  return entry.fullIdent.parts[^1]

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

  parent.db.entries[result.id()] = result
  parent.db.fullIdents[result.fullIdent] = result.id()
  parent.nested.add result.id()

proc registerNested*(db: var DocDb, parent, nested: DocEntry) =
  nested.db = db
  db.entries[nested.id()] = nested
  db.fullIdents[nested.fullIdent] = nested.id()
  if isNil(parent):
    db.top[nested.fullIdent.parts[0]] = nested

  else:
    parent.nested.add nested.id()

proc newDocDb*(): DocDb =
  result = DocDb()

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

proc getLibForPath*(db: DocDb, path: AbsFile): DocLib =
  for lib in db.knownLibs:
    if path.startsWith($lib.dir):
      return lib

proc getLibForName*(db: DocDb, name: string): DocLib =
  for lib in db.knownLibs:
    if lib.name == name:
      return lib

proc getPathInLib*(db: DocDb, loc: DocLocation): AbsFile =
  for lib in db.knownLibs:
    if lib.name == loc.lib.get():
      return lib.dir /. loc.file

  if isAbsolute(loc.file):
    return AbsFile(loc.file)

  raiseArgumentError("Cannot find path for library name '" &
    $loc.lib.get() & "'")

proc addKnownLib*(db: var DocDb, dir: AbsDir, name: string) =
  db.knownLibs.add DocLib(dir: dir, name: name)
  # NOTE I know it is not particularly efficient, but if I get to the point
  # where it becomes a bottleneck I simply replace it with `Map`
  sortIt(db.knownLibs, it.dir.len)

proc setLocation*(de: DocEntry, location: DocLocation) =
  de.location = some location
  let lib = de.db.getLibForPath(location.absFile)

  let withLib = location.absFile.getStr()
  var nolib = withLib.dropPrefix($lib.dir)
  if nolib != withLib:
    noLib = nolib.dropPrefix("/")

  de.location.get().file = nolib
  de.location.get().lib = some lib.name


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
      echov base
      echov sep
      raiseImplementError("")

    if sep.column.b < base.column.b:
      # [... (anything)  base text]
      # [separator text] <
      result.after = some initDocSlice(
        base.line, sep.column.b + 1, base.column.b)

    elif sep.column.b == base.column.b:
      discard

    else:
      echov base
      echov sep
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
          echov other
          for part in line.parts:
            echov part
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
  # echov other
  # for part in line.parts:
  #   echov part
  # raiseImplementError("Addition failed")

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
