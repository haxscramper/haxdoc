import
  haxorg/defs/defs_all,

  std/[tables, options, intsets, hashes],

  hmisc/other/oswrap,
  hmisc/types/hmap,

  hnimast/nimtraits/nimtraits

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
    covPasses*: Option[int] ## Merge code coverage reports with
    ## documentable database.

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
    ids*: IntSet

  DocId* = object
    id* {.Attr.}: Hash

  DocIdTableN* = object
    table*: Table[DocId, DocIdSet]

  DocEntryGroup* = ref object
    entries*: seq[DocEntry]
    nested*: seq[DocEntryGroup]

  DocLinkPart* = object
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

  DocLink* = object
    ## Full scoped identifier for an entry
    docId*: DocId ## Cached identifier value
    parts*: seq[DocLinkPart]

  DocSelectorPart* = object
    name*: string
    expected*: set[DocEntryKind]
    procType*: DocType

  DocSelector* = object
    parts*: seq[DocSelectorPart]

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
    dtukConst
    dtukVolatile

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
    kind*: OrgMetaTag
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

  DocLocationMap* = object
    files*: Table[AbsFile, Map[int,
                  seq[tuple[location: DocPos, link: DocLink]]]]

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
    fullIdent*: DocLink ## Fully scoped identifier for a name

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
    fullIdents*: OrderedTable[DocLink, DocId]
    top*: OrderedTable[DocLinkPart, DocEntry]
    files*: seq[DocFile]
    knownLibs*: seq[DocLib]
    currentTop*: DocEntry
