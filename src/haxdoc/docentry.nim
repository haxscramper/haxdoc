## Definition of shared documentable entry

import haxorg/[ast, semorg]
import hmisc/other/[oswrap]
import std/[options]

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
    refid*: string
    entry*: DocEntry ## Documentable entry. Possibly nil, should be
                     ## resolved through @field{refid}

    kind*: DocOccurKind

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
    entry*: DocEntry

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
        pragmas*: seq[tuple[entry: DocEntry, arg: string]]
        effects*: seq[DocEntry]
        raises*: seq[DocEntry]

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
    nested*: seq[DocEntry] ## Nested documentable entries. Not all
    ## `DocEntryKind` is guaranteed to have one.

    name*: string
    refid*: DocOccur

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
    entries*: seq[DocEntry]
    files*: seq[DocFile]
