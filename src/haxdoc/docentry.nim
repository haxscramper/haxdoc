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
  DocIdent* = object
    ident*: string
    kind*: NVarDeclKind
    doctext*: SemOrg
    vtype*: DocType
    value*: Option[string]

  DocType* = ref object
    doctext*: SemOrg
    case kind*: NTypeKind
      of ntkIdent, ntkGenericSpec, ntkAnonTuple:
        head*: string
        genParams*: seq[DocType]

      of ntkProc, ntkNamedTuple:
        returnType*: Option[DocType]
        arguments*: seq[DocIdent]
        pragma*: string

      of ntkRange:
        rngStart*, rngEnd*: string

      of ntkVarargs:
        vaType*: DocType
        vaConverter*: Option[string]

      of ntkValue:
        value*: string

      of ntkNone:
        discard

  DocEntry* = ref object
    plainName*: string
    genParams*: seq[DocType]
    doctext*: SemOrg

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
