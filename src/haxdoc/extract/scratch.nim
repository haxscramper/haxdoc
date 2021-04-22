import haxorg/semorg
import hnimast/idents_types
import std/[options]



type
  DocSym* = object
    ## Symbol referencing documentable entry
    declLink*: CodeLink ## Direct link to entry



  DocPragma = object


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
