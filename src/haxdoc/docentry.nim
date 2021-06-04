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
    dekObject
    dekClass
    dekStruct
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

    dekKeyword ## Language or macro DSL keyword

    # REVIEW
    dekErrorMsg
    dekWarningMsg
    dekHintMsg

    dekLibSym

  DocProcKind* = enum
    dpkRegular
    dpkOperator
    dpkConstructor
    dpkDestructor
    dpkMoveOverride
    dpkCopyOverride
    dpkAsgnOverride
    dpkPropertyGet
    dpkPropertySet
    dpkPredicate

const
  dekProcKinds* = { dekProc .. dekSlot }
  dekNewtypeKinds* = { dekObject .. dekDistinctAlias }
  dekAliasKinds* = { dekTypeclass, dekAlias, dekDistinctAlias,
                     dekRefAlias }
  dekStructKinds* = {
    dekObject, dekDefect, dekException, dekEffect, dekClass, dekStruct
  }
  dekAllKinds* = { low(DocEntryKind) .. high(DocEntryKind) }


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
    dokTypeConversionUse

    dokUsage
    dokCall

    dokInheritFrom
    dokOverride
    dokInclude
    dokImport
    dokMacroUsage
    dokAnnotationUsage

    # local section start
    dokLocalUse ## Generic 'use' of local entry
    dokLocalWrite
    dokLocalRead


    # local declaration section start
    dokLocalArgDecl
    dokLocalVarDecl
    # local declarations section end
    # local section end

    dokGlobalWrite ## Asign value to global variable
    dokGlobalRead ## Non-asign form of global variable usage. Taking
    ## address and mutating, passing to function that accepts `var`
    ## parameter etc. would count as 'read' action.
    dokGlobalDeclare

    dokFieldUse
    dokFieldSet
    dokEnumFieldUse

    dokFieldDeclare
    dokCallDeclare
    dokAliasDeclare
    dokObjectDeclare
    dokEnumDeclare
    dokEnumFieldDeclare

    dokDefineCheck

const
  dokLocalKinds* = {dokLocalUse .. dokLocalArgDecl }
  dokLocalDeclKinds* = { dokLocalArgDecl .. dokLocalVarDecl }

type
  DocOccur* = object
    ## Single occurence of documentable entry
    user* {.Attr.}: Option[DocId] ## For occurence of global documentable
    ## entry - lexically scoped parent (for function call - callee, for
    ## type - parent composition). For local occurence - type of the
    ## identifier (for local variables, arguments etc).
    case kind*: DocOccurKind ## Type of entry occurence
      of dokLocalKinds:
        localId* {.Attr.}: string
        withInit* {.Attr.}: bool ## For 'local decl' - whether identifier
        ## was default-constructed or explicitly initialized.

      else:
        refid* {.Attr.}: DocId ## Documentable entry id

  DocCodeSlice* = object
    line* {.Attr.}: int ## Code slice line /index/
    endLine* {.Attr.}: Option[int]
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

  DocIdTableN* = object
    table: Table[DocId, DocIdSet]

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
    id* {.Attr.}: DocId
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

  DocTypeUseKind* = enum
    ## Different kinds of type usage.
    dtukDefault ## Direct type use
    dtukPointerTo ## Untraced pointer to type
    dtukGcRefTo ## Traced pointer to type
    dtukByrefTo ## Reference to lvalue
    dtukRvalueTo ## Temporary (rvalue/sink) reference

  DocType* = ref object
    ## Single **use** of a type in any documentable context (procedure
    ## arguments, return types etc.). Plays structural role in
    ## documentation context - does not contain any additional information
    ## itself.
    name* {.Attr.}: string
    useKind* {.Attr.}: seq[DocTypeUseKind] ## Unwrap one or more layers of
    ## indirection in type usage, blurring distinction between `ptr ptr
    ## char` and `char` if needed.
    # REVIEW this makes queries like 'all procedures that accept
    # pointer-to-pointer-to-char' harder, but at the same time eliminate
    # the need to manually unwrap and process functions that work
    # with`*MyStruct` and `MyStruct`. Extra flexibility at the cost of
    # extra complexity.
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
    # FIXME extermely expensive structure to work with - each documentable
    # entry has at least *two* copies of almost the same string, and it is
    # also duplicated thousands of times for each file (due to number of
    # documentable entries). Must be replaced with FileId abd AbsFileId
    file* {.Attr.}: string
    absFile* {.Skip(IO).}: AbsFile
    pos* {.Attr.}: DocPos

  DocExtent* = object
    start* {.Attr.}: DocPos
    finish* {.Attr.}: DocPos

  DocText* = object
    category* {.Attr.}: Option[string]
    docTags*: seq[string]
    docBrief*: SemOrg
    docBody*: SemOrg
    admonitions*: seq[DocAdmonition]
    metatags*: seq[DocMetatag]
    rawDoc*: seq[string]

  DocVisibilityKind* = enum
    dvkPrivate ## Not exported
    dvkInternal ## Exported, but only for internal use
    dvkPublic ## Exported, available for public use

  DocRequires* = object
    name* {.Attr.}: string
    version* {.Attr.}: string # TODO expand
    resolved* {.Attr.}: Option[DocID]

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
    visibility* {.Attr.}: DocVisibilityKind
    deprecatedMsg* {.Attr.}: Option[string]
    fullIdent*: DocFullIdent ## Fully scoped identifier for a name

    docText*: DocText

    case kind*: DocEntryKind
      of dekPackage:
        version* {.Attr.}: string
        author* {.Attr.}: string
        license* {.Attr.}: string
        requires*: seq[DocRequires]

      of dekModule:
        imports*: DocIdSet
        exports*: DocIdSet

      of dekStructKinds:
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

      of dekProcKinds:
        procKind* {.Attr.}: DocProcKind
        wrapOf*: Option[string]
        dynlibOf*: Option[string]
        calls*: DocIdSet ## Procedures called by entry
        raises*: DocIdSet ## Full list of potential raises of a procedure
        effects*: DocIdSet ## All effects for procedure body
        raisesVia*: Table[DocId, DocIdSet] ## Mapping between particular
        ## raise and called procedure. Direct raises via `raise` statement
        ## are not listed here.
        raisesDirect*: DocIdSet
        effectsVia*: Table[DocId, DocIdSet] ## Effect -> called procMapping
        globalIO*: DocIdSet ## Global variables that procedure reads from
                            ## or writes into.

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
    currentTop*: DocEntry

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
# storeTraits(DocRequires)

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

