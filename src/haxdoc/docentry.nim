## Definition of shared documentable entry

import haxorg/[ast, semorg]
import hmisc/other/[oswrap]
import std/[options, tables, hashes]
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
  dekAliasKinds* = { dekTypeclass, dekAlias, dekDistinctAlias }

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

    dokUsage
    dokCall
    dokInheritance
    dokOverride
    dokInclude
    dokImport
    dokMacroUsage
    dokAnnotationUsage

    dokDefinition

  DocOccur* = object
    ## Single occurence of documentable entry
    refid*: DocId ## Documentable entry id
    kind*: DocOccurKind ## Type of entry occurence

  DocCodePart* = object
    ## Single code part with optional occurence link.
    text*: string ## Code context itself
    occur*: Option[DocOccur] ## 'link' to documentable entry

  DocCode* = object
    ## Block of source code with embedded occurence links.
    parts*: seq[DocCodePart]

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
    id* {.Attr.}: Hash

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
        argTypes*: seq[DocType]

      else:
        discard

  DocFullIdent* = object
    ## Full scoped identifier for an entry
    docId*: DocId ## Cached identifier value
    parts*: seq[DocIdentPart]

  DocPragma* = object
    entry*: DocId
    args*: seq[DocCode]

  DocType* = ref object
    ## Single **use** of a type in any documentable context (procedure
    ## arguments, return types etc.). Plays structural role in
    ## documentation context - does not contain any additional information
    ## itself.
    # doctextBody*: SemOrg ## Full documentation text, excluding 'brief'
    # doctextBrief*: SemOrg ## 'bfief' part
    case kind*: DocTypeKind
      of dtkIdent, dtkGenericSpec, dtkAnonTuple:
        head*: DocId ## Documentation entry
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

      of dtkVarargs:
        vaType*: DocType
        vaConverter*: Option[string]

      of dtkValue:
        value*: string

      of dtkNone, dtkTypeofExpr:
        discard

      of dtkFile, dtkDir, dtkString:
        strVal*: string

  DocAdmonition* = ref object
    kind*: OrgBigIdentKind
    body*: SemOrg

  DocMetatag* = ref object
    kind*: SemMetaTag
    body*: SemOrg

  DocLocation* = object
    column* {.Attr.}: int
    line* {.Attr.}: int
    file* {.Attr.}: string

  DocEntry* = ref object
    location*: Option[DocLocation]
    nested*: seq[DocId] ## Nested documentable entries. Not all
    ## `DocEntryKind` is guaranteed to have one.

    db*: DocDb ## Parent documentable entry database

    name* {.Attr.}: string
    fullIdent*: DocFullIdent ## Fully scoped identifier for a name

    docBrief*: SemOrg
    docBody*: SemOrg
    admonitions*: seq[DocAdmonition]
    metatags*: seq[DocMetatag]
    rawDoc*: seq[string]

    case kind*: DocEntryKind
      of dekObject, dekDefect, dekException, dekEffect:
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

      else:
        discard

  DocFile* = object
    absPath: AbsFile

  DocDb* = ref object
    ## - DESIGN :: Two-layer mapping between full entry identifiers, their
    ##   hashes and documentable entries. Hashes are also mapped to full
    ##   identifiers using [[code:DocEntry.fullIdent]] field.

    # In order to resolve code links I must store all 'full identifiers'
    # somewhere, and it makes it easier to serialize if all elements are
    # resolved through iteger identifiers. This is slower but does not
    # require expensive `ref` graph reconstruction during serialization.
    entries*: Table[DocId, DocEntry]
    fullIdents*: Table[DocFullIdent, DocId]
    top*: seq[DocEntry]

storeTraits(DocEntry, dekAliasKinds)

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

proc hash*(id: DocId): Hash = hash(id.id)
proc hash*(full: var DocFullIdent): Hash =
  # Full identifier hash should be very stable (only changed if the name of
  # the entry is changed)
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

proc contains*(db: DocDb, id: DocId): bool = id in db.entries
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
  result.head = head.id()

proc initIdentPart*(kind: DocEntryKind, name: string): DocIdentPart =
  DocIdentPart(kind: kind, name: name)

proc initFullIdent*(parts: sink seq[DocIdentPart]): DocFullIdent =
  result = DocFullIdent(parts: parts)
  discard hash(result)

proc lastIdentPart*(entry: var DocEntry): var DocIdentPart =
  if entry.fullIdent.parts.len == 0:
    raiseArgumentError("Cannot return last ident part")

  return entry.fullIdent.parts[^1]

proc newDocEntry*(
    db: var DocDb, kind: DocEntryKind, name: string): DocEntry =
  ## Create new toplevel entry (package, file, module) directly using DB.
  result = DocEntry(
    fullIdent: initFullIdent(@[initIdentPart(kind, name)]),
    db: db,
    name: name,
    kind: kind
  )

  db.entries[result.id()] = result
  db.fullIdents[result.fullIdent] = result.id()
  db.top.add result

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

  parent.db.entries[result.id()] = result
  parent.db.fullIdents[result.fullIdent] = result.id()
  parent.nested.add result.id()
