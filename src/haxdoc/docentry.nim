import haxorg/semorg

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

    dekArgument
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
  DocType* = object

  DocEntry* = ref object
    plainName*: string
    genParams*: seq[DocType]
    doctext*: SemOrg
    case kind*: DocEntryKind
      of dekProcKinds:
        arguments*: seq[DocEntry]
        prReturn*: DocType

      of dekArgument:
        argName*: string
        argType*: DocType

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
