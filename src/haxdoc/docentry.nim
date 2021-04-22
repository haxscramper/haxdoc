## Definition of shared documentable entry

import haxorg/[ast, semorg]
import hmisc/other/[oswrap]
import std/[options, tables, hashes]

type
  DocOrg* = ref object of SemOrg
  DocNode* = ref object of OrgUserNode

  DocEntryKind* = enum
    # procedure kinds start
    dekProc ## Procedure definition
    dekFunc ## Function definition
    dekMacro ## Macro
    dekMethod ## Method
    dekTemplate ## Template. NOTE: C++ templates are mapped to `dekProc`
    dekIterator ## Iteartor. NOTE: C++ iterator classes are mapped to objects
    dekConverter
    dekSignal
    dekSlot
    # procedure kinds end

    dekParam ## Generic parameters
    dekArg ## Entry (function, procedure, macro, template) arguments

    dekInject ## Variable injected into the scope by template/macro
              ## instantiation.

    dekPragma ## Compiler-specific directives `{.pragma.}` in nim,
              ## `#pragma` in C++ and `#[(things)]` from rust.

    # new type kinds start
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
    dekDistinctAlias ## strong typedef
    # new type kinds end


    dekCompileDefine ## Compile-time `define` that might affect compilation
                     ## of the program.
    dekGlobalConst ## Global immutable compile-time constant
    dekGlobalVar ## Global mutable variable
    dekGlobalLet ## Global immutable variable

    dekField ## object/struct field

    dekNamespace ## Namespace
    dekModule ## Module (C header file, nim/python/etc. module)
    dekFile ## Global or local file
    dekDir ## System directory
    dekGroup ## Documentable group of entries that is not otherwise grouped
             ## together by language constructs.

    dekTag ## Documentation tag

    dekEnv ## Environment variable
    dekShellCmd ## Shell command
    dekShellOption ## Shell command option (has value) or flag (no value)
    dekShellArg ## Positional shell argument
    dekShellSubCmd ## Shell subcommand

    dekPackage ## System or programming language package (library). If
               ## present used as toplevel grouping element.

    dekSchema ## Serialization schema

const
  dekProcKinds* = { dekProc .. dekSlot }
  dekNewtypeKinds* = { dekObject .. dekDistinctAlias }

type
  DocTypeKind* = enum
    dtkNone ## Default type kind

    dtkIdent ## Single, non-generic (or non-specialized generic) identifier
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
    dokTypeUsage
    dokUsage
    dokCall
    dokInheritance
    dokOverride
    dokTypeArgument
    dokTemplateSpecialization
    dokInclude
    dokImport
    dokMacroUsage
    dokAnnotationUsage

    dokDefinition

  DocOccur = object
    ## Single occurence of documentable entry
    refid*: DocId ## Documentable entry id
    kind*: DocOccurKind ## Type of entry occurence

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

  DocId* = object
    id*: Hash

  DocIdentPart* = object
    ## Part of fully scoped document identifier.
    ##
    ## - DESIGN :: Format closely maps to
    ##   [[code:haxorg//semorg.CodeLinkPart]] but represents *concrete
    ##   path* to a particular documentable entry. Code link is a pattern,
    ##   FullIdent is a path.
    name*: string
    case kind*: DocEntryKind
      else:
        discard

  DocFullIdent* = object
    ## Full scoped identifier for an entry
    docId*: DocId ## Cached identifier value
    parts*: seq[DocIdentPart]

  DocType* = ref object
    ## Single **use** of a type in any documentable context (procedure
    ## arguments, return types etc.). Plays structural role in
    ## documentation context - does not contain any additional information
    ## itself.
    # doctextBody*: SemOrg ## Full documentation text, excluding 'brief'
    # doctextBrief*: SemOrg ## 'bfief' part
    refid*: DocOccur
    case kind*: DocTypeKind
      of dtkIdent, dtkGenericSpec, dtkAnonTuple:
        head*: DocEntry ## Documentation entry
        identKind*: DocTypeHeadKind ## `head` ident kind
        genParams*: seq[DocType]

      of dtkProc, dtkNamedTuple:
        returnType*: Option[DocType]
        arguments*: seq[DocIdent]
        pragmas*: seq[tuple[entry: DocId, arg: string]]
        effects*: seq[DocId]
        raises*: seq[DocId]

      of dtkRange:
        rngStart*, rngEnd*: string

      of dtkVarargs:
        vaType*: DocType
        vaConverter*: Option[string]

      of dtkValue:
        value*: string

      of dtkNone, dtkTypeofExpr:
        discard

      of dtkFile, dtkDir, dtkString:
        strVal*: string

  DocEntry* = ref object
    nested*: seq[DocId] ## Nested documentable entries. Not all
    ## `DocEntryKind` is guaranteed to have one.

    db: DocDb ## Parent documentable entry database

    name*: string
    fullIdent*: DocFullIdent ## Fully scoped identifier for a name

    docBrief*: DocOrg
    docBody*: DocOrg
    admonitions*: seq[tuple[kind: OrgBigIdentKind, body:SemOrg]]
    metatags*: seq[(SemMetaTag, SemOrg)]

    case kind*: DocEntryKind
      of dekShellOption:
        isRequired*: bool
        optType*: Option[DocType]
        optRepeatRange*: Slice[int]

      else:
        discard

  DocFile* = object
    absPath: AbsFile

  DocDb* = ref object
    ## - DESIGN ::Two-layer mapping between full entry identifiers, their
    ##   hashes and documentable entries. Hashes are also mapped to full
    ##   identifiers using [[code:DocEntry.fullIdent]] field.

    # In order to resolve code links I must store all 'full identifiers'
    # somewhere, and it makes it easier to serialize if all elements are
    # resolved through iteger identifiers. This is slower but does not
    # require expensive `ref` graph reconstruction during serialization.
    entries*: Table[DocId, DocEntry]
    fullIdents*: Table[DocFullIdent, DocId]


