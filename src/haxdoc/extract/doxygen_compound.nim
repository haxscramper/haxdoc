import std/[options]
import hmisc/hasts/[xml_ast]
export options, xml_ast

import hmisc/algo/halgorithm

type
  DoxygenType* = object
    version*: DoxVersionNumber
    compounddef*: seq[CompounddefType]

  CompounddefType* = object
    id*: string
    kind*: DoxCompoundKind
    language*: Option[DoxLanguage]
    prot*: DoxProtectionKind
    final*: Option[DoxBool]
    inline*: Option[DoxBool]
    sealed*: Option[DoxBool]
    abstract*: Option[DoxBool]
    compoundname*: string
    title*: Option[string]
    basecompoundref*: seq[CompoundRefType]
    derivedcompoundref*: seq[CompoundRefType]
    includes*: seq[IncType]
    includedby*: seq[IncType]
    incdepgraph*: Option[GraphType]
    invincdepgraph*: Option[GraphType]
    innerdir*: seq[RefType]
    innerfile*: seq[RefType]
    innerclass*: seq[RefType]
    innernamespace*: seq[RefType]
    innerpage*: seq[RefType]
    innergroup*: seq[RefType]
    templateparamlist*: Option[TemplateparamlistType]
    sectiondef*: seq[SectiondefType]
    tableofcontents*: Option[TableofcontentsType]
    briefdescription*: Option[DescriptionType]
    detaileddescription*: Option[DescriptionType]
    inheritancegraph*: Option[GraphType]
    collaborationgraph*: Option[GraphType]
    programlisting*: Option[ListingType]
    location*: Option[LocationType]
    listofallmembers*: Option[ListofallmembersType]

  ListofallmembersType* = object
    member*: seq[MemberRefType]

  MemberRefType* = object
    refid*: string
    prot*: DoxProtectionKind
    virt*: DoxVirtualKind
    ambiguityscope*: string
    scope*: XmlNode
    name*: XmlNode

  DocHtmlOnlyType* = object
    xBlock*: string
    baseExt*: string

  CompoundRefType* = object
    refid*: Option[string]
    prot*: DoxProtectionKind
    virt*: DoxVirtualKind
    baseExt*: string

  ReimplementType* = object
    refid*: string
    baseExt*: string

  IncType* = object
    refid*: string
    local*: DoxBool
    baseExt*: string

  RefType* = object
    refid*: string
    prot*: Option[DoxProtectionKind]
    inline*: Option[DoxBool]
    baseExt*: string

  RefTextType* = object
    refid*: string
    kindref*: DoxRefKind
    external*: Option[string]
    tooltip*: Option[string]
    baseExt*: string

  SectiondefType* = object
    kind*: DoxSectionKind
    header*: Option[string]
    description*: Option[DescriptionType]
    memberdef*: MemberdefType

  MemberdefType* = object
    kind*: DoxMemberKind
    id*: string
    prot*: DoxProtectionKind
    xStatic*: DoxBool
    strong*: Option[DoxBool]
    xConst*: Option[DoxBool]
    explicit*: Option[DoxBool]
    inline*: Option[DoxBool]
    refqual*: Option[DoxRefQualifierKind]
    virt*: Option[DoxVirtualKind]
    volatile*: Option[DoxBool]
    mutable*: Option[DoxBool]
    noexcept*: Option[DoxBool]
    constexpr*: Option[DoxBool]
    readable*: Option[DoxBool]
    writable*: Option[DoxBool]
    initonly*: Option[DoxBool]
    settable*: Option[DoxBool]
    privatesettable*: Option[DoxBool]
    protectedsettable*: Option[DoxBool]
    gettable*: Option[DoxBool]
    privategettable*: Option[DoxBool]
    protectedgettable*: Option[DoxBool]
    final*: Option[DoxBool]
    sealed*: Option[DoxBool]
    new*: Option[DoxBool]
    add*: Option[DoxBool]
    remove*: Option[DoxBool]
    xRaise*: Option[DoxBool]
    optional*: Option[DoxBool]
    required*: Option[DoxBool]
    accessor*: Option[DoxAccessor]
    attribute*: Option[DoxBool]
    property*: Option[DoxBool]
    readonly*: Option[DoxBool]
    bound*: Option[DoxBool]
    removable*: Option[DoxBool]
    constrained*: Option[DoxBool]
    transient*: Option[DoxBool]
    maybevoid*: Option[DoxBool]
    maybedefault*: Option[DoxBool]
    maybeambiguous*: Option[DoxBool]
    templateparamlist*: Option[TemplateparamlistType]
    xType*: Option[LinkedTextType]
    definition*: Option[XmlNode]
    argsstring*: Option[XmlNode]
    name*: XmlNode
    read*: Option[XmlNode]
    write*: Option[XmlNode]
    bitfield*: Option[XmlNode]
    reimplements*: seq[ReimplementType]
    reimplementedby*: seq[ReimplementType]
    param*: seq[ParamType]
    enumvalue*: seq[EnumvalueType]
    initializer*: Option[LinkedTextType]
    exceptions*: Option[LinkedTextType]
    briefdescription*: Option[DescriptionType]
    detaileddescription*: Option[DescriptionType]
    inbodydescription*: Option[DescriptionType]
    location*: LocationType
    references*: seq[ReferenceType]
    referencedby*: seq[ReferenceType]

  DescriptionType* = object
    title*: Option[string]
    para*: seq[DocParaType]
    internal*: seq[DocInternalType]
    sect1*: seq[DocSect1Type]

  EnumvalueType* = object
    id*: string
    prot*: DoxProtectionKind
    name*: XmlNode
    initializer*: Option[LinkedTextType]
    briefdescription*: Option[DescriptionType]
    detaileddescription*: Option[DescriptionType]

  TemplateparamlistType* = object
    param*: seq[ParamType]

  ParamType* = object
    attributes*: Option[XmlNode]
    xType*: Option[LinkedTextType]
    declname*: Option[XmlNode]
    defname*: Option[XmlNode]
    array*: Option[XmlNode]
    defval*: Option[LinkedTextType]
    typeconstraint*: Option[LinkedTextType]
    briefdescription*: Option[DescriptionType]

  LinkedTextType* = object
    xRef*: seq[RefTextType]

  GraphType* = object
    node*: NodeType

  NodeType* = object
    id*: string
    label*: XmlNode
    link*: Option[LinkType]
    childnode*: seq[ChildnodeType]

  ChildnodeType* = object
    refid*: string
    relation*: DoxGraphRelation
    edgelabel*: seq[XmlNode]

  LinkType* = object
    refid*: string
    external*: Option[string]

  ListingType* = object
    filename*: Option[string]
    codeline*: seq[CodelineType]

  CodelineType* = object
    lineno*: int
    refid*: string
    refkind*: DoxRefKind
    external*: DoxBool
    highlight*: seq[HighlightType]

  HighlightType* = object
    class*: DoxHighlightClass
    xsdChoice*: seq[HighlightTypeBody]

  HighlightTypeKind* = enum
    htSp, htRef, htMixedStr
  HighlightTypeBody* = object
    case kind*: HighlightTypeKind
    of htSp:
        sp*: SpType

    of htRef:
        xRef*: RefTextType

    of htMixedStr:
        mixedStr*: string

  
  SpType* = object
    value*: Option[int]

  ReferenceType* = object
    refid*: string
    compoundref*: Option[string]
    startline*: int
    endline*: int

  LocationType* = object
    file*: string
    line*: int
    column*: Option[int]
    declfile*: Option[string]
    declline*: Option[int]
    declcolumn*: Option[int]
    bodyfile*: string
    bodystart*: int
    bodyend*: int

  DocSect1Type* = object
    id*: string
    title*: Option[string]

  DocSect2Type* = object
    id*: string
    title*: string

  DocSect3Type* = object
    id*: string
    title*: string

  DocSect4Type* = object
    id*: string
    title*: string

  DocInternalType* = object
    para*: seq[DocParaType]
    sect1*: seq[DocSect1Type]

  DocInternalS1Type* = object
    para*: seq[DocParaType]
    sect2*: seq[DocSect2Type]

  DocInternalS2Type* = object
    para*: seq[DocParaType]
    sect3*: seq[DocSect3Type]

  DocInternalS3Type* = object
    para*: seq[DocParaType]
    sect3*: seq[DocSect4Type]

  DocInternalS4Type* = object
    para*: seq[DocParaType]

  DocTitleType* = object
  
  DocParaType* = object
  
  DocMarkupType* = object
  
  DocURLLink* = object
    url*: string

  DocAnchorType* = object
    id*: string

  DocFormulaType* = object
    id*: string

  DocIndexEntryType* = object
    primaryie*: string
    secondaryie*: string

  DocListType* = object
    listitem*: DocListItemType

  DocListItemType* = object
    para*: seq[DocParaType]

  DocSimpleSectType* = object
    kind*: DoxSimpleSectKind
    title*: Option[DocTitleType]

  DocVarListEntryType* = object
    term*: DocTitleType

  DocVariableListType* = object
  
  DocRefTextType* = object
    refid*: string
    kindref*: DoxRefKind
    external*: string

  DocTableType* = object
    rows*: int
    cols*: int
    width*: string
    caption*: Option[DocCaptionType]
    row*: seq[DocRowType]

  DocRowType* = object
    entry*: seq[DocEntryType]

  DocEntryType* = object
    thead*: DoxBool
    colspan*: int
    rowspan*: int
    align*: DoxAlign
    valign*: DoxVerticalAlign
    width*: string
    class*: string
    para*: seq[DocParaType]

  DocCaptionType* = object
  
  DocHeadingType* = object
    level*: int

  DocImageType* = object
    xType*: Option[DoxImageKind]
    name*: Option[string]
    width*: Option[string]
    height*: Option[string]
    alt*: Option[string]
    inline*: Option[DoxBool]
    caption*: Option[string]

  DocTocItemType* = object
    id*: string

  DocTocListType* = object
    tocitem*: seq[DocTocItemType]

  DocLanguageType* = object
    langid*: string
    para*: seq[DocParaType]

  DocParamListType* = object
    kind*: DoxParamListKind
    parameteritem*: seq[DocParamListItem]

  DocParamListItem* = object
    parameternamelist*: seq[DocParamNameList]
    parameterdescription*: DescriptionType

  DocParamNameList* = object
    parametertype*: seq[DocParamType]
    parametername*: seq[DocParamName]

  DocParamType* = object
    xRef*: Option[RefTextType]

  DocParamName* = object
    direction*: Option[DoxParamDir]
    xRef*: Option[RefTextType]

  DocXRefSectType* = object
    id*: string
    xreftitle*: seq[string]
    xrefdescription*: DescriptionType

  DocCopyType* = object
    link*: string
    para*: seq[DocParaType]
    sect1*: seq[DocSect1Type]
    internal*: Option[DocInternalType]

  DocBlockQuoteType* = object
    para*: seq[DocParaType]

  DocParBlockType* = object
    para*: seq[DocParaType]

  DocEmptyType* = object
  
  TableofcontentsType* = object
    tocsect*: TableofcontentsKindType

  TableofcontentsKindType* = object
    name*: string
    reference*: string
    tableofcontents*: seq[TableofcontentsType]

  DocEmojiType* = object
    name*: string
    unicode*: string

  DoxBool* = enum
    dbYes,                  ## XSD enumeration: `yes`
    dbNo                     ## XSD enumeration: `no`
  DoxGraphRelation* = enum
    dgrInclude,             ## XSD enumeration: `include`
    dgrUsage,               ## XSD enumeration: `usage`
    dgrTemplateInstance,    ## XSD enumeration: `template-instance`
    dgrPublicInheritance,   ## XSD enumeration: `public-inheritance`
    dgrProtectedInheritance, ## XSD enumeration: `protected-inheritance`
    dgrPrivateInheritance,  ## XSD enumeration: `private-inheritance`
    dgrTypeConstraint        ## XSD enumeration: `type-constraint`
  DoxRefKind* = enum
    drkCompound,            ## XSD enumeration: `compound`
    drkMember                ## XSD enumeration: `member`
  DoxMemberKind* = enum
    dmkDefine,              ## XSD enumeration: `define`
    dmkProperty,            ## XSD enumeration: `property`
    dmkEvent,               ## XSD enumeration: `event`
    dmkVariable,            ## XSD enumeration: `variable`
    dmkTypedef,             ## XSD enumeration: `typedef`
    dmkEnum,                ## XSD enumeration: `enum`
    dmkFunction,            ## XSD enumeration: `function`
    dmkSignal,              ## XSD enumeration: `signal`
    dmkPrototype,           ## XSD enumeration: `prototype`
    dmkFriend,              ## XSD enumeration: `friend`
    dmkDcop,                ## XSD enumeration: `dcop`
    dmkSlot,                ## XSD enumeration: `slot`
    dmkInterface,           ## XSD enumeration: `interface`
    dmkService               ## XSD enumeration: `service`
  DoxProtectionKind* = enum
    dpkPublic,              ## XSD enumeration: `public`
    dpkProtected,           ## XSD enumeration: `protected`
    dpkPrivate,             ## XSD enumeration: `private`
    dpkPackage               ## XSD enumeration: `package`
  DoxRefQualifierKind* = enum
    drqkLvalue,             ## XSD enumeration: `lvalue`
    drqkRvalue               ## XSD enumeration: `rvalue`
  DoxLanguage* = enum
    dlUnknown,              ## XSD enumeration: `Unknown`
    dlIDL,                  ## XSD enumeration: `IDL`
    dlJava,                 ## XSD enumeration: `Java`
    dlCHash,                ## XSD enumeration: `C#`
    dlD,                    ## XSD enumeration: `D`
    dlPHP,                  ## XSD enumeration: `PHP`
    dlObjectiveC,           ## XSD enumeration: `Objective-C`
    dlCPlusPlus,            ## XSD enumeration: `C++`
    dlJavaScript,           ## XSD enumeration: `JavaScript`
    dlPython,               ## XSD enumeration: `Python`
    dlFortran,              ## XSD enumeration: `Fortran`
    dlVHDL,                 ## XSD enumeration: `VHDL`
    dlXML,                  ## XSD enumeration: `XML`
    dlSQL,                  ## XSD enumeration: `SQL`
    dlMarkdown               ## XSD enumeration: `Markdown`
  DoxVirtualKind* = enum
    dvkNonVirtual,          ## XSD enumeration: `non-virtual`
    dvkVirtual,             ## XSD enumeration: `virtual`
    dvkPureVirtual           ## XSD enumeration: `pure-virtual`
  DoxCompoundKind* = enum
    dckClass,               ## XSD enumeration: `class`
    dckStruct,              ## XSD enumeration: `struct`
    dckUnion,               ## XSD enumeration: `union`
    dckInterface,           ## XSD enumeration: `interface`
    dckProtocol,            ## XSD enumeration: `protocol`
    dckCategory,            ## XSD enumeration: `category`
    dckException,           ## XSD enumeration: `exception`
    dckService,             ## XSD enumeration: `service`
    dckSingleton,           ## XSD enumeration: `singleton`
    dckModule,              ## XSD enumeration: `module`
    dckType,                ## XSD enumeration: `type`
    dckFile,                ## XSD enumeration: `file`
    dckNamespace,           ## XSD enumeration: `namespace`
    dckGroup,               ## XSD enumeration: `group`
    dckPage,                ## XSD enumeration: `page`
    dckExample,             ## XSD enumeration: `example`
    dckDir                   ## XSD enumeration: `dir`
  DoxSectionKind* = enum
    dskUserDefined,         ## XSD enumeration: `user-defined`
    dskPublicType,          ## XSD enumeration: `public-type`
    dskPublicFunc,          ## XSD enumeration: `public-func`
    dskPublicAttrib,        ## XSD enumeration: `public-attrib`
    dskPublicSlot,          ## XSD enumeration: `public-slot`
    dskSignal,              ## XSD enumeration: `signal`
    dskDcopFunc,            ## XSD enumeration: `dcop-func`
    dskProperty,            ## XSD enumeration: `property`
    dskEvent,               ## XSD enumeration: `event`
    dskPublicStaticFunc,    ## XSD enumeration: `public-static-func`
    dskPublicStaticAttrib,  ## XSD enumeration: `public-static-attrib`
    dskProtectedType,       ## XSD enumeration: `protected-type`
    dskProtectedFunc,       ## XSD enumeration: `protected-func`
    dskProtectedAttrib,     ## XSD enumeration: `protected-attrib`
    dskProtectedSlot,       ## XSD enumeration: `protected-slot`
    dskProtectedStaticFunc, ## XSD enumeration: `protected-static-func`
    dskProtectedStaticAttrib, ## XSD enumeration: `protected-static-attrib`
    dskPackageType,         ## XSD enumeration: `package-type`
    dskPackageFunc,         ## XSD enumeration: `package-func`
    dskPackageAttrib,       ## XSD enumeration: `package-attrib`
    dskPackageStaticFunc,   ## XSD enumeration: `package-static-func`
    dskPackageStaticAttrib, ## XSD enumeration: `package-static-attrib`
    dskPrivateType,         ## XSD enumeration: `private-type`
    dskPrivateFunc,         ## XSD enumeration: `private-func`
    dskPrivateAttrib,       ## XSD enumeration: `private-attrib`
    dskPrivateSlot,         ## XSD enumeration: `private-slot`
    dskPrivateStaticFunc,   ## XSD enumeration: `private-static-func`
    dskPrivateStaticAttrib, ## XSD enumeration: `private-static-attrib`
    dskFriend,              ## XSD enumeration: `friend`
    dskRelated,             ## XSD enumeration: `related`
    dskDefine,              ## XSD enumeration: `define`
    dskPrototype,           ## XSD enumeration: `prototype`
    dskTypedef,             ## XSD enumeration: `typedef`
    dskEnum,                ## XSD enumeration: `enum`
    dskFunc,                ## XSD enumeration: `func`
    dskVar                   ## XSD enumeration: `var`
  DoxHighlightClass* = enum
    dhcComment,             ## XSD enumeration: `comment`
    dhcNormal,              ## XSD enumeration: `normal`
    dhcPreprocessor,        ## XSD enumeration: `preprocessor`
    dhcKeyword,             ## XSD enumeration: `keyword`
    dhcKeywordtype,         ## XSD enumeration: `keywordtype`
    dhcKeywordflow,         ## XSD enumeration: `keywordflow`
    dhcStringliteral,       ## XSD enumeration: `stringliteral`
    dhcCharliteral,         ## XSD enumeration: `charliteral`
    dhcVhdlkeyword,         ## XSD enumeration: `vhdlkeyword`
    dhcVhdllogic,           ## XSD enumeration: `vhdllogic`
    dhcVhdlchar,            ## XSD enumeration: `vhdlchar`
    dhcVhdldigit             ## XSD enumeration: `vhdldigit`
  DoxSimpleSectKind* = enum
    dsskSee,                ## XSD enumeration: `see`
    dsskReturn,             ## XSD enumeration: `return`
    dsskAuthor,             ## XSD enumeration: `author`
    dsskAuthors,            ## XSD enumeration: `authors`
    dsskVersion,            ## XSD enumeration: `version`
    dsskSince,              ## XSD enumeration: `since`
    dsskDate,               ## XSD enumeration: `date`
    dsskNote,               ## XSD enumeration: `note`
    dsskWarning,            ## XSD enumeration: `warning`
    dsskPre,                ## XSD enumeration: `pre`
    dsskPost,               ## XSD enumeration: `post`
    dsskCopyright,          ## XSD enumeration: `copyright`
    dsskInvariant,          ## XSD enumeration: `invariant`
    dsskRemark,             ## XSD enumeration: `remark`
    dsskAttention,          ## XSD enumeration: `attention`
    dsskPar,                ## XSD enumeration: `par`
    dsskRcs                  ## XSD enumeration: `rcs`
  DoxVersionNumber* = distinct string
  DoxImageKind* = enum
    dikHtml,                ## XSD enumeration: `html`
    dikLatex,               ## XSD enumeration: `latex`
    dikDocbook,             ## XSD enumeration: `docbook`
    dikRtf                   ## XSD enumeration: `rtf`
  DoxParamListKind* = enum
    dplkParam,              ## XSD enumeration: `param`
    dplkRetval,             ## XSD enumeration: `retval`
    dplkException,          ## XSD enumeration: `exception`
    dplkTemplateparam        ## XSD enumeration: `templateparam`
  DoxCharRange* = distinct string
  DoxParamDir* = enum
    dpdIn,                  ## XSD enumeration: `in`
    dpdOut,                 ## XSD enumeration: `out`
    dpdInout                 ## XSD enumeration: `inout`
  DoxAccessor* = enum
    daRetain,               ## XSD enumeration: `retain`
    daCopy,                 ## XSD enumeration: `copy`
    daAssign,               ## XSD enumeration: `assign`
    daWeak,                 ## XSD enumeration: `weak`
    daStrong,               ## XSD enumeration: `strong`
    daUnretained             ## XSD enumeration: `unretained`
  DoxAlign* = enum
    daLeft,                 ## XSD enumeration: `left`
    daRight,                ## XSD enumeration: `right`
    daCenter                 ## XSD enumeration: `center`
  DoxVerticalAlign* = enum
    dvaBottom,              ## XSD enumeration: `bottom`
    dvaTop,                 ## XSD enumeration: `top`
    dvaMiddle                ## XSD enumeration: `middle`

