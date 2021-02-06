import haxorg/semorg
import hnimast/idents_types
import std/[options]

type
  DocEntryKind* = enum
    dekProc
    dekFunc
    dekMacro
    dekMethod
    dekTemplate
    dekIterator

    dekObject
    dekException
    dekDefect
    dekConcept
    dekEnum
    dekEffect
    dekAlias
    dekDistinctAlias

    dekGlobalConst
    dekGlobalVar
    dekGlobalLet

    dekField

const
  dekProcKinds* = {
    dekProc,
    dekFunc,
    dekMacro,
    dekMethod,
    dekTemplate,
    dekIterator
  }

  dekNewtypeKinds* = {
    dekObject,
    dekException,
    dekConcept,
    dekEnum,
    dekEffect,
    dekDistinctAlias
  }

type
  DocSym* = object
    ## Symbol referencing documentable entry
    declLink*: CodeLink ## Direct link to entry

  DocIdent* = object
    ident*: string ## Identifier name
    kind*: NVarDeclKind
    doctext*: SemOrg ## Documentation text
    vtype*: DocType ## Identifier type
    value*: Option[string] ## Optional expression for initialization value

  DocPragma = object

  DocType* = ref object
    ## Single **use** of a type in any documentable context (procedure
    ## arguments, return types etc.). Plays structural role in
    ## documentation context - does not contain any additional information
    ## itself.
    # doctextBody*: SemOrg ## Full documentation text, excluding 'brief'
    # doctextBrief*: SemOrg ## 'bfief' part
    case kind*: NTypeKind
      of ntkIdent, ntkGenericSpec, ntkAnonTuple:
        head*: DocEntry ## Documentation entry
        genParams*: seq[DocType]

      of ntkProc, ntkNamedTuple:
        returnType*: Option[DocType]
        arguments*: seq[DocIdent]
        pragmas*: seq[tuple[entry: DocEntry, arg: string]]
        effects*: seq[DocEntry]
        raises*: seq[DocEntry]

      of ntkRange:
        rngStart*, rngEnd*: string

      of ntkVarargs:
        vaType*: DocType
        vaConverter*: Option[string]

      of ntkValue:
        value*: string

      of ntkNone:
        discard

      of ntkCurly:
        # IMPLEMENT
        discard

  DocEntryUseKind* = enum
    deuDeclaration
    deuReference

  DocEntry* = ref object
    plainName*: string
    genParams*: seq[DocType]
    doctextBody*: SemOrg
    doctextBrief*: SemOrg
    doctextBriefPlain*: string ## Plaintext brief documentation
    docSym*: Option[DocSym] ## Full link to documentable entry
    useKind*: DocEntryUseKind

    admonitions*: seq[tuple[kind: OrgBigIdentKind, body:SemOrg]]
    metatags*: seq[(SemMetaTag, SemOrg)]
    case kind*: DocEntryKind
      of dekProcKinds:
        prSigText*: string
        prSigTree*: DocType

      of dekField:
        fieldName*: string
        fieldType*: DocType

      of dekObject, dekException:
        discard

      of dekEffect:
        discard

      else:
        discard

  DocDB* = ref object
    entries*: seq[DocEntry]