proc hash*(id: DocId): Hash = hash(id.id)
proc hash*(full: var DocFullIdent): Hash =
  if full.docId.id != 0:
    return full.docId.id

  else:
    for part in full.parts:
      result = result !& hash(part.kind) !& hash(part.name)

    result = !$result
    full.docId.id = result

proc hash*(full: DocFullIdent): Hash = full.docId.id
proc `==`*(a, b: DocIdentPart): bool = a.kind == b.kind
proc `==`*(a, b: DocFullIdent): bool = a.parts == b.parts

proc id*(full: var DocFullIdent): DocId {.inline.} = DocId(id: hash(full))
proc id*(de: DocEntry): DocId {.inline.} = de.fullident.id


proc add*(de: var DocEntry, other: DocEntry) =
  de.nested.add other.id

proc `[]`*(db: DocDb, entry: DocEntry): DocEntry = db.entries[entry.id()]
proc `[]`*(db: DocDb, id: DocId): DocEntry = db.entries[id]

proc `[]`*(de: DocEntry, idx: int): DocEntry =
  de.db.entries[de.nested[idx]]

iterator items*(de: DocEntry): DocEntry =
  for id in items(de.nested):
    yield de.db[id]

iterator pairs*(de: DocEntry): (int, DocEntry) =
  for idx, id in pairs(de.nested):
    yield (idx, de.db[id])

proc newDocType*(kind: DocTypeKind, head: DocEntry): DocType =
  result = DocType(kind: kind)
  result.head = head

proc initIdentPart*(kind: DocEntryKind, name: string): DocIdentPart =
  DocIdentPart(kind: kind, name: name)

proc initFullIdent*(parts: sink seq[DocIdentPart]): DocFullIdent =
  result = DocFullIdent(parts: parts)
  discard hash(result)

proc newDocEntry*(
    db: var DocDb, kind: DocEntryKind, name: string): DocEntry =
  ## Create new toplevel entry (package, file, module) directly using DB.
  result = DocEntry(
    fullIdent: initFullIdent(@[initIdentPart(kind, name)]),
    db: db,
    name: name,
    kind: kind
  )

  db.fullIdents[result.fullIdent] = result.id()

proc newDocEntry*(
    parent: var DocEntry, kind: DocEntryKind, name: string
  ): DocEntry =
  ## Create new nested document entry. Add it to subnode of `parent` node.


  result = DocEntry(
    fullIdent: initFullIdent(
      parent.fullIdent.parts & initIdentPart(kind, name)),
    db: parent.db,
    name: name,
    kind: kind
  )

  parent.db.fullIdents[result.fullIdent] = result.id()
  parent.nested.add result.id()
