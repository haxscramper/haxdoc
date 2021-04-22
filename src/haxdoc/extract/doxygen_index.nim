import std/[options]
import hmisc/hasts/[xml_ast]
export options, xml_ast

import hmisc/algo/halgorithm

type
  DoxygenType* = object
    version*: string
    compound*: seq[CompoundType]

  CompoundType* = object
    refid*: string
    kind*: CompoundKind
    name*: string
    member*: seq[MemberType]

  MemberType* = object
    refid*: string
    kind*: MemberKind
    name*: string

  CompoundKind* = enum
    ckClass,                ## XSD enumeration: `class`
    ckStruct,               ## XSD enumeration: `struct`
    ckUnion,                ## XSD enumeration: `union`
    ckInterface,            ## XSD enumeration: `interface`
    ckProtocol,             ## XSD enumeration: `protocol`
    ckCategory,             ## XSD enumeration: `category`
    ckException,            ## XSD enumeration: `exception`
    ckFile,                 ## XSD enumeration: `file`
    ckNamespace,            ## XSD enumeration: `namespace`
    ckGroup,                ## XSD enumeration: `group`
    ckPage,                 ## XSD enumeration: `page`
    ckExample,              ## XSD enumeration: `example`
    ckDir,                  ## XSD enumeration: `dir`
    ckType                   ## XSD enumeration: `type`
  MemberKind* = enum
    mkDefine,               ## XSD enumeration: `define`
    mkProperty,             ## XSD enumeration: `property`
    mkEvent,                ## XSD enumeration: `event`
    mkVariable,             ## XSD enumeration: `variable`
    mkTypedef,              ## XSD enumeration: `typedef`
    mkEnum,                 ## XSD enumeration: `enum`
    mkEnumvalue,            ## XSD enumeration: `enumvalue`
    mkFunction,             ## XSD enumeration: `function`
    mkSignal,               ## XSD enumeration: `signal`
    mkPrototype,            ## XSD enumeration: `prototype`
    mkFriend,               ## XSD enumeration: `friend`
    mkDcop,                 ## XSD enumeration: `dcop`
    mkSlot                   ## XSD enumeration: `slot`

proc parseDoxygenType*(target: var (seq[DoxygenType] | DoxygenType |
    Option[DoxygenType]); parser: var HXmlParser; tag: string;
                       inMixed: bool = false)

proc parseCompoundType*(target: var (seq[CompoundType] | CompoundType |
    Option[CompoundType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false)

proc parseMemberType*(target: var (seq[MemberType] | MemberType |
    Option[MemberType]); parser: var HXmlParser; tag: string;
                      inMixed: bool = false)

proc parseCompoundKind*(target: var (seq[CompoundKind] | CompoundKind |
    Option[CompoundKind]); parser: var HXmlParser; tag: string)

proc parseMemberKind*(target: var (seq[MemberKind] | MemberKind |
    Option[MemberKind]); parser: var HXmlParser; tag: string)

proc parseDoxygenType*(target: var (seq[DoxygenType] | DoxygenType |
    Option[DoxygenType]); parser: var HXmlParser; tag: string;
                       inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDoxygenType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDoxygenType(res, parser, tag)
      target = some(res)
  else:
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "version":
          parseXsdString(target.version, parser, "version")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "compound":
          ## 633:48:xml_to_types.nim
          parseCompoundType(target.compound, parser, "compound", false)
        else:
          ## 638:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseCompoundType*(target: var (seq[CompoundType] | CompoundType |
    Option[CompoundType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseCompoundType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseCompoundType(res, parser, tag)
      target = some(res)
  else:
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "refid":
          parseXsdString(target.refid, parser, "refid")
        of "kind":
          parseCompoundKind(target.kind, parser, "kind")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "name":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "name")
          parseXsdString(target.name, parser, "name")
          skipElementEnd(parser, "name")
        of "member":
          ## 633:48:xml_to_types.nim
          parseMemberType(target.member, parser, "member", false)
        else:
          ## 638:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseMemberType*(target: var (seq[MemberType] | MemberType |
    Option[MemberType]); parser: var HXmlParser; tag: string;
                      inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseMemberType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseMemberType(res, parser, tag)
      target = some(res)
  else:
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "refid":
          parseXsdString(target.refid, parser, "refid")
        of "kind":
          parseMemberKind(target.kind, parser, "kind")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "name":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "name")
          parseXsdString(target.name, parser, "name")
          skipElementEnd(parser, "name")
        else:
          ## 638:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseCompoundKind*(target: var (seq[CompoundKind] | CompoundKind |
    Option[CompoundKind]); parser: var HXmlParser; tag: string) =
  ## 715:4:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseCompoundKind(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseCompoundKind(res, parser, tag)
    target = some(res)
  else:
    case parser.strVal
    of "class":
      target = ckClass
    of "struct":
      target = ckStruct
    of "union":
      target = ckUnion
    of "interface":
      target = ckInterface
    of "protocol":
      target = ckProtocol
    of "category":
      target = ckCategory
    of "exception":
      target = ckException
    of "file":
      target = ckFile
    of "namespace":
      target = ckNamespace
    of "group":
      target = ckGroup
    of "page":
      target = ckPage
    of "example":
      target = ckExample
    of "dir":
      target = ckDir
    of "type":
      target = ckType


proc parseMemberKind*(target: var (seq[MemberKind] | MemberKind |
    Option[MemberKind]); parser: var HXmlParser; tag: string) =
  ## 715:4:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseMemberKind(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseMemberKind(res, parser, tag)
    target = some(res)
  else:
    case parser.strVal
    of "define":
      target = mkDefine
    of "property":
      target = mkProperty
    of "event":
      target = mkEvent
    of "variable":
      target = mkVariable
    of "typedef":
      target = mkTypedef
    of "enum":
      target = mkEnum
    of "enumvalue":
      target = mkEnumvalue
    of "function":
      target = mkFunction
    of "signal":
      target = mkSignal
    of "prototype":
      target = mkPrototype
    of "friend":
      target = mkFriend
    of "dcop":
      target = mkDcop
    of "slot":
      target = mkSlot