proc hash*(part: DocIdentPart): Hash =
  result = hash(part.kind) !& hash(part.name)
  if part.kind in dekProcKinds:
    result = result !& hash($part.procType)

  return !$result

func mutHash*(full: var DocFullIdent) =
  # Full identifier hash should be very stable (only changed if the name of
  # the entry is changed)
  var h: Hash
  {.cast(noSideEffect).}:
    for part in full.parts:
      h = h !& hash(part)

  full.docId.id = !$h
  full.parts[0].id = full.docId

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

func `$`*(e: DocEntry): string = $e.fullIdent

func len*(s: DocIdSet): int = s.ids.len
func incl*(s: var DocIdSet, id: DocId) =
  if id.id.int != 0:
    s.ids.incl id.id.int

func excl*(s: var DocIdSet, id: DocId) = s.ids.excl id.id.int
func contains*(s: DocIdSet, id: DocId): bool = id.id.int in s.ids
iterator items*(s: DocIdSet): DocId =
  for i in s.ids:
    yield DocId(id: i)


func incl*(table: var DocIdTableN, idKey, idVal: DocId) =
  table.table.mgetOrPut(idKey, DocIdSet()).incl idVal


func isExported*(e: DocEntry): bool = e.visibility in {dvkPublic}
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

iterator items*(ident: DocFullIdent): DocIdentPart =
  for part in items(ident.parts):
    yield part

iterator pairs*(
    de: DocEntry, accepted: set[DocEntryKind] = dekAllKinds): (int, DocEntry) =
  for idx, id in pairs(de.nested):
    if de.db[id].kind in accepted:
      yield (idx, de.db[id])


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

proc newDocType*(kind: DocTypeKind, head: DocEntry): DocType =
  result = DocType(kind: kind)
  result.head = head.id()

proc newDocType*(kind: DocTypeKind, name: string, id: DocId): DocType =
  result = DocType(kind: kind, name: name)
  result.head = id

proc newDocType*(kind: DocTypeKind, name: string = ""): DocType =
  result = DocType(kind: kind, name: name)

proc newDocIdent*(name: string, idType: DocType): DocIdent =
  DocIdent(ident: name, identType: idType)

func add*(t: var DocType, ident: DocIdent) =
  case t.kind:
    of dtkProc, dtkNamedTuple:
      t.arguments.add ident

    else:
      raise newUnexpectedKindError(t.kind)

proc initIdentPart*(
    kind: DocEntryKind, name: string,
    procType: DocType = nil): DocIdentPart =
  result = DocIdentPart(kind: kind, name: name)
  if kind in dekProcKinds:
    result.procType = procType

proc initFullIdent*(parts: sink seq[DocIdentPart]): DocFullIdent =
  result = DocFullIdent(parts: parts)
  mutHash(result)

proc add*(ident: var DocFullIdent, part: DocIdentPart) =
  ident.parts.add part

func len*(ident: DocFullIdent): int = ident.parts.len
func hasParent*(ident: DocFullIdent): bool = ident.parts.len > 1
func hasParent*(entry: DocEntry): bool = entry.fullIdent.parts.len > 1


proc lastIdentPart*(entry: var DocEntry): var DocIdentPart =
  if entry.fullIdent.parts.len == 0:
    raiseArgumentError("Cannot return last ident part")

  return entry.fullIdent.parts[^1]

proc parentIdentPart*(entry: DocEntry): DocIdentPart =
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

func package*(ident: DocFullIdent): string =
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

proc getPathForPackage*(db: DocDb, ident: DocFullIdent): AbsDir =
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