proc parseDoxygenType*(target: var (seq[DoxygenType] | DoxygenType |
    Option[DoxygenType]); parser: var HXmlParser; tag: string;
                       inMixed: bool = false)

proc parseCompounddefType*(target: var (seq[CompounddefType] | CompounddefType |
    Option[CompounddefType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false)

proc parseListofallmembersType*(target: var (seq[ListofallmembersType] |
    ListofallmembersType |
    Option[ListofallmembersType]); parser: var HXmlParser; tag: string;
                                inMixed: bool = false)

proc parseMemberRefType*(target: var (seq[MemberRefType] | MemberRefType |
    Option[MemberRefType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false)

proc parseDocHtmlOnlyType*(target: var (seq[DocHtmlOnlyType] | DocHtmlOnlyType |
    Option[DocHtmlOnlyType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false)

proc parseCompoundRefType*(target: var (seq[CompoundRefType] | CompoundRefType |
    Option[CompoundRefType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false)

proc parseReimplementType*(target: var (seq[ReimplementType] | ReimplementType |
    Option[ReimplementType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false)

proc parseIncType*(target: var (seq[IncType] | IncType | Option[IncType]);
                   parser: var HXmlParser; tag: string; inMixed: bool = false)

proc parseRefType*(target: var (seq[RefType] | RefType | Option[RefType]);
                   parser: var HXmlParser; tag: string; inMixed: bool = false)

proc parseRefTextType*(target: var (seq[RefTextType] | RefTextType |
    Option[RefTextType]); parser: var HXmlParser; tag: string;
                       inMixed: bool = false)

proc parseSectiondefType*(target: var (seq[SectiondefType] | SectiondefType |
    Option[SectiondefType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false)

proc parseMemberdefType*(target: var (seq[MemberdefType] | MemberdefType |
    Option[MemberdefType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false)

proc parseDescriptionType*(target: var (seq[DescriptionType] | DescriptionType |
    Option[DescriptionType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false)

proc parseEnumvalueType*(target: var (seq[EnumvalueType] | EnumvalueType |
    Option[EnumvalueType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false)

proc parseTemplateparamlistType*(target: var (seq[TemplateparamlistType] |
    TemplateparamlistType |
    Option[TemplateparamlistType]); parser: var HXmlParser; tag: string;
                                 inMixed: bool = false)

proc parseParamType*(target: var (seq[ParamType] | ParamType | Option[ParamType]);
                     parser: var HXmlParser; tag: string; inMixed: bool = false)

proc parseLinkedTextType*(target: var (seq[LinkedTextType] | LinkedTextType |
    Option[LinkedTextType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false)

proc parseGraphType*(target: var (seq[GraphType] | GraphType | Option[GraphType]);
                     parser: var HXmlParser; tag: string; inMixed: bool = false)

proc parseNodeType*(target: var (seq[NodeType] | NodeType | Option[NodeType]);
                    parser: var HXmlParser; tag: string; inMixed: bool = false)

proc parseChildnodeType*(target: var (seq[ChildnodeType] | ChildnodeType |
    Option[ChildnodeType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false)

proc parseLinkType*(target: var (seq[LinkType] | LinkType | Option[LinkType]);
                    parser: var HXmlParser; tag: string; inMixed: bool = false)

proc parseListingType*(target: var (seq[ListingType] | ListingType |
    Option[ListingType]); parser: var HXmlParser; tag: string;
                       inMixed: bool = false)

proc parseCodelineType*(target: var (seq[CodelineType] | CodelineType |
    Option[CodelineType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false)

proc parseHighlightType*(target: var (seq[HighlightType] | HighlightType |
    Option[HighlightType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false)

proc parseSpType*(target: var (seq[SpType] | SpType | Option[SpType]);
                  parser: var HXmlParser; tag: string; inMixed: bool = false)

proc parseReferenceType*(target: var (seq[ReferenceType] | ReferenceType |
    Option[ReferenceType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false)

proc parseLocationType*(target: var (seq[LocationType] | LocationType |
    Option[LocationType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false)

proc parseDocSect1Type*(target: var (seq[DocSect1Type] | DocSect1Type |
    Option[DocSect1Type]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false)

proc parseDocSect2Type*(target: var (seq[DocSect2Type] | DocSect2Type |
    Option[DocSect2Type]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false)

proc parseDocSect3Type*(target: var (seq[DocSect3Type] | DocSect3Type |
    Option[DocSect3Type]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false)

proc parseDocSect4Type*(target: var (seq[DocSect4Type] | DocSect4Type |
    Option[DocSect4Type]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false)

proc parseDocInternalType*(target: var (seq[DocInternalType] | DocInternalType |
    Option[DocInternalType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false)

proc parseDocInternalS1Type*(target: var (
    seq[DocInternalS1Type] | DocInternalS1Type | Option[DocInternalS1Type]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false)

proc parseDocInternalS2Type*(target: var (
    seq[DocInternalS2Type] | DocInternalS2Type | Option[DocInternalS2Type]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false)

proc parseDocInternalS3Type*(target: var (
    seq[DocInternalS3Type] | DocInternalS3Type | Option[DocInternalS3Type]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false)

proc parseDocInternalS4Type*(target: var (
    seq[DocInternalS4Type] | DocInternalS4Type | Option[DocInternalS4Type]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false)

proc parseDocTitleType*(target: var (seq[DocTitleType] | DocTitleType |
    Option[DocTitleType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false)

proc parseDocParaType*(target: var (seq[DocParaType] | DocParaType |
    Option[DocParaType]); parser: var HXmlParser; tag: string;
                       inMixed: bool = false)

proc parseDocMarkupType*(target: var (seq[DocMarkupType] | DocMarkupType |
    Option[DocMarkupType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false)

proc parseDocURLLink*(target: var (seq[DocURLLink] | DocURLLink |
    Option[DocURLLink]); parser: var HXmlParser; tag: string;
                      inMixed: bool = false)

proc parseDocAnchorType*(target: var (seq[DocAnchorType] | DocAnchorType |
    Option[DocAnchorType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false)

proc parseDocFormulaType*(target: var (seq[DocFormulaType] | DocFormulaType |
    Option[DocFormulaType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false)

proc parseDocIndexEntryType*(target: var (
    seq[DocIndexEntryType] | DocIndexEntryType | Option[DocIndexEntryType]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false)

proc parseDocListType*(target: var (seq[DocListType] | DocListType |
    Option[DocListType]); parser: var HXmlParser; tag: string;
                       inMixed: bool = false)

proc parseDocListItemType*(target: var (seq[DocListItemType] | DocListItemType |
    Option[DocListItemType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false)

proc parseDocSimpleSectType*(target: var (
    seq[DocSimpleSectType] | DocSimpleSectType | Option[DocSimpleSectType]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false)

proc parseDocVarListEntryType*(target: var (seq[DocVarListEntryType] |
    DocVarListEntryType |
    Option[DocVarListEntryType]); parser: var HXmlParser; tag: string;
                               inMixed: bool = false)

proc parseDocVariableListType*(target: var (seq[DocVariableListType] |
    DocVariableListType |
    Option[DocVariableListType]); parser: var HXmlParser; tag: string;
                               inMixed: bool = false)

proc parseDocRefTextType*(target: var (seq[DocRefTextType] | DocRefTextType |
    Option[DocRefTextType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false)

proc parseDocTableType*(target: var (seq[DocTableType] | DocTableType |
    Option[DocTableType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false)

proc parseDocRowType*(target: var (seq[DocRowType] | DocRowType |
    Option[DocRowType]); parser: var HXmlParser; tag: string;
                      inMixed: bool = false)

proc parseDocEntryType*(target: var (seq[DocEntryType] | DocEntryType |
    Option[DocEntryType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false)

proc parseDocCaptionType*(target: var (seq[DocCaptionType] | DocCaptionType |
    Option[DocCaptionType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false)

proc parseDocHeadingType*(target: var (seq[DocHeadingType] | DocHeadingType |
    Option[DocHeadingType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false)

proc parseDocImageType*(target: var (seq[DocImageType] | DocImageType |
    Option[DocImageType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false)

proc parseDocTocItemType*(target: var (seq[DocTocItemType] | DocTocItemType |
    Option[DocTocItemType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false)

proc parseDocTocListType*(target: var (seq[DocTocListType] | DocTocListType |
    Option[DocTocListType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false)

proc parseDocLanguageType*(target: var (seq[DocLanguageType] | DocLanguageType |
    Option[DocLanguageType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false)

proc parseDocParamListType*(target: var (
    seq[DocParamListType] | DocParamListType | Option[DocParamListType]);
                            parser: var HXmlParser; tag: string;
                            inMixed: bool = false)

proc parseDocParamListItem*(target: var (
    seq[DocParamListItem] | DocParamListItem | Option[DocParamListItem]);
                            parser: var HXmlParser; tag: string;
                            inMixed: bool = false)

proc parseDocParamNameList*(target: var (
    seq[DocParamNameList] | DocParamNameList | Option[DocParamNameList]);
                            parser: var HXmlParser; tag: string;
                            inMixed: bool = false)

proc parseDocParamType*(target: var (seq[DocParamType] | DocParamType |
    Option[DocParamType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false)

proc parseDocParamName*(target: var (seq[DocParamName] | DocParamName |
    Option[DocParamName]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false)

proc parseDocXRefSectType*(target: var (seq[DocXRefSectType] | DocXRefSectType |
    Option[DocXRefSectType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false)

proc parseDocCopyType*(target: var (seq[DocCopyType] | DocCopyType |
    Option[DocCopyType]); parser: var HXmlParser; tag: string;
                       inMixed: bool = false)

proc parseDocBlockQuoteType*(target: var (
    seq[DocBlockQuoteType] | DocBlockQuoteType | Option[DocBlockQuoteType]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false)

proc parseDocParBlockType*(target: var (seq[DocParBlockType] | DocParBlockType |
    Option[DocParBlockType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false)

proc parseDocEmptyType*(target: var (seq[DocEmptyType] | DocEmptyType |
    Option[DocEmptyType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false)

proc parseTableofcontentsType*(target: var (seq[TableofcontentsType] |
    TableofcontentsType |
    Option[TableofcontentsType]); parser: var HXmlParser; tag: string;
                               inMixed: bool = false)

proc parseTableofcontentsKindType*(target: var (seq[TableofcontentsKindType] |
    TableofcontentsKindType |
    Option[TableofcontentsKindType]); parser: var HXmlParser; tag: string;
                                   inMixed: bool = false)

proc parseDocEmojiType*(target: var (seq[DocEmojiType] | DocEmojiType |
    Option[DocEmojiType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false)

proc parseDoxBool*(target: var (seq[DoxBool] | DoxBool | Option[DoxBool]);
                   parser: var HXmlParser; tag: string)

proc parseDoxGraphRelation*(target: var (
    seq[DoxGraphRelation] | DoxGraphRelation | Option[DoxGraphRelation]);
                            parser: var HXmlParser; tag: string)

proc parseDoxRefKind*(target: var (seq[DoxRefKind] | DoxRefKind |
    Option[DoxRefKind]); parser: var HXmlParser; tag: string)

proc parseDoxMemberKind*(target: var (seq[DoxMemberKind] | DoxMemberKind |
    Option[DoxMemberKind]); parser: var HXmlParser; tag: string)

proc parseDoxProtectionKind*(target: var (
    seq[DoxProtectionKind] | DoxProtectionKind | Option[DoxProtectionKind]);
                             parser: var HXmlParser; tag: string)

proc parseDoxRefQualifierKind*(target: var (seq[DoxRefQualifierKind] |
    DoxRefQualifierKind |
    Option[DoxRefQualifierKind]); parser: var HXmlParser; tag: string)

proc parseDoxLanguage*(target: var (seq[DoxLanguage] | DoxLanguage |
    Option[DoxLanguage]); parser: var HXmlParser; tag: string)

proc parseDoxVirtualKind*(target: var (seq[DoxVirtualKind] | DoxVirtualKind |
    Option[DoxVirtualKind]); parser: var HXmlParser; tag: string)

proc parseDoxCompoundKind*(target: var (seq[DoxCompoundKind] | DoxCompoundKind |
    Option[DoxCompoundKind]); parser: var HXmlParser; tag: string)

proc parseDoxSectionKind*(target: var (seq[DoxSectionKind] | DoxSectionKind |
    Option[DoxSectionKind]); parser: var HXmlParser; tag: string)

proc parseDoxHighlightClass*(target: var (
    seq[DoxHighlightClass] | DoxHighlightClass | Option[DoxHighlightClass]);
                             parser: var HXmlParser; tag: string)

proc parseDoxSimpleSectKind*(target: var (
    seq[DoxSimpleSectKind] | DoxSimpleSectKind | Option[DoxSimpleSectKind]);
                             parser: var HXmlParser; tag: string)

proc parseDoxVersionNumber*(target: var (
    seq[DoxVersionNumber] | DoxVersionNumber | Option[DoxVersionNumber]);
                            parser: var HXmlParser; tag: string)

proc parseDoxImageKind*(target: var (seq[DoxImageKind] | DoxImageKind |
    Option[DoxImageKind]); parser: var HXmlParser; tag: string)

proc parseDoxParamListKind*(target: var (
    seq[DoxParamListKind] | DoxParamListKind | Option[DoxParamListKind]);
                            parser: var HXmlParser; tag: string)

proc parseDoxCharRange*(target: var (seq[DoxCharRange] | DoxCharRange |
    Option[DoxCharRange]); parser: var HXmlParser; tag: string)

proc parseDoxParamDir*(target: var (seq[DoxParamDir] | DoxParamDir |
    Option[DoxParamDir]); parser: var HXmlParser; tag: string)

proc parseDoxAccessor*(target: var (seq[DoxAccessor] | DoxAccessor |
    Option[DoxAccessor]); parser: var HXmlParser; tag: string)

proc parseDoxAlign*(target: var (seq[DoxAlign] | DoxAlign | Option[DoxAlign]);
                    parser: var HXmlParser; tag: string)

proc parseDoxVerticalAlign*(target: var (
    seq[DoxVerticalAlign] | DoxVerticalAlign | Option[DoxVerticalAlign]);
                            parser: var HXmlParser; tag: string)

proc parseDoxygenType*(target: var (seq[DoxygenType] | DoxygenType |
    Option[DoxygenType]); parser: var HXmlParser; tag: string;
                       inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
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
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "version":
          parseDoxVersionNumber(target.version, parser, "version")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "compounddef":
          ## 521:26:xml_to_types.nim
          parseCompounddefType(target.compounddef, parser, "compounddef", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseCompounddefType(target.compounddef, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseCompounddefType*(target: var (seq[CompounddefType] | CompounddefType |
    Option[CompounddefType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseCompounddefType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseCompounddefType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        of "kind":
          parseDoxCompoundKind(target.kind, parser, "kind")
        of "language":
          parseDoxLanguage(target.language, parser, "language")
        of "prot":
          parseDoxProtectionKind(target.prot, parser, "prot")
        of "final":
          parseDoxBool(target.final, parser, "final")
        of "inline":
          parseDoxBool(target.inline, parser, "inline")
        of "sealed":
          parseDoxBool(target.sealed, parser, "sealed")
        of "abstract":
          parseDoxBool(target.abstract, parser, "abstract")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "compoundname":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "compoundname")
          parseXsdString(target.compoundname, parser)
          skipElementEnd(parser, "compoundname")
        of "title":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "title")
          parseXsdString(target.title, parser)
          skipElementEnd(parser, "title")
        of "basecompoundref":
          ## 521:26:xml_to_types.nim
          parseCompoundRefType(target.basecompoundref, parser,
                               "basecompoundref", false)
        of "derivedcompoundref":
          ## 521:26:xml_to_types.nim
          parseCompoundRefType(target.derivedcompoundref, parser,
                               "derivedcompoundref", false)
        of "includes":
          ## 521:26:xml_to_types.nim
          parseIncType(target.includes, parser, "includes", false)
        of "includedby":
          ## 521:26:xml_to_types.nim
          parseIncType(target.includedby, parser, "includedby", false)
        of "incdepgraph":
          ## 521:26:xml_to_types.nim
          parseGraphType(target.incdepgraph, parser, "incdepgraph", false)
        of "invincdepgraph":
          ## 521:26:xml_to_types.nim
          parseGraphType(target.invincdepgraph, parser, "invincdepgraph", false)
        of "innerdir":
          ## 521:26:xml_to_types.nim
          parseRefType(target.innerdir, parser, "innerdir", false)
        of "innerfile":
          ## 521:26:xml_to_types.nim
          parseRefType(target.innerfile, parser, "innerfile", false)
        of "innerclass":
          ## 521:26:xml_to_types.nim
          parseRefType(target.innerclass, parser, "innerclass", false)
        of "innernamespace":
          ## 521:26:xml_to_types.nim
          parseRefType(target.innernamespace, parser, "innernamespace", false)
        of "innerpage":
          ## 521:26:xml_to_types.nim
          parseRefType(target.innerpage, parser, "innerpage", false)
        of "innergroup":
          ## 521:26:xml_to_types.nim
          parseRefType(target.innergroup, parser, "innergroup", false)
        of "templateparamlist":
          ## 521:26:xml_to_types.nim
          parseTemplateparamlistType(target.templateparamlist, parser,
                                     "templateparamlist", false)
        of "sectiondef":
          ## 521:26:xml_to_types.nim
          parseSectiondefType(target.sectiondef, parser, "sectiondef", false)
        of "tableofcontents":
          ## 521:26:xml_to_types.nim
          parseTableofcontentsType(target.tableofcontents, parser,
                                   "tableofcontents", false)
        of "briefdescription":
          ## 521:26:xml_to_types.nim
          parseDescriptionType(target.briefdescription, parser,
                               "briefdescription", false)
        of "detaileddescription":
          ## 521:26:xml_to_types.nim
          parseDescriptionType(target.detaileddescription, parser,
                               "detaileddescription", false)
        of "inheritancegraph":
          ## 521:26:xml_to_types.nim
          parseGraphType(target.inheritancegraph, parser, "inheritancegraph",
                         false)
        of "collaborationgraph":
          ## 521:26:xml_to_types.nim
          parseGraphType(target.collaborationgraph, parser,
                         "collaborationgraph", false)
        of "programlisting":
          ## 521:26:xml_to_types.nim
          parseListingType(target.programlisting, parser, "programlisting",
                           false)
        of "location":
          ## 521:26:xml_to_types.nim
          parseLocationType(target.location, parser, "location", false)
        of "listofallmembers":
          ## 521:26:xml_to_types.nim
          parseListofallmembersType(target.listofallmembers, parser,
                                    "listofallmembers", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseXsdString(target.compoundname, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseListofallmembersType*(target: var (seq[ListofallmembersType] |
    ListofallmembersType |
    Option[ListofallmembersType]); parser: var HXmlParser; tag: string;
                                inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseListofallmembersType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseListofallmembersType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "member":
          ## 521:26:xml_to_types.nim
          parseMemberRefType(target.member, parser, "member", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseMemberRefType(target.member, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseMemberRefType*(target: var (seq[MemberRefType] | MemberRefType |
    Option[MemberRefType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseMemberRefType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseMemberRefType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "refid":
          parseXsdString(target.refid, parser, "refid")
        of "prot":
          parseDoxProtectionKind(target.prot, parser, "prot")
        of "virt":
          parseDoxVirtualKind(target.virt, parser, "virt")
        of "ambiguityscope":
          parseXsdString(target.ambiguityscope, parser, "ambiguityscope")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "scope":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "scope")
          parseXsdAnyType(target.scope, parser)
          skipElementEnd(parser, "scope")
        of "name":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "name")
          parseXsdAnyType(target.name, parser)
          skipElementEnd(parser, "name")
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseXsdAnyType(target.scope, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocHtmlOnlyType*(target: var (seq[DocHtmlOnlyType] | DocHtmlOnlyType |
    Option[DocHtmlOnlyType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocHtmlOnlyType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocHtmlOnlyType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "block":
          parseXsdString(target.xBlock, parser, "block")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        parseXsdString(target.baseExt, parser)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseCompoundRefType*(target: var (seq[CompoundRefType] | CompoundRefType |
    Option[CompoundRefType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseCompoundRefType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseCompoundRefType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "refid":
          parseXsdString(target.refid, parser, "refid")
        of "prot":
          parseDoxProtectionKind(target.prot, parser, "prot")
        of "virt":
          parseDoxVirtualKind(target.virt, parser, "virt")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        parseXsdString(target.baseExt, parser)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseReimplementType*(target: var (seq[ReimplementType] | ReimplementType |
    Option[ReimplementType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseReimplementType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseReimplementType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "refid":
          parseXsdString(target.refid, parser, "refid")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        parseXsdString(target.baseExt, parser)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseIncType*(target: var (seq[IncType] | IncType | Option[IncType]);
                   parser: var HXmlParser; tag: string; inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseIncType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseIncType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "refid":
          parseXsdString(target.refid, parser, "refid")
        of "local":
          parseDoxBool(target.local, parser, "local")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        parseXsdString(target.baseExt, parser)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseRefType*(target: var (seq[RefType] | RefType | Option[RefType]);
                   parser: var HXmlParser; tag: string; inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseRefType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseRefType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "refid":
          parseXsdString(target.refid, parser, "refid")
        of "prot":
          parseDoxProtectionKind(target.prot, parser, "prot")
        of "inline":
          parseDoxBool(target.inline, parser, "inline")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        parseXsdString(target.baseExt, parser)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseRefTextType*(target: var (seq[RefTextType] | RefTextType |
    Option[RefTextType]); parser: var HXmlParser; tag: string;
                       inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseRefTextType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseRefTextType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "refid":
          parseXsdString(target.refid, parser, "refid")
        of "kindref":
          parseDoxRefKind(target.kindref, parser, "kindref")
        of "external":
          parseXsdString(target.external, parser, "external")
        of "tooltip":
          parseXsdString(target.tooltip, parser, "tooltip")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        parseXsdString(target.baseExt, parser)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseSectiondefType*(target: var (seq[SectiondefType] | SectiondefType |
    Option[SectiondefType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseSectiondefType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseSectiondefType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "kind":
          parseDoxSectionKind(target.kind, parser, "kind")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "header":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "header")
          parseXsdString(target.header, parser)
          skipElementEnd(parser, "header")
        of "description":
          ## 521:26:xml_to_types.nim
          parseDescriptionType(target.description, parser, "description", false)
        of "memberdef":
          ## 521:26:xml_to_types.nim
          parseMemberdefType(target.memberdef, parser, "memberdef", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseXsdString(target.header, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseMemberdefType*(target: var (seq[MemberdefType] | MemberdefType |
    Option[MemberdefType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseMemberdefType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseMemberdefType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "kind":
          parseDoxMemberKind(target.kind, parser, "kind")
        of "id":
          parseXsdString(target.id, parser, "id")
        of "prot":
          parseDoxProtectionKind(target.prot, parser, "prot")
        of "static":
          parseDoxBool(target.xStatic, parser, "static")
        of "strong":
          parseDoxBool(target.strong, parser, "strong")
        of "const":
          parseDoxBool(target.xConst, parser, "const")
        of "explicit":
          parseDoxBool(target.explicit, parser, "explicit")
        of "inline":
          parseDoxBool(target.inline, parser, "inline")
        of "refqual":
          parseDoxRefQualifierKind(target.refqual, parser, "refqual")
        of "virt":
          parseDoxVirtualKind(target.virt, parser, "virt")
        of "volatile":
          parseDoxBool(target.volatile, parser, "volatile")
        of "mutable":
          parseDoxBool(target.mutable, parser, "mutable")
        of "noexcept":
          parseDoxBool(target.noexcept, parser, "noexcept")
        of "constexpr":
          parseDoxBool(target.constexpr, parser, "constexpr")
        of "readable":
          parseDoxBool(target.readable, parser, "readable")
        of "writable":
          parseDoxBool(target.writable, parser, "writable")
        of "initonly":
          parseDoxBool(target.initonly, parser, "initonly")
        of "settable":
          parseDoxBool(target.settable, parser, "settable")
        of "privatesettable":
          parseDoxBool(target.privatesettable, parser, "privatesettable")
        of "protectedsettable":
          parseDoxBool(target.protectedsettable, parser, "protectedsettable")
        of "gettable":
          parseDoxBool(target.gettable, parser, "gettable")
        of "privategettable":
          parseDoxBool(target.privategettable, parser, "privategettable")
        of "protectedgettable":
          parseDoxBool(target.protectedgettable, parser, "protectedgettable")
        of "final":
          parseDoxBool(target.final, parser, "final")
        of "sealed":
          parseDoxBool(target.sealed, parser, "sealed")
        of "new":
          parseDoxBool(target.new, parser, "new")
        of "add":
          parseDoxBool(target.add, parser, "add")
        of "remove":
          parseDoxBool(target.remove, parser, "remove")
        of "raise":
          parseDoxBool(target.xRaise, parser, "raise")
        of "optional":
          parseDoxBool(target.optional, parser, "optional")
        of "required":
          parseDoxBool(target.required, parser, "required")
        of "accessor":
          parseDoxAccessor(target.accessor, parser, "accessor")
        of "attribute":
          parseDoxBool(target.attribute, parser, "attribute")
        of "property":
          parseDoxBool(target.property, parser, "property")
        of "readonly":
          parseDoxBool(target.readonly, parser, "readonly")
        of "bound":
          parseDoxBool(target.bound, parser, "bound")
        of "removable":
          parseDoxBool(target.removable, parser, "removable")
        of "constrained":
          parseDoxBool(target.constrained, parser, "constrained")
        of "transient":
          parseDoxBool(target.transient, parser, "transient")
        of "maybevoid":
          parseDoxBool(target.maybevoid, parser, "maybevoid")
        of "maybedefault":
          parseDoxBool(target.maybedefault, parser, "maybedefault")
        of "maybeambiguous":
          parseDoxBool(target.maybeambiguous, parser, "maybeambiguous")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "templateparamlist":
          ## 521:26:xml_to_types.nim
          parseTemplateparamlistType(target.templateparamlist, parser,
                                     "templateparamlist", false)
        of "type":
          ## 521:26:xml_to_types.nim
          parseLinkedTextType(target.xType, parser, "type", false)
        of "definition":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "definition")
          parseXsdAnyType(target.definition, parser)
          skipElementEnd(parser, "definition")
        of "argsstring":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "argsstring")
          parseXsdAnyType(target.argsstring, parser)
          skipElementEnd(parser, "argsstring")
        of "name":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "name")
          parseXsdAnyType(target.name, parser)
          skipElementEnd(parser, "name")
        of "read":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "read")
          parseXsdAnyType(target.read, parser)
          skipElementEnd(parser, "read")
        of "write":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "write")
          parseXsdAnyType(target.write, parser)
          skipElementEnd(parser, "write")
        of "bitfield":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "bitfield")
          parseXsdAnyType(target.bitfield, parser)
          skipElementEnd(parser, "bitfield")
        of "reimplements":
          ## 521:26:xml_to_types.nim
          parseReimplementType(target.reimplements, parser, "reimplements",
                               false)
        of "reimplementedby":
          ## 521:26:xml_to_types.nim
          parseReimplementType(target.reimplementedby, parser,
                               "reimplementedby", false)
        of "param":
          ## 521:26:xml_to_types.nim
          parseParamType(target.param, parser, "param", false)
        of "enumvalue":
          ## 521:26:xml_to_types.nim
          parseEnumvalueType(target.enumvalue, parser, "enumvalue", false)
        of "initializer":
          ## 521:26:xml_to_types.nim
          parseLinkedTextType(target.initializer, parser, "initializer", false)
        of "exceptions":
          ## 521:26:xml_to_types.nim
          parseLinkedTextType(target.exceptions, parser, "exceptions", false)
        of "briefdescription":
          ## 521:26:xml_to_types.nim
          parseDescriptionType(target.briefdescription, parser,
                               "briefdescription", false)
        of "detaileddescription":
          ## 521:26:xml_to_types.nim
          parseDescriptionType(target.detaileddescription, parser,
                               "detaileddescription", false)
        of "inbodydescription":
          ## 521:26:xml_to_types.nim
          parseDescriptionType(target.inbodydescription, parser,
                               "inbodydescription", false)
        of "location":
          ## 521:26:xml_to_types.nim
          parseLocationType(target.location, parser, "location", false)
        of "references":
          ## 521:26:xml_to_types.nim
          parseReferenceType(target.references, parser, "references", false)
        of "referencedby":
          ## 521:26:xml_to_types.nim
          parseReferenceType(target.referencedby, parser, "referencedby", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseTemplateparamlistType(target.templateparamlist, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDescriptionType*(target: var (seq[DescriptionType] | DescriptionType |
    Option[DescriptionType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDescriptionType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDescriptionType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "title":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "title")
          parseXsdString(target.title, parser)
          skipElementEnd(parser, "title")
        of "para":
          ## 521:26:xml_to_types.nim
          parseDocParaType(target.para, parser, "para", true)
        of "internal":
          ## 521:26:xml_to_types.nim
          parseDocInternalType(target.internal, parser, "internal", true)
        of "sect1":
          ## 521:26:xml_to_types.nim
          parseDocSect1Type(target.sect1, parser, "sect1", true)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseXsdString(target.title, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseEnumvalueType*(target: var (seq[EnumvalueType] | EnumvalueType |
    Option[EnumvalueType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseEnumvalueType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseEnumvalueType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        of "prot":
          parseDoxProtectionKind(target.prot, parser, "prot")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "name":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "name")
          parseXsdAnyType(target.name, parser)
          skipElementEnd(parser, "name")
        of "initializer":
          ## 521:26:xml_to_types.nim
          parseLinkedTextType(target.initializer, parser, "initializer", true)
        of "briefdescription":
          ## 521:26:xml_to_types.nim
          parseDescriptionType(target.briefdescription, parser,
                               "briefdescription", true)
        of "detaileddescription":
          ## 521:26:xml_to_types.nim
          parseDescriptionType(target.detaileddescription, parser,
                               "detaileddescription", true)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseXsdAnyType(target.name, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseTemplateparamlistType*(target: var (seq[TemplateparamlistType] |
    TemplateparamlistType |
    Option[TemplateparamlistType]); parser: var HXmlParser; tag: string;
                                 inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseTemplateparamlistType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseTemplateparamlistType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "param":
          ## 521:26:xml_to_types.nim
          parseParamType(target.param, parser, "param", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseParamType(target.param, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseParamType*(target: var (seq[ParamType] | ParamType | Option[ParamType]);
                     parser: var HXmlParser; tag: string; inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseParamType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseParamType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "attributes":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "attributes")
          parseXsdAnyType(target.attributes, parser)
          skipElementEnd(parser, "attributes")
        of "type":
          ## 521:26:xml_to_types.nim
          parseLinkedTextType(target.xType, parser, "type", false)
        of "declname":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "declname")
          parseXsdAnyType(target.declname, parser)
          skipElementEnd(parser, "declname")
        of "defname":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "defname")
          parseXsdAnyType(target.defname, parser)
          skipElementEnd(parser, "defname")
        of "array":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "array")
          parseXsdAnyType(target.array, parser)
          skipElementEnd(parser, "array")
        of "defval":
          ## 521:26:xml_to_types.nim
          parseLinkedTextType(target.defval, parser, "defval", false)
        of "typeconstraint":
          ## 521:26:xml_to_types.nim
          parseLinkedTextType(target.typeconstraint, parser, "typeconstraint",
                              false)
        of "briefdescription":
          ## 521:26:xml_to_types.nim
          parseDescriptionType(target.briefdescription, parser,
                               "briefdescription", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseXsdAnyType(target.attributes, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseLinkedTextType*(target: var (seq[LinkedTextType] | LinkedTextType |
    Option[LinkedTextType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseLinkedTextType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseLinkedTextType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "ref":
          ## 521:26:xml_to_types.nim
          parseRefTextType(target.xRef, parser, "ref", true)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseRefTextType(target.xRef, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseGraphType*(target: var (seq[GraphType] | GraphType | Option[GraphType]);
                     parser: var HXmlParser; tag: string; inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseGraphType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseGraphType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "node":
          ## 521:26:xml_to_types.nim
          parseNodeType(target.node, parser, "node", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseNodeType(target.node, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseNodeType*(target: var (seq[NodeType] | NodeType | Option[NodeType]);
                    parser: var HXmlParser; tag: string; inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseNodeType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseNodeType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "label":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "label")
          parseXsdAnyType(target.label, parser)
          skipElementEnd(parser, "label")
        of "link":
          ## 521:26:xml_to_types.nim
          parseLinkType(target.link, parser, "link", false)
        of "childnode":
          ## 521:26:xml_to_types.nim
          parseChildnodeType(target.childnode, parser, "childnode", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseXsdAnyType(target.label, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseChildnodeType*(target: var (seq[ChildnodeType] | ChildnodeType |
    Option[ChildnodeType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseChildnodeType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseChildnodeType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "refid":
          parseXsdString(target.refid, parser, "refid")
        of "relation":
          parseDoxGraphRelation(target.relation, parser, "relation")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "edgelabel":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "edgelabel")
          parseXsdAnyType(target.edgelabel, parser)
          skipElementEnd(parser, "edgelabel")
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseXsdAnyType(target.edgelabel, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseLinkType*(target: var (seq[LinkType] | LinkType | Option[LinkType]);
                    parser: var HXmlParser; tag: string; inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseLinkType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseLinkType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "refid":
          parseXsdString(target.refid, parser, "refid")
        of "external":
          parseXsdString(target.external, parser, "external")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseListingType*(target: var (seq[ListingType] | ListingType |
    Option[ListingType]); parser: var HXmlParser; tag: string;
                       inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseListingType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseListingType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "filename":
          parseXsdString(target.filename, parser, "filename")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "codeline":
          ## 521:26:xml_to_types.nim
          parseCodelineType(target.codeline, parser, "codeline", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseCodelineType(target.codeline, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseCodelineType*(target: var (seq[CodelineType] | CodelineType |
    Option[CodelineType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseCodelineType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseCodelineType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "lineno":
          parseXsdInteger(target.lineno, parser, "lineno")
        of "refid":
          parseXsdString(target.refid, parser, "refid")
        of "refkind":
          parseDoxRefKind(target.refkind, parser, "refkind")
        of "external":
          parseDoxBool(target.external, parser, "external")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "highlight":
          ## 521:26:xml_to_types.nim
          parseHighlightType(target.highlight, parser, "highlight", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseHighlightType(target.highlight, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseHighlightType*(target: var (seq[HighlightType] | HighlightType |
    Option[HighlightType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseHighlightType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseHighlightType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "class":
          parseDoxHighlightClass(target.class, parser, "class")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 607:14:xml_to_types.nim
        let token = parser.xsdToken({xtkElementStart, xtkElementOpen})
        case token.kind
        of xtkCharData:
          ## 587:16:xml_to_types.nim
          var tmp: string
          parseXsdString(tmp, parser)
          var tmp2 = HighlightTypeBody(kind: htMixedStr, mixedStr: tmp)
          add(target.xsdChoice, tmp2)
        of {xtkElementStart, xtkElementOpen}:
          case token.name
          else:
            raiseUnexpectedToken(parser, token)
        else:
          raiseUnexpectedToken(parser, token)
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "sp":
          ## 570:14:xml_to_types.nim
          var tmp: SpType
          parseSpType(tmp, parser, "sp", true)
          var tmp2 = HighlightTypeBody(kind: htSp, sp: tmp)
          add(target.xsdChoice, tmp2)
        of "ref":
          ## 570:14:xml_to_types.nim
          var tmp: RefTextType
          parseRefTextType(tmp, parser, "ref", true)
          var tmp2 = HighlightTypeBody(kind: htRef, xRef: tmp)
          add(target.xsdChoice, tmp2)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseSpType*(target: var (seq[SpType] | SpType | Option[SpType]);
                  parser: var HXmlParser; tag: string; inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseSpType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseSpType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "value":
          parseXsdInteger(target.value, parser, "value")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseReferenceType*(target: var (seq[ReferenceType] | ReferenceType |
    Option[ReferenceType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseReferenceType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseReferenceType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "refid":
          parseXsdString(target.refid, parser, "refid")
        of "compoundref":
          parseXsdString(target.compoundref, parser, "compoundref")
        of "startline":
          parseXsdInteger(target.startline, parser, "startline")
        of "endline":
          parseXsdInteger(target.endline, parser, "endline")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseLocationType*(target: var (seq[LocationType] | LocationType |
    Option[LocationType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseLocationType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseLocationType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "file":
          parseXsdString(target.file, parser, "file")
        of "line":
          parseXsdInteger(target.line, parser, "line")
        of "column":
          parseXsdInteger(target.column, parser, "column")
        of "declfile":
          parseXsdString(target.declfile, parser, "declfile")
        of "declline":
          parseXsdInteger(target.declline, parser, "declline")
        of "declcolumn":
          parseXsdInteger(target.declcolumn, parser, "declcolumn")
        of "bodyfile":
          parseXsdString(target.bodyfile, parser, "bodyfile")
        of "bodystart":
          parseXsdInteger(target.bodystart, parser, "bodystart")
        of "bodyend":
          parseXsdInteger(target.bodyend, parser, "bodyend")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocSect1Type*(target: var (seq[DocSect1Type] | DocSect1Type |
    Option[DocSect1Type]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocSect1Type(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocSect1Type(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "title":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "title")
          parseXsdString(target.title, parser)
          skipElementEnd(parser, "title")
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseXsdString(target.title, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocSect2Type*(target: var (seq[DocSect2Type] | DocSect2Type |
    Option[DocSect2Type]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocSect2Type(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocSect2Type(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "title":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "title")
          parseXsdString(target.title, parser)
          skipElementEnd(parser, "title")
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseXsdString(target.title, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocSect3Type*(target: var (seq[DocSect3Type] | DocSect3Type |
    Option[DocSect3Type]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocSect3Type(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocSect3Type(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "title":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "title")
          parseXsdString(target.title, parser)
          skipElementEnd(parser, "title")
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseXsdString(target.title, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocSect4Type*(target: var (seq[DocSect4Type] | DocSect4Type |
    Option[DocSect4Type]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocSect4Type(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocSect4Type(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "title":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "title")
          parseXsdString(target.title, parser)
          skipElementEnd(parser, "title")
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseXsdString(target.title, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocInternalType*(target: var (seq[DocInternalType] | DocInternalType |
    Option[DocInternalType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocInternalType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocInternalType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "para":
          ## 521:26:xml_to_types.nim
          parseDocParaType(target.para, parser, "para", true)
        of "sect1":
          ## 521:26:xml_to_types.nim
          parseDocSect1Type(target.sect1, parser, "sect1", true)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseDocParaType(target.para, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocInternalS1Type*(target: var (
    seq[DocInternalS1Type] | DocInternalS1Type | Option[DocInternalS1Type]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocInternalS1Type(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocInternalS1Type(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "para":
          ## 521:26:xml_to_types.nim
          parseDocParaType(target.para, parser, "para", true)
        of "sect2":
          ## 521:26:xml_to_types.nim
          parseDocSect2Type(target.sect2, parser, "sect2", true)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseDocParaType(target.para, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocInternalS2Type*(target: var (
    seq[DocInternalS2Type] | DocInternalS2Type | Option[DocInternalS2Type]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocInternalS2Type(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocInternalS2Type(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "para":
          ## 521:26:xml_to_types.nim
          parseDocParaType(target.para, parser, "para", true)
        of "sect3":
          ## 521:26:xml_to_types.nim
          parseDocSect3Type(target.sect3, parser, "sect3", true)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseDocParaType(target.para, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocInternalS3Type*(target: var (
    seq[DocInternalS3Type] | DocInternalS3Type | Option[DocInternalS3Type]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocInternalS3Type(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocInternalS3Type(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "para":
          ## 521:26:xml_to_types.nim
          parseDocParaType(target.para, parser, "para", true)
        of "sect3":
          ## 521:26:xml_to_types.nim
          parseDocSect4Type(target.sect3, parser, "sect3", true)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseDocParaType(target.para, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocInternalS4Type*(target: var (
    seq[DocInternalS4Type] | DocInternalS4Type | Option[DocInternalS4Type]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocInternalS4Type(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocInternalS4Type(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "para":
          ## 521:26:xml_to_types.nim
          parseDocParaType(target.para, parser, "para", true)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseDocParaType(target.para, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocTitleType*(target: var (seq[DocTitleType] | DocTitleType |
    Option[DocTitleType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocTitleType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocTitleType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocParaType*(target: var (seq[DocParaType] | DocParaType |
    Option[DocParaType]); parser: var HXmlParser; tag: string;
                       inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocParaType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocParaType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocMarkupType*(target: var (seq[DocMarkupType] | DocMarkupType |
    Option[DocMarkupType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocMarkupType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocMarkupType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocURLLink*(target: var (seq[DocURLLink] | DocURLLink |
    Option[DocURLLink]); parser: var HXmlParser; tag: string;
                      inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocURLLink(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocURLLink(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "url":
          parseXsdString(target.url, parser, "url")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocAnchorType*(target: var (seq[DocAnchorType] | DocAnchorType |
    Option[DocAnchorType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocAnchorType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocAnchorType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocFormulaType*(target: var (seq[DocFormulaType] | DocFormulaType |
    Option[DocFormulaType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocFormulaType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocFormulaType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocIndexEntryType*(target: var (
    seq[DocIndexEntryType] | DocIndexEntryType | Option[DocIndexEntryType]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocIndexEntryType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocIndexEntryType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "primaryie":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "primaryie")
          parseXsdString(target.primaryie, parser)
          skipElementEnd(parser, "primaryie")
        of "secondaryie":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "secondaryie")
          parseXsdString(target.secondaryie, parser)
          skipElementEnd(parser, "secondaryie")
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseXsdString(target.primaryie, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocListType*(target: var (seq[DocListType] | DocListType |
    Option[DocListType]); parser: var HXmlParser; tag: string;
                       inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocListType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocListType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "listitem":
          ## 521:26:xml_to_types.nim
          parseDocListItemType(target.listitem, parser, "listitem", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseDocListItemType(target.listitem, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocListItemType*(target: var (seq[DocListItemType] | DocListItemType |
    Option[DocListItemType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocListItemType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocListItemType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "para":
          ## 521:26:xml_to_types.nim
          parseDocParaType(target.para, parser, "para", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseDocParaType(target.para, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocSimpleSectType*(target: var (
    seq[DocSimpleSectType] | DocSimpleSectType | Option[DocSimpleSectType]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocSimpleSectType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocSimpleSectType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "kind":
          parseDoxSimpleSectKind(target.kind, parser, "kind")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "title":
          ## 521:26:xml_to_types.nim
          parseDocTitleType(target.title, parser, "title", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseDocTitleType(target.title, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocVarListEntryType*(target: var (seq[DocVarListEntryType] |
    DocVarListEntryType |
    Option[DocVarListEntryType]); parser: var HXmlParser; tag: string;
                               inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocVarListEntryType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocVarListEntryType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "term":
          ## 521:26:xml_to_types.nim
          parseDocTitleType(target.term, parser, "term", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseDocTitleType(target.term, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocVariableListType*(target: var (seq[DocVariableListType] |
    DocVariableListType |
    Option[DocVariableListType]); parser: var HXmlParser; tag: string;
                               inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocVariableListType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocVariableListType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocRefTextType*(target: var (seq[DocRefTextType] | DocRefTextType |
    Option[DocRefTextType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocRefTextType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocRefTextType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "refid":
          parseXsdString(target.refid, parser, "refid")
        of "kindref":
          parseDoxRefKind(target.kindref, parser, "kindref")
        of "external":
          parseXsdString(target.external, parser, "external")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocTableType*(target: var (seq[DocTableType] | DocTableType |
    Option[DocTableType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocTableType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocTableType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "rows":
          parseXsdInteger(target.rows, parser, "rows")
        of "cols":
          parseXsdInteger(target.cols, parser, "cols")
        of "width":
          parseXsdString(target.width, parser, "width")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "caption":
          ## 521:26:xml_to_types.nim
          parseDocCaptionType(target.caption, parser, "caption", false)
        of "row":
          ## 521:26:xml_to_types.nim
          parseDocRowType(target.row, parser, "row", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseDocCaptionType(target.caption, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocRowType*(target: var (seq[DocRowType] | DocRowType |
    Option[DocRowType]); parser: var HXmlParser; tag: string;
                      inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocRowType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocRowType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "entry":
          ## 521:26:xml_to_types.nim
          parseDocEntryType(target.entry, parser, "entry", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseDocEntryType(target.entry, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocEntryType*(target: var (seq[DocEntryType] | DocEntryType |
    Option[DocEntryType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocEntryType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocEntryType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "thead":
          parseDoxBool(target.thead, parser, "thead")
        of "colspan":
          parseXsdInteger(target.colspan, parser, "colspan")
        of "rowspan":
          parseXsdInteger(target.rowspan, parser, "rowspan")
        of "align":
          parseDoxAlign(target.align, parser, "align")
        of "valign":
          parseDoxVerticalAlign(target.valign, parser, "valign")
        of "width":
          parseXsdString(target.width, parser, "width")
        of "class":
          parseXsdString(target.class, parser, "class")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "para":
          ## 521:26:xml_to_types.nim
          parseDocParaType(target.para, parser, "para", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseDocParaType(target.para, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocCaptionType*(target: var (seq[DocCaptionType] | DocCaptionType |
    Option[DocCaptionType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocCaptionType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocCaptionType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocHeadingType*(target: var (seq[DocHeadingType] | DocHeadingType |
    Option[DocHeadingType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocHeadingType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocHeadingType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "level":
          parseXsdInteger(target.level, parser, "level")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocImageType*(target: var (seq[DocImageType] | DocImageType |
    Option[DocImageType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocImageType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocImageType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "type":
          parseDoxImageKind(target.xType, parser, "type")
        of "name":
          parseXsdString(target.name, parser, "name")
        of "width":
          parseXsdString(target.width, parser, "width")
        of "height":
          parseXsdString(target.height, parser, "height")
        of "alt":
          parseXsdString(target.alt, parser, "alt")
        of "inline":
          parseDoxBool(target.inline, parser, "inline")
        of "caption":
          parseXsdString(target.caption, parser, "caption")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocTocItemType*(target: var (seq[DocTocItemType] | DocTocItemType |
    Option[DocTocItemType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocTocItemType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocTocItemType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocTocListType*(target: var (seq[DocTocListType] | DocTocListType |
    Option[DocTocListType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocTocListType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocTocListType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "tocitem":
          ## 521:26:xml_to_types.nim
          parseDocTocItemType(target.tocitem, parser, "tocitem", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseDocTocItemType(target.tocitem, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocLanguageType*(target: var (seq[DocLanguageType] | DocLanguageType |
    Option[DocLanguageType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocLanguageType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocLanguageType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "langid":
          parseXsdString(target.langid, parser, "langid")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "para":
          ## 521:26:xml_to_types.nim
          parseDocParaType(target.para, parser, "para", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseDocParaType(target.para, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocParamListType*(target: var (
    seq[DocParamListType] | DocParamListType | Option[DocParamListType]);
                            parser: var HXmlParser; tag: string;
                            inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocParamListType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocParamListType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "kind":
          parseDoxParamListKind(target.kind, parser, "kind")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "parameteritem":
          ## 521:26:xml_to_types.nim
          parseDocParamListItem(target.parameteritem, parser, "parameteritem",
                                false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseDocParamListItem(target.parameteritem, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocParamListItem*(target: var (
    seq[DocParamListItem] | DocParamListItem | Option[DocParamListItem]);
                            parser: var HXmlParser; tag: string;
                            inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocParamListItem(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocParamListItem(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "parameternamelist":
          ## 521:26:xml_to_types.nim
          parseDocParamNameList(target.parameternamelist, parser,
                                "parameternamelist", false)
        of "parameterdescription":
          ## 521:26:xml_to_types.nim
          parseDescriptionType(target.parameterdescription, parser,
                               "parameterdescription", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseDocParamNameList(target.parameternamelist, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocParamNameList*(target: var (
    seq[DocParamNameList] | DocParamNameList | Option[DocParamNameList]);
                            parser: var HXmlParser; tag: string;
                            inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocParamNameList(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocParamNameList(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "parametertype":
          ## 521:26:xml_to_types.nim
          parseDocParamType(target.parametertype, parser, "parametertype", false)
        of "parametername":
          ## 521:26:xml_to_types.nim
          parseDocParamName(target.parametername, parser, "parametername", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseDocParamType(target.parametertype, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocParamType*(target: var (seq[DocParamType] | DocParamType |
    Option[DocParamType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocParamType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocParamType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "ref":
          ## 521:26:xml_to_types.nim
          parseRefTextType(target.xRef, parser, "ref", true)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseRefTextType(target.xRef, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocParamName*(target: var (seq[DocParamName] | DocParamName |
    Option[DocParamName]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocParamName(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocParamName(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "direction":
          parseDoxParamDir(target.direction, parser, "direction")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "ref":
          ## 521:26:xml_to_types.nim
          parseRefTextType(target.xRef, parser, "ref", true)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseRefTextType(target.xRef, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocXRefSectType*(target: var (seq[DocXRefSectType] | DocXRefSectType |
    Option[DocXRefSectType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocXRefSectType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocXRefSectType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "xreftitle":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "xreftitle")
          parseXsdString(target.xreftitle, parser)
          skipElementEnd(parser, "xreftitle")
        of "xrefdescription":
          ## 521:26:xml_to_types.nim
          parseDescriptionType(target.xrefdescription, parser,
                               "xrefdescription", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseXsdString(target.xreftitle, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocCopyType*(target: var (seq[DocCopyType] | DocCopyType |
    Option[DocCopyType]); parser: var HXmlParser; tag: string;
                       inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocCopyType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocCopyType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "link":
          parseXsdString(target.link, parser, "link")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "para":
          ## 521:26:xml_to_types.nim
          parseDocParaType(target.para, parser, "para", false)
        of "sect1":
          ## 521:26:xml_to_types.nim
          parseDocSect1Type(target.sect1, parser, "sect1", false)
        of "internal":
          ## 521:26:xml_to_types.nim
          parseDocInternalType(target.internal, parser, "internal", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseDocParaType(target.para, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocBlockQuoteType*(target: var (
    seq[DocBlockQuoteType] | DocBlockQuoteType | Option[DocBlockQuoteType]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocBlockQuoteType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocBlockQuoteType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "para":
          ## 521:26:xml_to_types.nim
          parseDocParaType(target.para, parser, "para", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseDocParaType(target.para, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocParBlockType*(target: var (seq[DocParBlockType] | DocParBlockType |
    Option[DocParBlockType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocParBlockType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocParBlockType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "para":
          ## 521:26:xml_to_types.nim
          parseDocParaType(target.para, parser, "para", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseDocParaType(target.para, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocEmptyType*(target: var (seq[DocEmptyType] | DocEmptyType |
    Option[DocEmptyType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocEmptyType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocEmptyType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseTableofcontentsType*(target: var (seq[TableofcontentsType] |
    TableofcontentsType |
    Option[TableofcontentsType]); parser: var HXmlParser; tag: string;
                               inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseTableofcontentsType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseTableofcontentsType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "tocsect":
          ## 521:26:xml_to_types.nim
          parseTableofcontentsKindType(target.tocsect, parser, "tocsect", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseTableofcontentsKindType(target.tocsect, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseTableofcontentsKindType*(target: var (seq[TableofcontentsKindType] |
    TableofcontentsKindType |
    Option[TableofcontentsKindType]); parser: var HXmlParser; tag: string;
                                   inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseTableofcontentsKindType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseTableofcontentsKindType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        of "name":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "name")
          parseXsdString(target.name, parser)
          skipElementEnd(parser, "name")
        of "reference":
          ## 521:26:xml_to_types.nim
          skipElementStart(parser, "reference")
          parseXsdString(target.reference, parser)
          skipElementEnd(parser, "reference")
        of "tableofcontents":
          ## 521:26:xml_to_types.nim
          parseTableofcontentsType(target.tableofcontents, parser,
                                   "tableofcontents", false)
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of xmlCharData:
        ## 649:10:xml_to_types.nim
        parseXsdString(target.name, parser, tag)
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDocEmojiType*(target: var (seq[DocEmojiType] | DocEmojiType |
    Option[DocEmojiType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 693:4:xml_to_types.nim
  when target is seq:
    while parser.elementName == tag:
      var res: typeof(target[0])
      parseDocEmojiType(res, parser, tag)
      add(target, res)
  elif target is Option:
    if parser.elementName == tag:
      var res: typeof(target.get())
      parseDocEmojiType(res, parser, tag)
      target = some(res)
  else:
    if parser.elementName() != tag:
      raiseUnexpectedElement(parser, tag)
    next(parser)
    var inAttributes = false
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "name":
          parseXsdString(target.name, parser, "name")
        of "unicode":
          parseXsdString(target.unicode, parser, "unicode")
        else:
          ## 485:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        if parser.kind == xmlElementOpen:
          inAttributes = true
        case parser.elementName()
        else:
          ## 618:4:xml_to_types.nim
          if inMixed:
            return
          else:
            raiseUnexpectedElement(parser)
      of {xmlError, xmlEof, xmlCharData, xmlWhitespace, xmlComment, xmlPI,
          xmlCData, xmlEntity, xmlSpecial}:
        ## 667:6:xml_to_types.nim
        echo parser.displayAt()
        assert false
      of xmlElementClose:
        parser.next()
      of xmlElementEnd:
        if parser.elementName() == tag:
          parser.next()
          break
        else:
          raiseUnexpectedElement(parser)


proc parseDoxBool*(target: var (seq[DoxBool] | DoxBool | Option[DoxBool]);
                   parser: var HXmlParser; tag: string) =
  ## 751:4:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseDoxBool(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseDoxBool(res, parser, tag)
    target = some(res)
  else:
    case parser.strVal
    of "yes":
      target = dbYes
    of "no":
      target = dbNo


proc parseDoxGraphRelation*(target: var (
    seq[DoxGraphRelation] | DoxGraphRelation | Option[DoxGraphRelation]);
                            parser: var HXmlParser; tag: string) =
  ## 751:4:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseDoxGraphRelation(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseDoxGraphRelation(res, parser, tag)
    target = some(res)
  else:
    case parser.strVal
    of "include":
      target = dgrInclude
    of "usage":
      target = dgrUsage
    of "template-instance":
      target = dgrTemplateInstance
    of "public-inheritance":
      target = dgrPublicInheritance
    of "protected-inheritance":
      target = dgrProtectedInheritance
    of "private-inheritance":
      target = dgrPrivateInheritance
    of "type-constraint":
      target = dgrTypeConstraint


proc parseDoxRefKind*(target: var (seq[DoxRefKind] | DoxRefKind |
    Option[DoxRefKind]); parser: var HXmlParser; tag: string) =
  ## 751:4:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseDoxRefKind(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseDoxRefKind(res, parser, tag)
    target = some(res)
  else:
    case parser.strVal
    of "compound":
      target = drkCompound
    of "member":
      target = drkMember


proc parseDoxMemberKind*(target: var (seq[DoxMemberKind] | DoxMemberKind |
    Option[DoxMemberKind]); parser: var HXmlParser; tag: string) =
  ## 751:4:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseDoxMemberKind(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseDoxMemberKind(res, parser, tag)
    target = some(res)
  else:
    case parser.strVal
    of "define":
      target = dmkDefine
    of "property":
      target = dmkProperty
    of "event":
      target = dmkEvent
    of "variable":
      target = dmkVariable
    of "typedef":
      target = dmkTypedef
    of "enum":
      target = dmkEnum
    of "function":
      target = dmkFunction
    of "signal":
      target = dmkSignal
    of "prototype":
      target = dmkPrototype
    of "friend":
      target = dmkFriend
    of "dcop":
      target = dmkDcop
    of "slot":
      target = dmkSlot
    of "interface":
      target = dmkInterface
    of "service":
      target = dmkService


proc parseDoxProtectionKind*(target: var (
    seq[DoxProtectionKind] | DoxProtectionKind | Option[DoxProtectionKind]);
                             parser: var HXmlParser; tag: string) =
  ## 751:4:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseDoxProtectionKind(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseDoxProtectionKind(res, parser, tag)
    target = some(res)
  else:
    case parser.strVal
    of "public":
      target = dpkPublic
    of "protected":
      target = dpkProtected
    of "private":
      target = dpkPrivate
    of "package":
      target = dpkPackage


proc parseDoxRefQualifierKind*(target: var (seq[DoxRefQualifierKind] |
    DoxRefQualifierKind |
    Option[DoxRefQualifierKind]); parser: var HXmlParser; tag: string) =
  ## 751:4:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseDoxRefQualifierKind(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseDoxRefQualifierKind(res, parser, tag)
    target = some(res)
  else:
    case parser.strVal
    of "lvalue":
      target = drqkLvalue
    of "rvalue":
      target = drqkRvalue


proc parseDoxLanguage*(target: var (seq[DoxLanguage] | DoxLanguage |
    Option[DoxLanguage]); parser: var HXmlParser; tag: string) =
  ## 751:4:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseDoxLanguage(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseDoxLanguage(res, parser, tag)
    target = some(res)
  else:
    case parser.strVal
    of "Unknown":
      target = dlUnknown
    of "IDL":
      target = dlIDL
    of "Java":
      target = dlJava
    of "C#":
      target = dlCHash
    of "D":
      target = dlD
    of "PHP":
      target = dlPHP
    of "Objective-C":
      target = dlObjectiveC
    of "C++":
      target = dlCPlusPlus
    of "JavaScript":
      target = dlJavaScript
    of "Python":
      target = dlPython
    of "Fortran":
      target = dlFortran
    of "VHDL":
      target = dlVHDL
    of "XML":
      target = dlXML
    of "SQL":
      target = dlSQL
    of "Markdown":
      target = dlMarkdown


proc parseDoxVirtualKind*(target: var (seq[DoxVirtualKind] | DoxVirtualKind |
    Option[DoxVirtualKind]); parser: var HXmlParser; tag: string) =
  ## 751:4:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseDoxVirtualKind(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseDoxVirtualKind(res, parser, tag)
    target = some(res)
  else:
    case parser.strVal
    of "non-virtual":
      target = dvkNonVirtual
    of "virtual":
      target = dvkVirtual
    of "pure-virtual":
      target = dvkPureVirtual


proc parseDoxCompoundKind*(target: var (seq[DoxCompoundKind] | DoxCompoundKind |
    Option[DoxCompoundKind]); parser: var HXmlParser; tag: string) =
  ## 751:4:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseDoxCompoundKind(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseDoxCompoundKind(res, parser, tag)
    target = some(res)
  else:
    case parser.strVal
    of "class":
      target = dckClass
    of "struct":
      target = dckStruct
    of "union":
      target = dckUnion
    of "interface":
      target = dckInterface
    of "protocol":
      target = dckProtocol
    of "category":
      target = dckCategory
    of "exception":
      target = dckException
    of "service":
      target = dckService
    of "singleton":
      target = dckSingleton
    of "module":
      target = dckModule
    of "type":
      target = dckType
    of "file":
      target = dckFile
    of "namespace":
      target = dckNamespace
    of "group":
      target = dckGroup
    of "page":
      target = dckPage
    of "example":
      target = dckExample
    of "dir":
      target = dckDir


proc parseDoxSectionKind*(target: var (seq[DoxSectionKind] | DoxSectionKind |
    Option[DoxSectionKind]); parser: var HXmlParser; tag: string) =
  ## 751:4:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseDoxSectionKind(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseDoxSectionKind(res, parser, tag)
    target = some(res)
  else:
    case parser.strVal
    of "user-defined":
      target = dskUserDefined
    of "public-type":
      target = dskPublicType
    of "public-func":
      target = dskPublicFunc
    of "public-attrib":
      target = dskPublicAttrib
    of "public-slot":
      target = dskPublicSlot
    of "signal":
      target = dskSignal
    of "dcop-func":
      target = dskDcopFunc
    of "property":
      target = dskProperty
    of "event":
      target = dskEvent
    of "public-static-func":
      target = dskPublicStaticFunc
    of "public-static-attrib":
      target = dskPublicStaticAttrib
    of "protected-type":
      target = dskProtectedType
    of "protected-func":
      target = dskProtectedFunc
    of "protected-attrib":
      target = dskProtectedAttrib
    of "protected-slot":
      target = dskProtectedSlot
    of "protected-static-func":
      target = dskProtectedStaticFunc
    of "protected-static-attrib":
      target = dskProtectedStaticAttrib
    of "package-type":
      target = dskPackageType
    of "package-func":
      target = dskPackageFunc
    of "package-attrib":
      target = dskPackageAttrib
    of "package-static-func":
      target = dskPackageStaticFunc
    of "package-static-attrib":
      target = dskPackageStaticAttrib
    of "private-type":
      target = dskPrivateType
    of "private-func":
      target = dskPrivateFunc
    of "private-attrib":
      target = dskPrivateAttrib
    of "private-slot":
      target = dskPrivateSlot
    of "private-static-func":
      target = dskPrivateStaticFunc
    of "private-static-attrib":
      target = dskPrivateStaticAttrib
    of "friend":
      target = dskFriend
    of "related":
      target = dskRelated
    of "define":
      target = dskDefine
    of "prototype":
      target = dskPrototype
    of "typedef":
      target = dskTypedef
    of "enum":
      target = dskEnum
    of "func":
      target = dskFunc
    of "var":
      target = dskVar


proc parseDoxHighlightClass*(target: var (
    seq[DoxHighlightClass] | DoxHighlightClass | Option[DoxHighlightClass]);
                             parser: var HXmlParser; tag: string) =
  ## 751:4:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseDoxHighlightClass(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseDoxHighlightClass(res, parser, tag)
    target = some(res)
  else:
    case parser.strVal
    of "comment":
      target = dhcComment
    of "normal":
      target = dhcNormal
    of "preprocessor":
      target = dhcPreprocessor
    of "keyword":
      target = dhcKeyword
    of "keywordtype":
      target = dhcKeywordtype
    of "keywordflow":
      target = dhcKeywordflow
    of "stringliteral":
      target = dhcStringliteral
    of "charliteral":
      target = dhcCharliteral
    of "vhdlkeyword":
      target = dhcVhdlkeyword
    of "vhdllogic":
      target = dhcVhdllogic
    of "vhdlchar":
      target = dhcVhdlchar
    of "vhdldigit":
      target = dhcVhdldigit


proc parseDoxSimpleSectKind*(target: var (
    seq[DoxSimpleSectKind] | DoxSimpleSectKind | Option[DoxSimpleSectKind]);
                             parser: var HXmlParser; tag: string) =
  ## 751:4:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseDoxSimpleSectKind(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseDoxSimpleSectKind(res, parser, tag)
    target = some(res)
  else:
    case parser.strVal
    of "see":
      target = dsskSee
    of "return":
      target = dsskReturn
    of "author":
      target = dsskAuthor
    of "authors":
      target = dsskAuthors
    of "version":
      target = dsskVersion
    of "since":
      target = dsskSince
    of "date":
      target = dsskDate
    of "note":
      target = dsskNote
    of "warning":
      target = dsskWarning
    of "pre":
      target = dsskPre
    of "post":
      target = dsskPost
    of "copyright":
      target = dsskCopyright
    of "invariant":
      target = dsskInvariant
    of "remark":
      target = dsskRemark
    of "attention":
      target = dsskAttention
    of "par":
      target = dsskPar
    of "rcs":
      target = dsskRcs


proc parseDoxVersionNumber*(target: var (
    seq[DoxVersionNumber] | DoxVersionNumber | Option[DoxVersionNumber]);
                            parser: var HXmlParser; tag: string) =
  ## 791:10:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseDoxVersionNumber(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseDoxVersionNumber(res, parser, tag)
    target = some(res)
  else:
    var tmp: string
    parseXsdString(tmp, parser)
    target = DoxVersionNumber(tmp)


proc parseDoxImageKind*(target: var (seq[DoxImageKind] | DoxImageKind |
    Option[DoxImageKind]); parser: var HXmlParser; tag: string) =
  ## 751:4:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseDoxImageKind(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseDoxImageKind(res, parser, tag)
    target = some(res)
  else:
    case parser.strVal
    of "html":
      target = dikHtml
    of "latex":
      target = dikLatex
    of "docbook":
      target = dikDocbook
    of "rtf":
      target = dikRtf


proc parseDoxParamListKind*(target: var (
    seq[DoxParamListKind] | DoxParamListKind | Option[DoxParamListKind]);
                            parser: var HXmlParser; tag: string) =
  ## 751:4:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseDoxParamListKind(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseDoxParamListKind(res, parser, tag)
    target = some(res)
  else:
    case parser.strVal
    of "param":
      target = dplkParam
    of "retval":
      target = dplkRetval
    of "exception":
      target = dplkException
    of "templateparam":
      target = dplkTemplateparam


proc parseDoxCharRange*(target: var (seq[DoxCharRange] | DoxCharRange |
    Option[DoxCharRange]); parser: var HXmlParser; tag: string) =
  ## 791:10:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseDoxCharRange(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseDoxCharRange(res, parser, tag)
    target = some(res)
  else:
    var tmp: string
    parseXsdString(tmp, parser)
    target = DoxCharRange(tmp)


proc parseDoxParamDir*(target: var (seq[DoxParamDir] | DoxParamDir |
    Option[DoxParamDir]); parser: var HXmlParser; tag: string) =
  ## 751:4:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseDoxParamDir(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseDoxParamDir(res, parser, tag)
    target = some(res)
  else:
    case parser.strVal
    of "in":
      target = dpdIn
    of "out":
      target = dpdOut
    of "inout":
      target = dpdInout


proc parseDoxAccessor*(target: var (seq[DoxAccessor] | DoxAccessor |
    Option[DoxAccessor]); parser: var HXmlParser; tag: string) =
  ## 751:4:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseDoxAccessor(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseDoxAccessor(res, parser, tag)
    target = some(res)
  else:
    case parser.strVal
    of "retain":
      target = daRetain
    of "copy":
      target = daCopy
    of "assign":
      target = daAssign
    of "weak":
      target = daWeak
    of "strong":
      target = daStrong
    of "unretained":
      target = daUnretained


proc parseDoxAlign*(target: var (seq[DoxAlign] | DoxAlign | Option[DoxAlign]);
                    parser: var HXmlParser; tag: string) =
  ## 751:4:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseDoxAlign(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseDoxAlign(res, parser, tag)
    target = some(res)
  else:
    case parser.strVal
    of "left":
      target = daLeft
    of "right":
      target = daRight
    of "center":
      target = daCenter


proc parseDoxVerticalAlign*(target: var (
    seq[DoxVerticalAlign] | DoxVerticalAlign | Option[DoxVerticalAlign]);
                            parser: var HXmlParser; tag: string) =
  ## 751:4:xml_to_types.nim
  when target is seq:
    var res: typeof(target[0])
    parseDoxVerticalAlign(res, parser, tag)
    add(target, res)
  elif target is Option:
    var res: typeof(target.get())
    parseDoxVerticalAlign(res, parser, tag)
    target = some(res)
  else:
    case parser.strVal
    of "bottom":
      target = dvaBottom
    of "top":
      target = dvaTop
    of "middle":
      target = dvaMiddle
