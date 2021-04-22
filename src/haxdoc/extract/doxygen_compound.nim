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
    fBlock*: string
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
    memberdef*: seq[MemberdefType]

  MemberdefType* = object
    kind*: DoxMemberKind
    id*: string
    prot*: DoxProtectionKind
    fStatic*: DoxBool
    strong*: Option[DoxBool]
    fConst*: Option[DoxBool]
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
    fRaise*: Option[DoxBool]
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
    fType*: Option[LinkedTextType]
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

  DescriptionTypeKind* = enum
    dtTitle1, dtPara, dtInternal, dtSect1, dtMixedStr
  DescriptionTypeBody* = object
    case kind*: DescriptionTypeKind
    of dtTitle1:
        string*: string

    of dtPara:
        docParaType*: DocParaType

    of dtInternal:
        docInternalType*: DocInternalType

    of dtSect1:
        docSect1Type*: DocSect1Type

    of dtMixedStr:
        mixedStr*: string

  
  DescriptionType* = object
    xsdChoice*: seq[DescriptionTypeBody]

  EnumvalueTypeKind* = enum
    etName2, etInitializer1, etBriefdescription2, etDetaileddescription2,
    etMixedStr1
  EnumvalueTypeBody* = object
    case kind*: EnumvalueTypeKind
    of etName2:
        xmlNode*: XmlNode

    of etInitializer1:
        linkedTextType*: LinkedTextType

    of etBriefdescription2, etDetaileddescription2:
        descriptionType*: DescriptionType

    of etMixedStr1:
        mixedStr*: string

  
  EnumvalueType* = object
    id*: string
    prot*: DoxProtectionKind
    xsdChoice*: seq[EnumvalueTypeBody]

  TemplateparamlistType* = object
    param*: seq[ParamType]

  ParamType* = object
    attributes*: Option[XmlNode]
    fType*: Option[LinkedTextType]
    declname*: Option[XmlNode]
    defname*: Option[XmlNode]
    array*: Option[XmlNode]
    defval*: Option[LinkedTextType]
    typeconstraint*: Option[LinkedTextType]
    briefdescription*: Option[DescriptionType]

  LinkedTextTypeKind* = enum
    lttRef, lttMixedStr2
  LinkedTextTypeBody* = object
    case kind*: LinkedTextTypeKind
    of lttRef:
        refTextType*: RefTextType

    of lttMixedStr2:
        mixedStr*: string

  
  LinkedTextType* = object
    xsdChoice*: seq[LinkedTextTypeBody]

  GraphType* = object
    node*: seq[NodeType]

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

  HighlightTypeKind* = enum
    htSp, htRef1, htMixedStr3
  HighlightTypeBody* = object
    case kind*: HighlightTypeKind
    of htSp:
        spType*: SpType

    of htRef1:
        refTextType*: RefTextType

    of htMixedStr3:
        mixedStr*: string

  
  HighlightType* = object
    class*: DoxHighlightClass
    xsdChoice*: seq[HighlightTypeBody]

  SpTypeKind* = enum
    stMixedStr4
  SpTypeBody* = object
    case kind*: SpTypeKind
    of stMixedStr4:
        mixedStr*: string

  
  SpType* = object
    value*: Option[int]
    xsdChoice*: seq[SpTypeBody]

  ReferenceTypeKind* = enum
    rtMixedStr5
  ReferenceTypeBody* = object
    case kind*: ReferenceTypeKind
    of rtMixedStr5:
        mixedStr*: string

  
  ReferenceType* = object
    refid*: string
    compoundref*: Option[string]
    startline*: int
    endline*: int
    xsdChoice*: seq[ReferenceTypeBody]

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

  DocSect1TypeKind* = enum
    dstTitle2, dstMixedStr6
  DocSect1TypeBody* = object
    case kind*: DocSect1TypeKind
    of dstTitle2:
        string*: string

    of dstMixedStr6:
        mixedStr*: string

  
  DocSect1Type* = object
    id*: string
    xsdChoice*: seq[DocSect1TypeBody]

  DocSect2TypeKind* = enum
    dostTitle3, dostMixedStr7
  DocSect2TypeBody* = object
    case kind*: DocSect2TypeKind
    of dostTitle3:
        string*: string

    of dostMixedStr7:
        mixedStr*: string

  
  DocSect2Type* = object
    id*: string
    xsdChoice*: seq[DocSect2TypeBody]

  DocSect3TypeKind* = enum
    docstTitle4, docstMixedStr8
  DocSect3TypeBody* = object
    case kind*: DocSect3TypeKind
    of docstTitle4:
        string*: string

    of docstMixedStr8:
        mixedStr*: string

  
  DocSect3Type* = object
    id*: string
    xsdChoice*: seq[DocSect3TypeBody]

  DocSect4TypeKind* = enum
    docsetTitle5, docsetMixedStr9
  DocSect4TypeBody* = object
    case kind*: DocSect4TypeKind
    of docsetTitle5:
        string*: string

    of docsetMixedStr9:
        mixedStr*: string

  
  DocSect4Type* = object
    id*: string
    xsdChoice*: seq[DocSect4TypeBody]

  DocInternalTypeKind* = enum
    ditPara1, ditSect11, ditMixedStr10
  DocInternalTypeBody* = object
    case kind*: DocInternalTypeKind
    of ditPara1:
        docParaType*: DocParaType

    of ditSect11:
        docSect1Type*: DocSect1Type

    of ditMixedStr10:
        mixedStr*: string

  
  DocInternalType* = object
    xsdChoice*: seq[DocInternalTypeBody]

  DocInternalS1TypeKind* = enum
    distPara2, distSect2, distMixedStr11
  DocInternalS1TypeBody* = object
    case kind*: DocInternalS1TypeKind
    of distPara2:
        docParaType*: DocParaType

    of distSect2:
        docSect2Type*: DocSect2Type

    of distMixedStr11:
        mixedStr*: string

  
  DocInternalS1Type* = object
    xsdChoice*: seq[DocInternalS1TypeBody]

  DocInternalS2TypeKind* = enum
    dis2tPara3, dis2tSect3, dis2tMixedStr12
  DocInternalS2TypeBody* = object
    case kind*: DocInternalS2TypeKind
    of dis2tPara3:
        docParaType*: DocParaType

    of dis2tSect3:
        docSect3Type*: DocSect3Type

    of dis2tMixedStr12:
        mixedStr*: string

  
  DocInternalS2Type* = object
    xsdChoice*: seq[DocInternalS2TypeBody]

  DocInternalS3TypeKind* = enum
    dis3tPara4, dis3tSect31, dis3tMixedStr13
  DocInternalS3TypeBody* = object
    case kind*: DocInternalS3TypeKind
    of dis3tPara4:
        docParaType*: DocParaType

    of dis3tSect31:
        docSect4Type*: DocSect4Type

    of dis3tMixedStr13:
        mixedStr*: string

  
  DocInternalS3Type* = object
    xsdChoice*: seq[DocInternalS3TypeBody]

  DocInternalS4TypeKind* = enum
    dis4tPara5, dis4tMixedStr14
  DocInternalS4TypeBody* = object
    case kind*: DocInternalS4TypeKind
    of dis4tPara5:
        docParaType*: DocParaType

    of dis4tMixedStr14:
        mixedStr*: string

  
  DocInternalS4Type* = object
    xsdChoice*: seq[DocInternalS4TypeBody]

  DocTitleTypeKind* = enum
    dttUlink, dttBold, dttS, dttStrike, dttUnderline, dttEmphasis,
    dttComputeroutput, dttSubscript, dttSuperscript, dttCenter, dttSmall,
    dttDel, dttIns, dttHtmlonly, dttManonly, dttXmlonly, dttRtfonly,
    dttLatexonly, dttDocbookonly, dttImage, dttDot, dttMsc, dttPlantuml,
    dttAnchor, dttFormula, dttRef2, dttEmoji, dttLinebreak,
    dttNonbreakablespace, dttIexcl, dttCent, dttPound, dttCurren, dttYen,
    dttBrvbar, dttSect, dttUmlaut, dttCopy, dttOrdf, dttLaquo, dttNot, dttShy,
    dttRegistered, dttMacr, dttDeg, dttPlusmn, dttSup2, dttSup3, dttAcute,
    dttMicro, dttPara6, dttMiddot, dttCedil, dttSup1, dttOrdm, dttRaquo,
    dttFrac14, dttFrac12, dttFrac34, dttIquest, dttAgrave, dttAacute, dttAcirc,
    dttAtilde, dttAumlaut, dttAring, dttAElig, dttCcedil, dttEgrave, dttEacute,
    dttEcirc, dttEumlaut, dttIgrave, dttIacute, dttIcirc, dttIumlaut, dttETH,
    dttNtilde, dttOgrave, dttOacute, dttOcirc, dttOtilde, dttOumlaut, dttTimes,
    dttOslash, dttUgrave, dttUacute, dttUcirc, dttUumlaut, dttYacute, dttTHORN,
    dttSzlig, dttAgrave1, dttAacute1, dttAcirc1, dttAtilde1, dttAumlaut1,
    dttAring1, dttAelig1, dttCcedil1, dttEgrave1, dttEacute1, dttEcirc1,
    dttEumlaut1, dttIgrave1, dttIacute1, dttIcirc1, dttIumlaut1, dttEth1,
    dttNtilde1, dttOgrave1, dttOacute1, dttOcirc1, dttOtilde1, dttOumlaut1,
    dttDivide, dttOslash1, dttUgrave1, dttUacute1, dttUcirc1, dttUumlaut1,
    dttYacute1, dttThorn1, dttYumlaut, dttFnof, dttAlpha, dttBeta, dttGamma,
    dttDelta, dttEpsilon, dttZeta, dttEta, dttTheta, dttIota, dttKappa,
    dttLambda, dttMu, dttNu, dttXi, dttOmicron, dttPi, dttRho, dttSigma, dttTau,
    dttUpsilon, dttPhi, dttChi, dttPsi, dttOmega, dttAlpha1, dttBeta1,
    dttGamma1, dttDelta1, dttEpsilon1, dttZeta1, dttEta1, dttTheta1, dttIota1,
    dttKappa1, dttLambda1, dttMu1, dttNu1, dttXi1, dttOmicron1, dttPi1, dttRho1,
    dttSigmaf, dttSigma1, dttTau1, dttUpsilon1, dttPhi1, dttChi1, dttPsi1,
    dttOmega1, dttThetasym, dttUpsih, dttPiv, dttBull, dttHellip, dttPrime,
    dttPrime1, dttOline, dttFrasl, dttWeierp, dttImaginary, dttReal,
    dttTrademark, dttAlefsym, dttLarr, dttUarr, dttRarr, dttDarr, dttHarr,
    dttCrarr, dttLArr1, dttUArr1, dttRArr1, dttDArr1, dttHArr1, dttForall,
    dttPart, dttExist, dttEmpty, dttNabla, dttIsin, dttNotin, dttNi, dttProd,
    dttSum, dttMinus, dttLowast, dttRadic, dttProp, dttInfin, dttAng, dttAnd,
    dttOr, dttCap, dttCup, dttInt, dttThere4, dttSim, dttCong, dttAsymp, dttNe,
    dttEquiv, dttLe, dttGe, dttSub, dttSup, dttNsub, dttSube, dttSupe, dttOplus,
    dttOtimes, dttPerp, dttSdot, dttLceil, dttRceil, dttLfloor, dttRfloor,
    dttLang, dttRang, dttLoz, dttSpades, dttClubs, dttHearts, dttDiams,
    dttOElig, dttOelig1, dttScaron, dttScaron1, dttYumlaut1, dttCirc, dttTilde,
    dttEnsp, dttEmsp, dttThinsp, dttZwnj, dttZwj, dttLrm, dttRlm, dttNdash,
    dttMdash, dttLsquo, dttRsquo, dttSbquo, dttLdquo, dttRdquo, dttBdquo,
    dttDagger, dttDagger1, dttPermil, dttLsaquo, dttRsaquo, dttEuro, dttTm,
    dttMixedStr15
  DocTitleTypeBody* = object
    case kind*: DocTitleTypeKind
    of dttUlink:
        docURLLink*: DocURLLink

    of dttBold, dttS, dttStrike, dttUnderline, dttEmphasis, dttComputeroutput,
       dttSubscript, dttSuperscript, dttCenter, dttSmall, dttDel, dttIns:
        docMarkupType*: DocMarkupType

    of dttHtmlonly:
        docHtmlOnlyType*: DocHtmlOnlyType

    of dttManonly, dttXmlonly, dttRtfonly, dttLatexonly, dttDocbookonly:
        string*: string

    of dttImage, dttDot, dttMsc, dttPlantuml:
        docImageType*: DocImageType

    of dttAnchor:
        docAnchorType*: DocAnchorType

    of dttFormula:
        docFormulaType*: DocFormulaType

    of dttRef2:
        docRefTextType*: DocRefTextType

    of dttEmoji:
        docEmojiType*: DocEmojiType

    of dttLinebreak, dttNonbreakablespace, dttIexcl, dttCent, dttPound,
       dttCurren, dttYen, dttBrvbar, dttSect, dttUmlaut, dttCopy, dttOrdf,
       dttLaquo, dttNot, dttShy, dttRegistered, dttMacr, dttDeg, dttPlusmn,
       dttSup2, dttSup3, dttAcute, dttMicro, dttPara6, dttMiddot, dttCedil,
       dttSup1, dttOrdm, dttRaquo, dttFrac14, dttFrac12, dttFrac34, dttIquest,
       dttAgrave, dttAacute, dttAcirc, dttAtilde, dttAumlaut, dttAring,
       dttAElig, dttCcedil, dttEgrave, dttEacute, dttEcirc, dttEumlaut,
       dttIgrave, dttIacute, dttIcirc, dttIumlaut, dttETH, dttNtilde, dttOgrave,
       dttOacute, dttOcirc, dttOtilde, dttOumlaut, dttTimes, dttOslash,
       dttUgrave, dttUacute, dttUcirc, dttUumlaut, dttYacute, dttTHORN,
       dttSzlig, dttAgrave1, dttAacute1, dttAcirc1, dttAtilde1, dttAumlaut1,
       dttAring1, dttAelig1, dttCcedil1, dttEgrave1, dttEacute1, dttEcirc1,
       dttEumlaut1, dttIgrave1, dttIacute1, dttIcirc1, dttIumlaut1, dttEth1,
       dttNtilde1, dttOgrave1, dttOacute1, dttOcirc1, dttOtilde1, dttOumlaut1,
       dttDivide, dttOslash1, dttUgrave1, dttUacute1, dttUcirc1, dttUumlaut1,
       dttYacute1, dttThorn1, dttYumlaut, dttFnof, dttAlpha, dttBeta, dttGamma,
       dttDelta, dttEpsilon, dttZeta, dttEta, dttTheta, dttIota, dttKappa,
       dttLambda, dttMu, dttNu, dttXi, dttOmicron, dttPi, dttRho, dttSigma,
       dttTau, dttUpsilon, dttPhi, dttChi, dttPsi, dttOmega, dttAlpha1,
       dttBeta1, dttGamma1, dttDelta1, dttEpsilon1, dttZeta1, dttEta1,
       dttTheta1, dttIota1, dttKappa1, dttLambda1, dttMu1, dttNu1, dttXi1,
       dttOmicron1, dttPi1, dttRho1, dttSigmaf, dttSigma1, dttTau1, dttUpsilon1,
       dttPhi1, dttChi1, dttPsi1, dttOmega1, dttThetasym, dttUpsih, dttPiv,
       dttBull, dttHellip, dttPrime, dttPrime1, dttOline, dttFrasl, dttWeierp,
       dttImaginary, dttReal, dttTrademark, dttAlefsym, dttLarr, dttUarr,
       dttRarr, dttDarr, dttHarr, dttCrarr, dttLArr1, dttUArr1, dttRArr1,
       dttDArr1, dttHArr1, dttForall, dttPart, dttExist, dttEmpty, dttNabla,
       dttIsin, dttNotin, dttNi, dttProd, dttSum, dttMinus, dttLowast, dttRadic,
       dttProp, dttInfin, dttAng, dttAnd, dttOr, dttCap, dttCup, dttInt,
       dttThere4, dttSim, dttCong, dttAsymp, dttNe, dttEquiv, dttLe, dttGe,
       dttSub, dttSup, dttNsub, dttSube, dttSupe, dttOplus, dttOtimes, dttPerp,
       dttSdot, dttLceil, dttRceil, dttLfloor, dttRfloor, dttLang, dttRang,
       dttLoz, dttSpades, dttClubs, dttHearts, dttDiams, dttOElig, dttOelig1,
       dttScaron, dttScaron1, dttYumlaut1, dttCirc, dttTilde, dttEnsp, dttEmsp,
       dttThinsp, dttZwnj, dttZwj, dttLrm, dttRlm, dttNdash, dttMdash, dttLsquo,
       dttRsquo, dttSbquo, dttLdquo, dttRdquo, dttBdquo, dttDagger, dttDagger1,
       dttPermil, dttLsaquo, dttRsaquo, dttEuro, dttTm:
        docEmptyType*: DocEmptyType

    of dttMixedStr15:
        mixedStr*: string

  
  DocTitleType* = object
    xsdChoice*: seq[DocTitleTypeBody]

  DocParaTypeKind* = enum
    dptHruler, dptPreformatted, dptProgramlisting1, dptVerbatim, dptIndexentry,
    dptOrderedlist, dptItemizedlist, dptSimplesect, dptTitle6, dptVariablelist,
    dptTable, dptHeading, dptDotfile, dptMscfile, dptDiafile, dptToclist,
    dptLanguage, dptParameterlist, dptXrefsect, dptCopydoc, dptBlockquote,
    dptParblock, dptMixedStr16
  DocParaTypeBody* = object
    case kind*: DocParaTypeKind
    of dptHruler:
        docEmptyType*: DocEmptyType

    of dptPreformatted:
        docMarkupType*: DocMarkupType

    of dptProgramlisting1:
        listingType*: ListingType

    of dptVerbatim:
        string*: string

    of dptIndexentry:
        docIndexEntryType*: DocIndexEntryType

    of dptOrderedlist, dptItemizedlist:
        docListType*: DocListType

    of dptSimplesect:
        docSimpleSectType*: DocSimpleSectType

    of dptTitle6:
        docTitleType*: DocTitleType

    of dptVariablelist:
        docVariableListType*: DocVariableListType

    of dptTable:
        docTableType*: DocTableType

    of dptHeading:
        docHeadingType*: DocHeadingType

    of dptDotfile, dptMscfile, dptDiafile:
        docImageType*: DocImageType

    of dptToclist:
        docTocListType*: DocTocListType

    of dptLanguage:
        docLanguageType*: DocLanguageType

    of dptParameterlist:
        docParamListType*: DocParamListType

    of dptXrefsect:
        docXRefSectType*: DocXRefSectType

    of dptCopydoc:
        docCopyType*: DocCopyType

    of dptBlockquote:
        docBlockQuoteType*: DocBlockQuoteType

    of dptParblock:
        docParBlockType*: DocParBlockType

    of dptMixedStr16:
        mixedStr*: string

  
  DocParaType* = object
    xsdChoice*: seq[DocParaTypeBody]

  DocMarkupTypeKind* = enum
    dmtHruler1, dmtPreformatted1, dmtProgramlisting2, dmtVerbatim1,
    dmtIndexentry1, dmtOrderedlist1, dmtItemizedlist1, dmtSimplesect1,
    dmtTitle7, dmtVariablelist1, dmtTable1, dmtHeading1, dmtDotfile1,
    dmtMscfile1, dmtDiafile1, dmtToclist1, dmtLanguage1, dmtParameterlist1,
    dmtXrefsect1, dmtCopydoc1, dmtBlockquote1, dmtParblock1, dmtMixedStr17
  DocMarkupTypeBody* = object
    case kind*: DocMarkupTypeKind
    of dmtHruler1:
        docEmptyType*: DocEmptyType

    of dmtPreformatted1:
        docMarkupType*: DocMarkupType

    of dmtProgramlisting2:
        listingType*: ListingType

    of dmtVerbatim1:
        string*: string

    of dmtIndexentry1:
        docIndexEntryType*: DocIndexEntryType

    of dmtOrderedlist1, dmtItemizedlist1:
        docListType*: DocListType

    of dmtSimplesect1:
        docSimpleSectType*: DocSimpleSectType

    of dmtTitle7:
        docTitleType*: DocTitleType

    of dmtVariablelist1:
        docVariableListType*: DocVariableListType

    of dmtTable1:
        docTableType*: DocTableType

    of dmtHeading1:
        docHeadingType*: DocHeadingType

    of dmtDotfile1, dmtMscfile1, dmtDiafile1:
        docImageType*: DocImageType

    of dmtToclist1:
        docTocListType*: DocTocListType

    of dmtLanguage1:
        docLanguageType*: DocLanguageType

    of dmtParameterlist1:
        docParamListType*: DocParamListType

    of dmtXrefsect1:
        docXRefSectType*: DocXRefSectType

    of dmtCopydoc1:
        docCopyType*: DocCopyType

    of dmtBlockquote1:
        docBlockQuoteType*: DocBlockQuoteType

    of dmtParblock1:
        docParBlockType*: DocParBlockType

    of dmtMixedStr17:
        mixedStr*: string

  
  DocMarkupType* = object
    xsdChoice*: seq[DocMarkupTypeBody]

  DocURLLinkKind* = enum
    dulUlink1, dulBold1, dulS1, dulStrike1, dulUnderline1, dulEmphasis1,
    dulComputeroutput1, dulSubscript1, dulSuperscript1, dulCenter1, dulSmall1,
    dulDel1, dulIns1, dulHtmlonly1, dulManonly1, dulXmlonly1, dulRtfonly1,
    dulLatexonly1, dulDocbookonly1, dulImage1, dulDot1, dulMsc1, dulPlantuml1,
    dulAnchor1, dulFormula1, dulRef3, dulEmoji1, dulLinebreak1,
    dulNonbreakablespace1, dulIexcl1, dulCent1, dulPound1, dulCurren1, dulYen1,
    dulBrvbar1, dulSect1, dulUmlaut1, dulCopy1, dulOrdf1, dulLaquo1, dulNot1,
    dulShy1, dulRegistered1, dulMacr1, dulDeg1, dulPlusmn1, dulSup21, dulSup31,
    dulAcute1, dulMicro1, dulPara7, dulMiddot1, dulCedil1, dulSup11, dulOrdm1,
    dulRaquo1, dulFrac141, dulFrac121, dulFrac341, dulIquest1, dulAgrave2,
    dulAacute2, dulAcirc2, dulAtilde2, dulAumlaut2, dulAring2, dulAElig2,
    dulCcedil2, dulEgrave2, dulEacute2, dulEcirc2, dulEumlaut2, dulIgrave2,
    dulIacute2, dulIcirc2, dulIumlaut2, dulETH2, dulNtilde2, dulOgrave2,
    dulOacute2, dulOcirc2, dulOtilde2, dulOumlaut2, dulTimes1, dulOslash2,
    dulUgrave2, dulUacute2, dulUcirc2, dulUumlaut2, dulYacute2, dulTHORN2,
    dulSzlig1, dulAgrave3, dulAacute3, dulAcirc3, dulAtilde3, dulAumlaut3,
    dulAring3, dulAelig3, dulCcedil3, dulEgrave3, dulEacute3, dulEcirc3,
    dulEumlaut3, dulIgrave3, dulIacute3, dulIcirc3, dulIumlaut3, dulEth3,
    dulNtilde3, dulOgrave3, dulOacute3, dulOcirc3, dulOtilde3, dulOumlaut3,
    dulDivide1, dulOslash3, dulUgrave3, dulUacute3, dulUcirc3, dulUumlaut3,
    dulYacute3, dulThorn3, dulYumlaut2, dulFnof1, dulAlpha2, dulBeta2,
    dulGamma2, dulDelta2, dulEpsilon2, dulZeta2, dulEta2, dulTheta2, dulIota2,
    dulKappa2, dulLambda2, dulMu2, dulNu2, dulXi2, dulOmicron2, dulPi2, dulRho2,
    dulSigma2, dulTau2, dulUpsilon2, dulPhi2, dulChi2, dulPsi2, dulOmega2,
    dulAlpha3, dulBeta3, dulGamma3, dulDelta3, dulEpsilon3, dulZeta3, dulEta3,
    dulTheta3, dulIota3, dulKappa3, dulLambda3, dulMu3, dulNu3, dulXi3,
    dulOmicron3, dulPi3, dulRho3, dulSigmaf1, dulSigma3, dulTau3, dulUpsilon3,
    dulPhi3, dulChi3, dulPsi3, dulOmega3, dulThetasym1, dulUpsih1, dulPiv1,
    dulBull1, dulHellip1, dulPrime2, dulPrime3, dulOline1, dulFrasl1,
    dulWeierp1, dulImaginary1, dulReal1, dulTrademark1, dulAlefsym1, dulLarr2,
    dulUarr2, dulRarr2, dulDarr2, dulHarr2, dulCrarr1, dulLArr3, dulUArr3,
    dulRArr3, dulDArr3, dulHArr3, dulForall1, dulPart1, dulExist1, dulEmpty1,
    dulNabla1, dulIsin1, dulNotin1, dulNi1, dulProd1, dulSum1, dulMinus1,
    dulLowast1, dulRadic1, dulProp1, dulInfin1, dulAng1, dulAnd1, dulOr1,
    dulCap1, dulCup1, dulInt1, dulThere41, dulSim1, dulCong1, dulAsymp1, dulNe1,
    dulEquiv1, dulLe1, dulGe1, dulSub1, dulSup1, dulNsub1, dulSube1, dulSupe1,
    dulOplus1, dulOtimes1, dulPerp1, dulSdot1, dulLceil1, dulRceil1, dulLfloor1,
    dulRfloor1, dulLang1, dulRang1, dulLoz1, dulSpades1, dulClubs1, dulHearts1,
    dulDiams1, dulOElig2, dulOelig3, dulScaron2, dulScaron3, dulYumlaut3,
    dulCirc1, dulTilde1, dulEnsp1, dulEmsp1, dulThinsp1, dulZwnj1, dulZwj1,
    dulLrm1, dulRlm1, dulNdash1, dulMdash1, dulLsquo1, dulRsquo1, dulSbquo1,
    dulLdquo1, dulRdquo1, dulBdquo1, dulDagger2, dulDagger3, dulPermil1,
    dulLsaquo1, dulRsaquo1, dulEuro1, dulTm1, dulMixedStr18
  DocURLLinkBody* = object
    case kind*: DocURLLinkKind
    of dulUlink1:
        docURLLink*: DocURLLink

    of dulBold1, dulS1, dulStrike1, dulUnderline1, dulEmphasis1,
       dulComputeroutput1, dulSubscript1, dulSuperscript1, dulCenter1,
       dulSmall1, dulDel1, dulIns1:
        docMarkupType*: DocMarkupType

    of dulHtmlonly1:
        docHtmlOnlyType*: DocHtmlOnlyType

    of dulManonly1, dulXmlonly1, dulRtfonly1, dulLatexonly1, dulDocbookonly1:
        string*: string

    of dulImage1, dulDot1, dulMsc1, dulPlantuml1:
        docImageType*: DocImageType

    of dulAnchor1:
        docAnchorType*: DocAnchorType

    of dulFormula1:
        docFormulaType*: DocFormulaType

    of dulRef3:
        docRefTextType*: DocRefTextType

    of dulEmoji1:
        docEmojiType*: DocEmojiType

    of dulLinebreak1, dulNonbreakablespace1, dulIexcl1, dulCent1, dulPound1,
       dulCurren1, dulYen1, dulBrvbar1, dulSect1, dulUmlaut1, dulCopy1,
       dulOrdf1, dulLaquo1, dulNot1, dulShy1, dulRegistered1, dulMacr1, dulDeg1,
       dulPlusmn1, dulSup21, dulSup31, dulAcute1, dulMicro1, dulPara7,
       dulMiddot1, dulCedil1, dulSup11, dulOrdm1, dulRaquo1, dulFrac141,
       dulFrac121, dulFrac341, dulIquest1, dulAgrave2, dulAacute2, dulAcirc2,
       dulAtilde2, dulAumlaut2, dulAring2, dulAElig2, dulCcedil2, dulEgrave2,
       dulEacute2, dulEcirc2, dulEumlaut2, dulIgrave2, dulIacute2, dulIcirc2,
       dulIumlaut2, dulETH2, dulNtilde2, dulOgrave2, dulOacute2, dulOcirc2,
       dulOtilde2, dulOumlaut2, dulTimes1, dulOslash2, dulUgrave2, dulUacute2,
       dulUcirc2, dulUumlaut2, dulYacute2, dulTHORN2, dulSzlig1, dulAgrave3,
       dulAacute3, dulAcirc3, dulAtilde3, dulAumlaut3, dulAring3, dulAelig3,
       dulCcedil3, dulEgrave3, dulEacute3, dulEcirc3, dulEumlaut3, dulIgrave3,
       dulIacute3, dulIcirc3, dulIumlaut3, dulEth3, dulNtilde3, dulOgrave3,
       dulOacute3, dulOcirc3, dulOtilde3, dulOumlaut3, dulDivide1, dulOslash3,
       dulUgrave3, dulUacute3, dulUcirc3, dulUumlaut3, dulYacute3, dulThorn3,
       dulYumlaut2, dulFnof1, dulAlpha2, dulBeta2, dulGamma2, dulDelta2,
       dulEpsilon2, dulZeta2, dulEta2, dulTheta2, dulIota2, dulKappa2,
       dulLambda2, dulMu2, dulNu2, dulXi2, dulOmicron2, dulPi2, dulRho2,
       dulSigma2, dulTau2, dulUpsilon2, dulPhi2, dulChi2, dulPsi2, dulOmega2,
       dulAlpha3, dulBeta3, dulGamma3, dulDelta3, dulEpsilon3, dulZeta3,
       dulEta3, dulTheta3, dulIota3, dulKappa3, dulLambda3, dulMu3, dulNu3,
       dulXi3, dulOmicron3, dulPi3, dulRho3, dulSigmaf1, dulSigma3, dulTau3,
       dulUpsilon3, dulPhi3, dulChi3, dulPsi3, dulOmega3, dulThetasym1,
       dulUpsih1, dulPiv1, dulBull1, dulHellip1, dulPrime2, dulPrime3,
       dulOline1, dulFrasl1, dulWeierp1, dulImaginary1, dulReal1, dulTrademark1,
       dulAlefsym1, dulLarr2, dulUarr2, dulRarr2, dulDarr2, dulHarr2, dulCrarr1,
       dulLArr3, dulUArr3, dulRArr3, dulDArr3, dulHArr3, dulForall1, dulPart1,
       dulExist1, dulEmpty1, dulNabla1, dulIsin1, dulNotin1, dulNi1, dulProd1,
       dulSum1, dulMinus1, dulLowast1, dulRadic1, dulProp1, dulInfin1, dulAng1,
       dulAnd1, dulOr1, dulCap1, dulCup1, dulInt1, dulThere41, dulSim1,
       dulCong1, dulAsymp1, dulNe1, dulEquiv1, dulLe1, dulGe1, dulSub1, dulSup1,
       dulNsub1, dulSube1, dulSupe1, dulOplus1, dulOtimes1, dulPerp1, dulSdot1,
       dulLceil1, dulRceil1, dulLfloor1, dulRfloor1, dulLang1, dulRang1,
       dulLoz1, dulSpades1, dulClubs1, dulHearts1, dulDiams1, dulOElig2,
       dulOelig3, dulScaron2, dulScaron3, dulYumlaut3, dulCirc1, dulTilde1,
       dulEnsp1, dulEmsp1, dulThinsp1, dulZwnj1, dulZwj1, dulLrm1, dulRlm1,
       dulNdash1, dulMdash1, dulLsquo1, dulRsquo1, dulSbquo1, dulLdquo1,
       dulRdquo1, dulBdquo1, dulDagger2, dulDagger3, dulPermil1, dulLsaquo1,
       dulRsaquo1, dulEuro1, dulTm1:
        docEmptyType*: DocEmptyType

    of dulMixedStr18:
        mixedStr*: string

  
  DocURLLink* = object
    url*: string
    xsdChoice*: seq[DocURLLinkBody]

  DocAnchorTypeKind* = enum
    datMixedStr19
  DocAnchorTypeBody* = object
    case kind*: DocAnchorTypeKind
    of datMixedStr19:
        mixedStr*: string

  
  DocAnchorType* = object
    id*: string
    xsdChoice*: seq[DocAnchorTypeBody]

  DocFormulaTypeKind* = enum
    dftMixedStr20
  DocFormulaTypeBody* = object
    case kind*: DocFormulaTypeKind
    of dftMixedStr20:
        mixedStr*: string

  
  DocFormulaType* = object
    id*: string
    xsdChoice*: seq[DocFormulaTypeBody]

  DocIndexEntryType* = object
    primaryie*: string
    secondaryie*: string

  DocListType* = object
    listitem*: seq[DocListItemType]

  DocListItemType* = object
    para*: seq[DocParaType]

  DocSimpleSectType* = object
    kind*: DoxSimpleSectKind
    title*: Option[DocTitleType]

  DocVarListEntryType* = object
    term*: DocTitleType

  DocVariableListType* = object
  
  DocRefTextTypeKind* = enum
    drttUlink2, drttBold2, drttS2, drttStrike2, drttUnderline2, drttEmphasis2,
    drttComputeroutput2, drttSubscript2, drttSuperscript2, drttCenter2,
    drttSmall2, drttDel2, drttIns2, drttHtmlonly2, drttManonly2, drttXmlonly2,
    drttRtfonly2, drttLatexonly2, drttDocbookonly2, drttImage2, drttDot2,
    drttMsc2, drttPlantuml2, drttAnchor2, drttFormula2, drttRef4, drttEmoji2,
    drttLinebreak2, drttNonbreakablespace2, drttIexcl2, drttCent2, drttPound2,
    drttCurren2, drttYen2, drttBrvbar2, drttSect2, drttUmlaut2, drttCopy2,
    drttOrdf2, drttLaquo2, drttNot2, drttShy2, drttRegistered2, drttMacr2,
    drttDeg2, drttPlusmn2, drttSup22, drttSup32, drttAcute2, drttMicro2,
    drttPara9, drttMiddot2, drttCedil2, drttSup12, drttOrdm2, drttRaquo2,
    drttFrac142, drttFrac122, drttFrac342, drttIquest2, drttAgrave4,
    drttAacute4, drttAcirc4, drttAtilde4, drttAumlaut4, drttAring4, drttAElig4,
    drttCcedil4, drttEgrave4, drttEacute4, drttEcirc4, drttEumlaut4,
    drttIgrave4, drttIacute4, drttIcirc4, drttIumlaut4, drttETH4, drttNtilde4,
    drttOgrave4, drttOacute4, drttOcirc4, drttOtilde4, drttOumlaut4, drttTimes2,
    drttOslash4, drttUgrave4, drttUacute4, drttUcirc4, drttUumlaut4,
    drttYacute4, drttTHORN4, drttSzlig2, drttAgrave5, drttAacute5, drttAcirc5,
    drttAtilde5, drttAumlaut5, drttAring5, drttAelig5, drttCcedil5, drttEgrave5,
    drttEacute5, drttEcirc5, drttEumlaut5, drttIgrave5, drttIacute5, drttIcirc5,
    drttIumlaut5, drttEth5, drttNtilde5, drttOgrave5, drttOacute5, drttOcirc5,
    drttOtilde5, drttOumlaut5, drttDivide2, drttOslash5, drttUgrave5,
    drttUacute5, drttUcirc5, drttUumlaut5, drttYacute5, drttThorn5,
    drttYumlaut4, drttFnof2, drttAlpha4, drttBeta4, drttGamma4, drttDelta4,
    drttEpsilon4, drttZeta4, drttEta4, drttTheta4, drttIota4, drttKappa4,
    drttLambda4, drttMu4, drttNu4, drttXi4, drttOmicron4, drttPi4, drttRho4,
    drttSigma4, drttTau4, drttUpsilon4, drttPhi4, drttChi4, drttPsi4,
    drttOmega4, drttAlpha5, drttBeta5, drttGamma5, drttDelta5, drttEpsilon5,
    drttZeta5, drttEta5, drttTheta5, drttIota5, drttKappa5, drttLambda5,
    drttMu5, drttNu5, drttXi5, drttOmicron5, drttPi5, drttRho5, drttSigmaf2,
    drttSigma5, drttTau5, drttUpsilon5, drttPhi5, drttChi5, drttPsi5,
    drttOmega5, drttThetasym2, drttUpsih2, drttPiv2, drttBull2, drttHellip2,
    drttPrime4, drttPrime5, drttOline2, drttFrasl2, drttWeierp2, drttImaginary2,
    drttReal2, drttTrademark2, drttAlefsym2, drttLarr4, drttUarr4, drttRarr4,
    drttDarr4, drttHarr4, drttCrarr2, drttLArr5, drttUArr5, drttRArr5,
    drttDArr5, drttHArr5, drttForall2, drttPart2, drttExist2, drttEmpty2,
    drttNabla2, drttIsin2, drttNotin2, drttNi2, drttProd2, drttSum2, drttMinus2,
    drttLowast2, drttRadic2, drttProp2, drttInfin2, drttAng2, drttAnd2, drttOr2,
    drttCap2, drttCup2, drttInt2, drttThere42, drttSim2, drttCong2, drttAsymp2,
    drttNe2, drttEquiv2, drttLe2, drttGe2, drttSub2, drttSup2, drttNsub2,
    drttSube2, drttSupe2, drttOplus2, drttOtimes2, drttPerp2, drttSdot2,
    drttLceil2, drttRceil2, drttLfloor2, drttRfloor2, drttLang2, drttRang2,
    drttLoz2, drttSpades2, drttClubs2, drttHearts2, drttDiams2, drttOElig4,
    drttOelig5, drttScaron4, drttScaron5, drttYumlaut5, drttCirc2, drttTilde2,
    drttEnsp2, drttEmsp2, drttThinsp2, drttZwnj2, drttZwj2, drttLrm2, drttRlm2,
    drttNdash2, drttMdash2, drttLsquo2, drttRsquo2, drttSbquo2, drttLdquo2,
    drttRdquo2, drttBdquo2, drttDagger4, drttDagger5, drttPermil2, drttLsaquo2,
    drttRsaquo2, drttEuro2, drttTm2, drttMixedStr21
  DocRefTextTypeBody* = object
    case kind*: DocRefTextTypeKind
    of drttUlink2:
        docURLLink*: DocURLLink

    of drttBold2, drttS2, drttStrike2, drttUnderline2, drttEmphasis2,
       drttComputeroutput2, drttSubscript2, drttSuperscript2, drttCenter2,
       drttSmall2, drttDel2, drttIns2:
        docMarkupType*: DocMarkupType

    of drttHtmlonly2:
        docHtmlOnlyType*: DocHtmlOnlyType

    of drttManonly2, drttXmlonly2, drttRtfonly2, drttLatexonly2,
       drttDocbookonly2:
        string*: string

    of drttImage2, drttDot2, drttMsc2, drttPlantuml2:
        docImageType*: DocImageType

    of drttAnchor2:
        docAnchorType*: DocAnchorType

    of drttFormula2:
        docFormulaType*: DocFormulaType

    of drttRef4:
        docRefTextType*: DocRefTextType

    of drttEmoji2:
        docEmojiType*: DocEmojiType

    of drttLinebreak2, drttNonbreakablespace2, drttIexcl2, drttCent2,
       drttPound2, drttCurren2, drttYen2, drttBrvbar2, drttSect2, drttUmlaut2,
       drttCopy2, drttOrdf2, drttLaquo2, drttNot2, drttShy2, drttRegistered2,
       drttMacr2, drttDeg2, drttPlusmn2, drttSup22, drttSup32, drttAcute2,
       drttMicro2, drttPara9, drttMiddot2, drttCedil2, drttSup12, drttOrdm2,
       drttRaquo2, drttFrac142, drttFrac122, drttFrac342, drttIquest2,
       drttAgrave4, drttAacute4, drttAcirc4, drttAtilde4, drttAumlaut4,
       drttAring4, drttAElig4, drttCcedil4, drttEgrave4, drttEacute4,
       drttEcirc4, drttEumlaut4, drttIgrave4, drttIacute4, drttIcirc4,
       drttIumlaut4, drttETH4, drttNtilde4, drttOgrave4, drttOacute4,
       drttOcirc4, drttOtilde4, drttOumlaut4, drttTimes2, drttOslash4,
       drttUgrave4, drttUacute4, drttUcirc4, drttUumlaut4, drttYacute4,
       drttTHORN4, drttSzlig2, drttAgrave5, drttAacute5, drttAcirc5,
       drttAtilde5, drttAumlaut5, drttAring5, drttAelig5, drttCcedil5,
       drttEgrave5, drttEacute5, drttEcirc5, drttEumlaut5, drttIgrave5,
       drttIacute5, drttIcirc5, drttIumlaut5, drttEth5, drttNtilde5,
       drttOgrave5, drttOacute5, drttOcirc5, drttOtilde5, drttOumlaut5,
       drttDivide2, drttOslash5, drttUgrave5, drttUacute5, drttUcirc5,
       drttUumlaut5, drttYacute5, drttThorn5, drttYumlaut4, drttFnof2,
       drttAlpha4, drttBeta4, drttGamma4, drttDelta4, drttEpsilon4, drttZeta4,
       drttEta4, drttTheta4, drttIota4, drttKappa4, drttLambda4, drttMu4,
       drttNu4, drttXi4, drttOmicron4, drttPi4, drttRho4, drttSigma4, drttTau4,
       drttUpsilon4, drttPhi4, drttChi4, drttPsi4, drttOmega4, drttAlpha5,
       drttBeta5, drttGamma5, drttDelta5, drttEpsilon5, drttZeta5, drttEta5,
       drttTheta5, drttIota5, drttKappa5, drttLambda5, drttMu5, drttNu5,
       drttXi5, drttOmicron5, drttPi5, drttRho5, drttSigmaf2, drttSigma5,
       drttTau5, drttUpsilon5, drttPhi5, drttChi5, drttPsi5, drttOmega5,
       drttThetasym2, drttUpsih2, drttPiv2, drttBull2, drttHellip2, drttPrime4,
       drttPrime5, drttOline2, drttFrasl2, drttWeierp2, drttImaginary2,
       drttReal2, drttTrademark2, drttAlefsym2, drttLarr4, drttUarr4, drttRarr4,
       drttDarr4, drttHarr4, drttCrarr2, drttLArr5, drttUArr5, drttRArr5,
       drttDArr5, drttHArr5, drttForall2, drttPart2, drttExist2, drttEmpty2,
       drttNabla2, drttIsin2, drttNotin2, drttNi2, drttProd2, drttSum2,
       drttMinus2, drttLowast2, drttRadic2, drttProp2, drttInfin2, drttAng2,
       drttAnd2, drttOr2, drttCap2, drttCup2, drttInt2, drttThere42, drttSim2,
       drttCong2, drttAsymp2, drttNe2, drttEquiv2, drttLe2, drttGe2, drttSub2,
       drttSup2, drttNsub2, drttSube2, drttSupe2, drttOplus2, drttOtimes2,
       drttPerp2, drttSdot2, drttLceil2, drttRceil2, drttLfloor2, drttRfloor2,
       drttLang2, drttRang2, drttLoz2, drttSpades2, drttClubs2, drttHearts2,
       drttDiams2, drttOElig4, drttOelig5, drttScaron4, drttScaron5,
       drttYumlaut5, drttCirc2, drttTilde2, drttEnsp2, drttEmsp2, drttThinsp2,
       drttZwnj2, drttZwj2, drttLrm2, drttRlm2, drttNdash2, drttMdash2,
       drttLsquo2, drttRsquo2, drttSbquo2, drttLdquo2, drttRdquo2, drttBdquo2,
       drttDagger4, drttDagger5, drttPermil2, drttLsaquo2, drttRsaquo2,
       drttEuro2, drttTm2:
        docEmptyType*: DocEmptyType

    of drttMixedStr21:
        mixedStr*: string

  
  DocRefTextType* = object
    refid*: string
    kindref*: DoxRefKind
    external*: string
    xsdChoice*: seq[DocRefTextTypeBody]

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

  DocCaptionTypeKind* = enum
    dctUlink3, dctBold3, dctS3, dctStrike3, dctUnderline3, dctEmphasis3,
    dctComputeroutput3, dctSubscript3, dctSuperscript3, dctCenter3, dctSmall3,
    dctDel3, dctIns3, dctHtmlonly3, dctManonly3, dctXmlonly3, dctRtfonly3,
    dctLatexonly3, dctDocbookonly3, dctImage3, dctDot3, dctMsc3, dctPlantuml3,
    dctAnchor3, dctFormula3, dctRef5, dctEmoji3, dctLinebreak3,
    dctNonbreakablespace3, dctIexcl3, dctCent3, dctPound3, dctCurren3, dctYen3,
    dctBrvbar3, dctSect3, dctUmlaut3, dctCopy3, dctOrdf3, dctLaquo3, dctNot3,
    dctShy3, dctRegistered3, dctMacr3, dctDeg3, dctPlusmn3, dctSup23, dctSup33,
    dctAcute3, dctMicro3, dctPara11, dctMiddot3, dctCedil3, dctSup13, dctOrdm3,
    dctRaquo3, dctFrac143, dctFrac123, dctFrac343, dctIquest3, dctAgrave6,
    dctAacute6, dctAcirc6, dctAtilde6, dctAumlaut6, dctAring6, dctAElig6,
    dctCcedil6, dctEgrave6, dctEacute6, dctEcirc6, dctEumlaut6, dctIgrave6,
    dctIacute6, dctIcirc6, dctIumlaut6, dctETH6, dctNtilde6, dctOgrave6,
    dctOacute6, dctOcirc6, dctOtilde6, dctOumlaut6, dctTimes3, dctOslash6,
    dctUgrave6, dctUacute6, dctUcirc6, dctUumlaut6, dctYacute6, dctTHORN6,
    dctSzlig3, dctAgrave7, dctAacute7, dctAcirc7, dctAtilde7, dctAumlaut7,
    dctAring7, dctAelig7, dctCcedil7, dctEgrave7, dctEacute7, dctEcirc7,
    dctEumlaut7, dctIgrave7, dctIacute7, dctIcirc7, dctIumlaut7, dctEth7,
    dctNtilde7, dctOgrave7, dctOacute7, dctOcirc7, dctOtilde7, dctOumlaut7,
    dctDivide3, dctOslash7, dctUgrave7, dctUacute7, dctUcirc7, dctUumlaut7,
    dctYacute7, dctThorn7, dctYumlaut6, dctFnof3, dctAlpha6, dctBeta6,
    dctGamma6, dctDelta6, dctEpsilon6, dctZeta6, dctEta6, dctTheta6, dctIota6,
    dctKappa6, dctLambda6, dctMu6, dctNu6, dctXi6, dctOmicron6, dctPi6, dctRho6,
    dctSigma6, dctTau6, dctUpsilon6, dctPhi6, dctChi6, dctPsi6, dctOmega6,
    dctAlpha7, dctBeta7, dctGamma7, dctDelta7, dctEpsilon7, dctZeta7, dctEta7,
    dctTheta7, dctIota7, dctKappa7, dctLambda7, dctMu7, dctNu7, dctXi7,
    dctOmicron7, dctPi7, dctRho7, dctSigmaf3, dctSigma7, dctTau7, dctUpsilon7,
    dctPhi7, dctChi7, dctPsi7, dctOmega7, dctThetasym3, dctUpsih3, dctPiv3,
    dctBull3, dctHellip3, dctPrime6, dctPrime7, dctOline3, dctFrasl3,
    dctWeierp3, dctImaginary3, dctReal3, dctTrademark3, dctAlefsym3, dctLarr6,
    dctUarr6, dctRarr6, dctDarr6, dctHarr6, dctCrarr3, dctLArr7, dctUArr7,
    dctRArr7, dctDArr7, dctHArr7, dctForall3, dctPart3, dctExist3, dctEmpty3,
    dctNabla3, dctIsin3, dctNotin3, dctNi3, dctProd3, dctSum3, dctMinus3,
    dctLowast3, dctRadic3, dctProp3, dctInfin3, dctAng3, dctAnd3, dctOr3,
    dctCap3, dctCup3, dctInt3, dctThere43, dctSim3, dctCong3, dctAsymp3, dctNe3,
    dctEquiv3, dctLe3, dctGe3, dctSub3, dctSup3, dctNsub3, dctSube3, dctSupe3,
    dctOplus3, dctOtimes3, dctPerp3, dctSdot3, dctLceil3, dctRceil3, dctLfloor3,
    dctRfloor3, dctLang3, dctRang3, dctLoz3, dctSpades3, dctClubs3, dctHearts3,
    dctDiams3, dctOElig6, dctOelig7, dctScaron6, dctScaron7, dctYumlaut7,
    dctCirc3, dctTilde3, dctEnsp3, dctEmsp3, dctThinsp3, dctZwnj3, dctZwj3,
    dctLrm3, dctRlm3, dctNdash3, dctMdash3, dctLsquo3, dctRsquo3, dctSbquo3,
    dctLdquo3, dctRdquo3, dctBdquo3, dctDagger6, dctDagger7, dctPermil3,
    dctLsaquo3, dctRsaquo3, dctEuro3, dctTm3, dctMixedStr22
  DocCaptionTypeBody* = object
    case kind*: DocCaptionTypeKind
    of dctUlink3:
        docURLLink*: DocURLLink

    of dctBold3, dctS3, dctStrike3, dctUnderline3, dctEmphasis3,
       dctComputeroutput3, dctSubscript3, dctSuperscript3, dctCenter3,
       dctSmall3, dctDel3, dctIns3:
        docMarkupType*: DocMarkupType

    of dctHtmlonly3:
        docHtmlOnlyType*: DocHtmlOnlyType

    of dctManonly3, dctXmlonly3, dctRtfonly3, dctLatexonly3, dctDocbookonly3:
        string*: string

    of dctImage3, dctDot3, dctMsc3, dctPlantuml3:
        docImageType*: DocImageType

    of dctAnchor3:
        docAnchorType*: DocAnchorType

    of dctFormula3:
        docFormulaType*: DocFormulaType

    of dctRef5:
        docRefTextType*: DocRefTextType

    of dctEmoji3:
        docEmojiType*: DocEmojiType

    of dctLinebreak3, dctNonbreakablespace3, dctIexcl3, dctCent3, dctPound3,
       dctCurren3, dctYen3, dctBrvbar3, dctSect3, dctUmlaut3, dctCopy3,
       dctOrdf3, dctLaquo3, dctNot3, dctShy3, dctRegistered3, dctMacr3, dctDeg3,
       dctPlusmn3, dctSup23, dctSup33, dctAcute3, dctMicro3, dctPara11,
       dctMiddot3, dctCedil3, dctSup13, dctOrdm3, dctRaquo3, dctFrac143,
       dctFrac123, dctFrac343, dctIquest3, dctAgrave6, dctAacute6, dctAcirc6,
       dctAtilde6, dctAumlaut6, dctAring6, dctAElig6, dctCcedil6, dctEgrave6,
       dctEacute6, dctEcirc6, dctEumlaut6, dctIgrave6, dctIacute6, dctIcirc6,
       dctIumlaut6, dctETH6, dctNtilde6, dctOgrave6, dctOacute6, dctOcirc6,
       dctOtilde6, dctOumlaut6, dctTimes3, dctOslash6, dctUgrave6, dctUacute6,
       dctUcirc6, dctUumlaut6, dctYacute6, dctTHORN6, dctSzlig3, dctAgrave7,
       dctAacute7, dctAcirc7, dctAtilde7, dctAumlaut7, dctAring7, dctAelig7,
       dctCcedil7, dctEgrave7, dctEacute7, dctEcirc7, dctEumlaut7, dctIgrave7,
       dctIacute7, dctIcirc7, dctIumlaut7, dctEth7, dctNtilde7, dctOgrave7,
       dctOacute7, dctOcirc7, dctOtilde7, dctOumlaut7, dctDivide3, dctOslash7,
       dctUgrave7, dctUacute7, dctUcirc7, dctUumlaut7, dctYacute7, dctThorn7,
       dctYumlaut6, dctFnof3, dctAlpha6, dctBeta6, dctGamma6, dctDelta6,
       dctEpsilon6, dctZeta6, dctEta6, dctTheta6, dctIota6, dctKappa6,
       dctLambda6, dctMu6, dctNu6, dctXi6, dctOmicron6, dctPi6, dctRho6,
       dctSigma6, dctTau6, dctUpsilon6, dctPhi6, dctChi6, dctPsi6, dctOmega6,
       dctAlpha7, dctBeta7, dctGamma7, dctDelta7, dctEpsilon7, dctZeta7,
       dctEta7, dctTheta7, dctIota7, dctKappa7, dctLambda7, dctMu7, dctNu7,
       dctXi7, dctOmicron7, dctPi7, dctRho7, dctSigmaf3, dctSigma7, dctTau7,
       dctUpsilon7, dctPhi7, dctChi7, dctPsi7, dctOmega7, dctThetasym3,
       dctUpsih3, dctPiv3, dctBull3, dctHellip3, dctPrime6, dctPrime7,
       dctOline3, dctFrasl3, dctWeierp3, dctImaginary3, dctReal3, dctTrademark3,
       dctAlefsym3, dctLarr6, dctUarr6, dctRarr6, dctDarr6, dctHarr6, dctCrarr3,
       dctLArr7, dctUArr7, dctRArr7, dctDArr7, dctHArr7, dctForall3, dctPart3,
       dctExist3, dctEmpty3, dctNabla3, dctIsin3, dctNotin3, dctNi3, dctProd3,
       dctSum3, dctMinus3, dctLowast3, dctRadic3, dctProp3, dctInfin3, dctAng3,
       dctAnd3, dctOr3, dctCap3, dctCup3, dctInt3, dctThere43, dctSim3,
       dctCong3, dctAsymp3, dctNe3, dctEquiv3, dctLe3, dctGe3, dctSub3, dctSup3,
       dctNsub3, dctSube3, dctSupe3, dctOplus3, dctOtimes3, dctPerp3, dctSdot3,
       dctLceil3, dctRceil3, dctLfloor3, dctRfloor3, dctLang3, dctRang3,
       dctLoz3, dctSpades3, dctClubs3, dctHearts3, dctDiams3, dctOElig6,
       dctOelig7, dctScaron6, dctScaron7, dctYumlaut7, dctCirc3, dctTilde3,
       dctEnsp3, dctEmsp3, dctThinsp3, dctZwnj3, dctZwj3, dctLrm3, dctRlm3,
       dctNdash3, dctMdash3, dctLsquo3, dctRsquo3, dctSbquo3, dctLdquo3,
       dctRdquo3, dctBdquo3, dctDagger6, dctDagger7, dctPermil3, dctLsaquo3,
       dctRsaquo3, dctEuro3, dctTm3:
        docEmptyType*: DocEmptyType

    of dctMixedStr22:
        mixedStr*: string

  
  DocCaptionType* = object
    xsdChoice*: seq[DocCaptionTypeBody]

  DocHeadingTypeKind* = enum
    dhtUlink4, dhtBold4, dhtS4, dhtStrike4, dhtUnderline4, dhtEmphasis4,
    dhtComputeroutput4, dhtSubscript4, dhtSuperscript4, dhtCenter4, dhtSmall4,
    dhtDel4, dhtIns4, dhtHtmlonly4, dhtManonly4, dhtXmlonly4, dhtRtfonly4,
    dhtLatexonly4, dhtDocbookonly4, dhtImage4, dhtDot4, dhtMsc4, dhtPlantuml4,
    dhtAnchor4, dhtFormula4, dhtRef6, dhtEmoji4, dhtLinebreak4,
    dhtNonbreakablespace4, dhtIexcl4, dhtCent4, dhtPound4, dhtCurren4, dhtYen4,
    dhtBrvbar4, dhtSect4, dhtUmlaut4, dhtCopy4, dhtOrdf4, dhtLaquo4, dhtNot4,
    dhtShy4, dhtRegistered4, dhtMacr4, dhtDeg4, dhtPlusmn4, dhtSup24, dhtSup34,
    dhtAcute4, dhtMicro4, dhtPara12, dhtMiddot4, dhtCedil4, dhtSup14, dhtOrdm4,
    dhtRaquo4, dhtFrac144, dhtFrac124, dhtFrac344, dhtIquest4, dhtAgrave8,
    dhtAacute8, dhtAcirc8, dhtAtilde8, dhtAumlaut8, dhtAring8, dhtAElig8,
    dhtCcedil8, dhtEgrave8, dhtEacute8, dhtEcirc8, dhtEumlaut8, dhtIgrave8,
    dhtIacute8, dhtIcirc8, dhtIumlaut8, dhtETH8, dhtNtilde8, dhtOgrave8,
    dhtOacute8, dhtOcirc8, dhtOtilde8, dhtOumlaut8, dhtTimes4, dhtOslash8,
    dhtUgrave8, dhtUacute8, dhtUcirc8, dhtUumlaut8, dhtYacute8, dhtTHORN8,
    dhtSzlig4, dhtAgrave9, dhtAacute9, dhtAcirc9, dhtAtilde9, dhtAumlaut9,
    dhtAring9, dhtAelig9, dhtCcedil9, dhtEgrave9, dhtEacute9, dhtEcirc9,
    dhtEumlaut9, dhtIgrave9, dhtIacute9, dhtIcirc9, dhtIumlaut9, dhtEth9,
    dhtNtilde9, dhtOgrave9, dhtOacute9, dhtOcirc9, dhtOtilde9, dhtOumlaut9,
    dhtDivide4, dhtOslash9, dhtUgrave9, dhtUacute9, dhtUcirc9, dhtUumlaut9,
    dhtYacute9, dhtThorn9, dhtYumlaut8, dhtFnof4, dhtAlpha8, dhtBeta8,
    dhtGamma8, dhtDelta8, dhtEpsilon8, dhtZeta8, dhtEta8, dhtTheta8, dhtIota8,
    dhtKappa8, dhtLambda8, dhtMu8, dhtNu8, dhtXi8, dhtOmicron8, dhtPi8, dhtRho8,
    dhtSigma8, dhtTau8, dhtUpsilon8, dhtPhi8, dhtChi8, dhtPsi8, dhtOmega8,
    dhtAlpha9, dhtBeta9, dhtGamma9, dhtDelta9, dhtEpsilon9, dhtZeta9, dhtEta9,
    dhtTheta9, dhtIota9, dhtKappa9, dhtLambda9, dhtMu9, dhtNu9, dhtXi9,
    dhtOmicron9, dhtPi9, dhtRho9, dhtSigmaf4, dhtSigma9, dhtTau9, dhtUpsilon9,
    dhtPhi9, dhtChi9, dhtPsi9, dhtOmega9, dhtThetasym4, dhtUpsih4, dhtPiv4,
    dhtBull4, dhtHellip4, dhtPrime8, dhtPrime9, dhtOline4, dhtFrasl4,
    dhtWeierp4, dhtImaginary4, dhtReal4, dhtTrademark4, dhtAlefsym4, dhtLarr8,
    dhtUarr8, dhtRarr8, dhtDarr8, dhtHarr8, dhtCrarr4, dhtLArr9, dhtUArr9,
    dhtRArr9, dhtDArr9, dhtHArr9, dhtForall4, dhtPart4, dhtExist4, dhtEmpty4,
    dhtNabla4, dhtIsin4, dhtNotin4, dhtNi4, dhtProd4, dhtSum4, dhtMinus4,
    dhtLowast4, dhtRadic4, dhtProp4, dhtInfin4, dhtAng4, dhtAnd4, dhtOr4,
    dhtCap4, dhtCup4, dhtInt4, dhtThere44, dhtSim4, dhtCong4, dhtAsymp4, dhtNe4,
    dhtEquiv4, dhtLe4, dhtGe4, dhtSub4, dhtSup4, dhtNsub4, dhtSube4, dhtSupe4,
    dhtOplus4, dhtOtimes4, dhtPerp4, dhtSdot4, dhtLceil4, dhtRceil4, dhtLfloor4,
    dhtRfloor4, dhtLang4, dhtRang4, dhtLoz4, dhtSpades4, dhtClubs4, dhtHearts4,
    dhtDiams4, dhtOElig8, dhtOelig9, dhtScaron8, dhtScaron9, dhtYumlaut9,
    dhtCirc4, dhtTilde4, dhtEnsp4, dhtEmsp4, dhtThinsp4, dhtZwnj4, dhtZwj4,
    dhtLrm4, dhtRlm4, dhtNdash4, dhtMdash4, dhtLsquo4, dhtRsquo4, dhtSbquo4,
    dhtLdquo4, dhtRdquo4, dhtBdquo4, dhtDagger8, dhtDagger9, dhtPermil4,
    dhtLsaquo4, dhtRsaquo4, dhtEuro4, dhtTm4, dhtMixedStr23
  DocHeadingTypeBody* = object
    case kind*: DocHeadingTypeKind
    of dhtUlink4:
        docURLLink*: DocURLLink

    of dhtBold4, dhtS4, dhtStrike4, dhtUnderline4, dhtEmphasis4,
       dhtComputeroutput4, dhtSubscript4, dhtSuperscript4, dhtCenter4,
       dhtSmall4, dhtDel4, dhtIns4:
        docMarkupType*: DocMarkupType

    of dhtHtmlonly4:
        docHtmlOnlyType*: DocHtmlOnlyType

    of dhtManonly4, dhtXmlonly4, dhtRtfonly4, dhtLatexonly4, dhtDocbookonly4:
        string*: string

    of dhtImage4, dhtDot4, dhtMsc4, dhtPlantuml4:
        docImageType*: DocImageType

    of dhtAnchor4:
        docAnchorType*: DocAnchorType

    of dhtFormula4:
        docFormulaType*: DocFormulaType

    of dhtRef6:
        docRefTextType*: DocRefTextType

    of dhtEmoji4:
        docEmojiType*: DocEmojiType

    of dhtLinebreak4, dhtNonbreakablespace4, dhtIexcl4, dhtCent4, dhtPound4,
       dhtCurren4, dhtYen4, dhtBrvbar4, dhtSect4, dhtUmlaut4, dhtCopy4,
       dhtOrdf4, dhtLaquo4, dhtNot4, dhtShy4, dhtRegistered4, dhtMacr4, dhtDeg4,
       dhtPlusmn4, dhtSup24, dhtSup34, dhtAcute4, dhtMicro4, dhtPara12,
       dhtMiddot4, dhtCedil4, dhtSup14, dhtOrdm4, dhtRaquo4, dhtFrac144,
       dhtFrac124, dhtFrac344, dhtIquest4, dhtAgrave8, dhtAacute8, dhtAcirc8,
       dhtAtilde8, dhtAumlaut8, dhtAring8, dhtAElig8, dhtCcedil8, dhtEgrave8,
       dhtEacute8, dhtEcirc8, dhtEumlaut8, dhtIgrave8, dhtIacute8, dhtIcirc8,
       dhtIumlaut8, dhtETH8, dhtNtilde8, dhtOgrave8, dhtOacute8, dhtOcirc8,
       dhtOtilde8, dhtOumlaut8, dhtTimes4, dhtOslash8, dhtUgrave8, dhtUacute8,
       dhtUcirc8, dhtUumlaut8, dhtYacute8, dhtTHORN8, dhtSzlig4, dhtAgrave9,
       dhtAacute9, dhtAcirc9, dhtAtilde9, dhtAumlaut9, dhtAring9, dhtAelig9,
       dhtCcedil9, dhtEgrave9, dhtEacute9, dhtEcirc9, dhtEumlaut9, dhtIgrave9,
       dhtIacute9, dhtIcirc9, dhtIumlaut9, dhtEth9, dhtNtilde9, dhtOgrave9,
       dhtOacute9, dhtOcirc9, dhtOtilde9, dhtOumlaut9, dhtDivide4, dhtOslash9,
       dhtUgrave9, dhtUacute9, dhtUcirc9, dhtUumlaut9, dhtYacute9, dhtThorn9,
       dhtYumlaut8, dhtFnof4, dhtAlpha8, dhtBeta8, dhtGamma8, dhtDelta8,
       dhtEpsilon8, dhtZeta8, dhtEta8, dhtTheta8, dhtIota8, dhtKappa8,
       dhtLambda8, dhtMu8, dhtNu8, dhtXi8, dhtOmicron8, dhtPi8, dhtRho8,
       dhtSigma8, dhtTau8, dhtUpsilon8, dhtPhi8, dhtChi8, dhtPsi8, dhtOmega8,
       dhtAlpha9, dhtBeta9, dhtGamma9, dhtDelta9, dhtEpsilon9, dhtZeta9,
       dhtEta9, dhtTheta9, dhtIota9, dhtKappa9, dhtLambda9, dhtMu9, dhtNu9,
       dhtXi9, dhtOmicron9, dhtPi9, dhtRho9, dhtSigmaf4, dhtSigma9, dhtTau9,
       dhtUpsilon9, dhtPhi9, dhtChi9, dhtPsi9, dhtOmega9, dhtThetasym4,
       dhtUpsih4, dhtPiv4, dhtBull4, dhtHellip4, dhtPrime8, dhtPrime9,
       dhtOline4, dhtFrasl4, dhtWeierp4, dhtImaginary4, dhtReal4, dhtTrademark4,
       dhtAlefsym4, dhtLarr8, dhtUarr8, dhtRarr8, dhtDarr8, dhtHarr8, dhtCrarr4,
       dhtLArr9, dhtUArr9, dhtRArr9, dhtDArr9, dhtHArr9, dhtForall4, dhtPart4,
       dhtExist4, dhtEmpty4, dhtNabla4, dhtIsin4, dhtNotin4, dhtNi4, dhtProd4,
       dhtSum4, dhtMinus4, dhtLowast4, dhtRadic4, dhtProp4, dhtInfin4, dhtAng4,
       dhtAnd4, dhtOr4, dhtCap4, dhtCup4, dhtInt4, dhtThere44, dhtSim4,
       dhtCong4, dhtAsymp4, dhtNe4, dhtEquiv4, dhtLe4, dhtGe4, dhtSub4, dhtSup4,
       dhtNsub4, dhtSube4, dhtSupe4, dhtOplus4, dhtOtimes4, dhtPerp4, dhtSdot4,
       dhtLceil4, dhtRceil4, dhtLfloor4, dhtRfloor4, dhtLang4, dhtRang4,
       dhtLoz4, dhtSpades4, dhtClubs4, dhtHearts4, dhtDiams4, dhtOElig8,
       dhtOelig9, dhtScaron8, dhtScaron9, dhtYumlaut9, dhtCirc4, dhtTilde4,
       dhtEnsp4, dhtEmsp4, dhtThinsp4, dhtZwnj4, dhtZwj4, dhtLrm4, dhtRlm4,
       dhtNdash4, dhtMdash4, dhtLsquo4, dhtRsquo4, dhtSbquo4, dhtLdquo4,
       dhtRdquo4, dhtBdquo4, dhtDagger8, dhtDagger9, dhtPermil4, dhtLsaquo4,
       dhtRsaquo4, dhtEuro4, dhtTm4:
        docEmptyType*: DocEmptyType

    of dhtMixedStr23:
        mixedStr*: string

  
  DocHeadingType* = object
    level*: int
    xsdChoice*: seq[DocHeadingTypeBody]

  DocImageTypeKind* = enum
    doitUlink5, doitBold5, doitS5, doitStrike5, doitUnderline5, doitEmphasis5,
    doitComputeroutput5, doitSubscript5, doitSuperscript5, doitCenter5,
    doitSmall5, doitDel5, doitIns5, doitHtmlonly5, doitManonly5, doitXmlonly5,
    doitRtfonly5, doitLatexonly5, doitDocbookonly5, doitImage5, doitDot5,
    doitMsc5, doitPlantuml5, doitAnchor5, doitFormula5, doitRef7, doitEmoji5,
    doitLinebreak5, doitNonbreakablespace5, doitIexcl5, doitCent5, doitPound5,
    doitCurren5, doitYen5, doitBrvbar5, doitSect5, doitUmlaut5, doitCopy5,
    doitOrdf5, doitLaquo5, doitNot5, doitShy5, doitRegistered5, doitMacr5,
    doitDeg5, doitPlusmn5, doitSup25, doitSup35, doitAcute5, doitMicro5,
    doitPara13, doitMiddot5, doitCedil5, doitSup15, doitOrdm5, doitRaquo5,
    doitFrac145, doitFrac125, doitFrac345, doitIquest5, doitAgrave10,
    doitAacute10, doitAcirc10, doitAtilde10, doitAumlaut10, doitAring10,
    doitAElig10, doitCcedil10, doitEgrave10, doitEacute10, doitEcirc10,
    doitEumlaut10, doitIgrave10, doitIacute10, doitIcirc10, doitIumlaut10,
    doitETH10, doitNtilde10, doitOgrave10, doitOacute10, doitOcirc10,
    doitOtilde10, doitOumlaut10, doitTimes5, doitOslash10, doitUgrave10,
    doitUacute10, doitUcirc10, doitUumlaut10, doitYacute10, doitTHORN10,
    doitSzlig5, doitAgrave11, doitAacute11, doitAcirc11, doitAtilde11,
    doitAumlaut11, doitAring11, doitAelig11, doitCcedil11, doitEgrave11,
    doitEacute11, doitEcirc11, doitEumlaut11, doitIgrave11, doitIacute11,
    doitIcirc11, doitIumlaut11, doitEth11, doitNtilde11, doitOgrave11,
    doitOacute11, doitOcirc11, doitOtilde11, doitOumlaut11, doitDivide5,
    doitOslash11, doitUgrave11, doitUacute11, doitUcirc11, doitUumlaut11,
    doitYacute11, doitThorn11, doitYumlaut10, doitFnof5, doitAlpha10,
    doitBeta10, doitGamma10, doitDelta10, doitEpsilon10, doitZeta10, doitEta10,
    doitTheta10, doitIota10, doitKappa10, doitLambda10, doitMu10, doitNu10,
    doitXi10, doitOmicron10, doitPi10, doitRho10, doitSigma10, doitTau10,
    doitUpsilon10, doitPhi10, doitChi10, doitPsi10, doitOmega10, doitAlpha11,
    doitBeta11, doitGamma11, doitDelta11, doitEpsilon11, doitZeta11, doitEta11,
    doitTheta11, doitIota11, doitKappa11, doitLambda11, doitMu11, doitNu11,
    doitXi11, doitOmicron11, doitPi11, doitRho11, doitSigmaf5, doitSigma11,
    doitTau11, doitUpsilon11, doitPhi11, doitChi11, doitPsi11, doitOmega11,
    doitThetasym5, doitUpsih5, doitPiv5, doitBull5, doitHellip5, doitPrime10,
    doitPrime11, doitOline5, doitFrasl5, doitWeierp5, doitImaginary5, doitReal5,
    doitTrademark5, doitAlefsym5, doitLarr10, doitUarr10, doitRarr10,
    doitDarr10, doitHarr10, doitCrarr5, doitLArr11, doitUArr11, doitRArr11,
    doitDArr11, doitHArr11, doitForall5, doitPart5, doitExist5, doitEmpty5,
    doitNabla5, doitIsin5, doitNotin5, doitNi5, doitProd5, doitSum5, doitMinus5,
    doitLowast5, doitRadic5, doitProp5, doitInfin5, doitAng5, doitAnd5, doitOr5,
    doitCap5, doitCup5, doitInt5, doitThere45, doitSim5, doitCong5, doitAsymp5,
    doitNe5, doitEquiv5, doitLe5, doitGe5, doitSub5, doitSup5, doitNsub5,
    doitSube5, doitSupe5, doitOplus5, doitOtimes5, doitPerp5, doitSdot5,
    doitLceil5, doitRceil5, doitLfloor5, doitRfloor5, doitLang5, doitRang5,
    doitLoz5, doitSpades5, doitClubs5, doitHearts5, doitDiams5, doitOElig10,
    doitOelig11, doitScaron10, doitScaron11, doitYumlaut11, doitCirc5,
    doitTilde5, doitEnsp5, doitEmsp5, doitThinsp5, doitZwnj5, doitZwj5,
    doitLrm5, doitRlm5, doitNdash5, doitMdash5, doitLsquo5, doitRsquo5,
    doitSbquo5, doitLdquo5, doitRdquo5, doitBdquo5, doitDagger10, doitDagger11,
    doitPermil5, doitLsaquo5, doitRsaquo5, doitEuro5, doitTm5, doitMixedStr24
  DocImageTypeBody* = object
    case kind*: DocImageTypeKind
    of doitUlink5:
        docURLLink*: DocURLLink

    of doitBold5, doitS5, doitStrike5, doitUnderline5, doitEmphasis5,
       doitComputeroutput5, doitSubscript5, doitSuperscript5, doitCenter5,
       doitSmall5, doitDel5, doitIns5:
        docMarkupType*: DocMarkupType

    of doitHtmlonly5:
        docHtmlOnlyType*: DocHtmlOnlyType

    of doitManonly5, doitXmlonly5, doitRtfonly5, doitLatexonly5,
       doitDocbookonly5:
        string*: string

    of doitImage5, doitDot5, doitMsc5, doitPlantuml5:
        docImageType*: DocImageType

    of doitAnchor5:
        docAnchorType*: DocAnchorType

    of doitFormula5:
        docFormulaType*: DocFormulaType

    of doitRef7:
        docRefTextType*: DocRefTextType

    of doitEmoji5:
        docEmojiType*: DocEmojiType

    of doitLinebreak5, doitNonbreakablespace5, doitIexcl5, doitCent5,
       doitPound5, doitCurren5, doitYen5, doitBrvbar5, doitSect5, doitUmlaut5,
       doitCopy5, doitOrdf5, doitLaquo5, doitNot5, doitShy5, doitRegistered5,
       doitMacr5, doitDeg5, doitPlusmn5, doitSup25, doitSup35, doitAcute5,
       doitMicro5, doitPara13, doitMiddot5, doitCedil5, doitSup15, doitOrdm5,
       doitRaquo5, doitFrac145, doitFrac125, doitFrac345, doitIquest5,
       doitAgrave10, doitAacute10, doitAcirc10, doitAtilde10, doitAumlaut10,
       doitAring10, doitAElig10, doitCcedil10, doitEgrave10, doitEacute10,
       doitEcirc10, doitEumlaut10, doitIgrave10, doitIacute10, doitIcirc10,
       doitIumlaut10, doitETH10, doitNtilde10, doitOgrave10, doitOacute10,
       doitOcirc10, doitOtilde10, doitOumlaut10, doitTimes5, doitOslash10,
       doitUgrave10, doitUacute10, doitUcirc10, doitUumlaut10, doitYacute10,
       doitTHORN10, doitSzlig5, doitAgrave11, doitAacute11, doitAcirc11,
       doitAtilde11, doitAumlaut11, doitAring11, doitAelig11, doitCcedil11,
       doitEgrave11, doitEacute11, doitEcirc11, doitEumlaut11, doitIgrave11,
       doitIacute11, doitIcirc11, doitIumlaut11, doitEth11, doitNtilde11,
       doitOgrave11, doitOacute11, doitOcirc11, doitOtilde11, doitOumlaut11,
       doitDivide5, doitOslash11, doitUgrave11, doitUacute11, doitUcirc11,
       doitUumlaut11, doitYacute11, doitThorn11, doitYumlaut10, doitFnof5,
       doitAlpha10, doitBeta10, doitGamma10, doitDelta10, doitEpsilon10,
       doitZeta10, doitEta10, doitTheta10, doitIota10, doitKappa10,
       doitLambda10, doitMu10, doitNu10, doitXi10, doitOmicron10, doitPi10,
       doitRho10, doitSigma10, doitTau10, doitUpsilon10, doitPhi10, doitChi10,
       doitPsi10, doitOmega10, doitAlpha11, doitBeta11, doitGamma11,
       doitDelta11, doitEpsilon11, doitZeta11, doitEta11, doitTheta11,
       doitIota11, doitKappa11, doitLambda11, doitMu11, doitNu11, doitXi11,
       doitOmicron11, doitPi11, doitRho11, doitSigmaf5, doitSigma11, doitTau11,
       doitUpsilon11, doitPhi11, doitChi11, doitPsi11, doitOmega11,
       doitThetasym5, doitUpsih5, doitPiv5, doitBull5, doitHellip5, doitPrime10,
       doitPrime11, doitOline5, doitFrasl5, doitWeierp5, doitImaginary5,
       doitReal5, doitTrademark5, doitAlefsym5, doitLarr10, doitUarr10,
       doitRarr10, doitDarr10, doitHarr10, doitCrarr5, doitLArr11, doitUArr11,
       doitRArr11, doitDArr11, doitHArr11, doitForall5, doitPart5, doitExist5,
       doitEmpty5, doitNabla5, doitIsin5, doitNotin5, doitNi5, doitProd5,
       doitSum5, doitMinus5, doitLowast5, doitRadic5, doitProp5, doitInfin5,
       doitAng5, doitAnd5, doitOr5, doitCap5, doitCup5, doitInt5, doitThere45,
       doitSim5, doitCong5, doitAsymp5, doitNe5, doitEquiv5, doitLe5, doitGe5,
       doitSub5, doitSup5, doitNsub5, doitSube5, doitSupe5, doitOplus5,
       doitOtimes5, doitPerp5, doitSdot5, doitLceil5, doitRceil5, doitLfloor5,
       doitRfloor5, doitLang5, doitRang5, doitLoz5, doitSpades5, doitClubs5,
       doitHearts5, doitDiams5, doitOElig10, doitOelig11, doitScaron10,
       doitScaron11, doitYumlaut11, doitCirc5, doitTilde5, doitEnsp5, doitEmsp5,
       doitThinsp5, doitZwnj5, doitZwj5, doitLrm5, doitRlm5, doitNdash5,
       doitMdash5, doitLsquo5, doitRsquo5, doitSbquo5, doitLdquo5, doitRdquo5,
       doitBdquo5, doitDagger10, doitDagger11, doitPermil5, doitLsaquo5,
       doitRsaquo5, doitEuro5, doitTm5:
        docEmptyType*: DocEmptyType

    of doitMixedStr24:
        mixedStr*: string

  
  DocImageType* = object
    fType*: Option[DoxImageKind]
    name*: Option[string]
    width*: Option[string]
    height*: Option[string]
    alt*: Option[string]
    inline*: Option[DoxBool]
    caption*: Option[string]
    xsdChoice*: seq[DocImageTypeBody]

  DocTocItemTypeKind* = enum
    dtitUlink6, dtitBold6, dtitS6, dtitStrike6, dtitUnderline6, dtitEmphasis6,
    dtitComputeroutput6, dtitSubscript6, dtitSuperscript6, dtitCenter6,
    dtitSmall6, dtitDel6, dtitIns6, dtitHtmlonly6, dtitManonly6, dtitXmlonly6,
    dtitRtfonly6, dtitLatexonly6, dtitDocbookonly6, dtitImage6, dtitDot6,
    dtitMsc6, dtitPlantuml6, dtitAnchor6, dtitFormula6, dtitRef8, dtitEmoji6,
    dtitLinebreak6, dtitNonbreakablespace6, dtitIexcl6, dtitCent6, dtitPound6,
    dtitCurren6, dtitYen6, dtitBrvbar6, dtitSect6, dtitUmlaut6, dtitCopy6,
    dtitOrdf6, dtitLaquo6, dtitNot6, dtitShy6, dtitRegistered6, dtitMacr6,
    dtitDeg6, dtitPlusmn6, dtitSup26, dtitSup36, dtitAcute6, dtitMicro6,
    dtitPara14, dtitMiddot6, dtitCedil6, dtitSup16, dtitOrdm6, dtitRaquo6,
    dtitFrac146, dtitFrac126, dtitFrac346, dtitIquest6, dtitAgrave12,
    dtitAacute12, dtitAcirc12, dtitAtilde12, dtitAumlaut12, dtitAring12,
    dtitAElig12, dtitCcedil12, dtitEgrave12, dtitEacute12, dtitEcirc12,
    dtitEumlaut12, dtitIgrave12, dtitIacute12, dtitIcirc12, dtitIumlaut12,
    dtitETH12, dtitNtilde12, dtitOgrave12, dtitOacute12, dtitOcirc12,
    dtitOtilde12, dtitOumlaut12, dtitTimes6, dtitOslash12, dtitUgrave12,
    dtitUacute12, dtitUcirc12, dtitUumlaut12, dtitYacute12, dtitTHORN12,
    dtitSzlig6, dtitAgrave13, dtitAacute13, dtitAcirc13, dtitAtilde13,
    dtitAumlaut13, dtitAring13, dtitAelig13, dtitCcedil13, dtitEgrave13,
    dtitEacute13, dtitEcirc13, dtitEumlaut13, dtitIgrave13, dtitIacute13,
    dtitIcirc13, dtitIumlaut13, dtitEth13, dtitNtilde13, dtitOgrave13,
    dtitOacute13, dtitOcirc13, dtitOtilde13, dtitOumlaut13, dtitDivide6,
    dtitOslash13, dtitUgrave13, dtitUacute13, dtitUcirc13, dtitUumlaut13,
    dtitYacute13, dtitThorn13, dtitYumlaut12, dtitFnof6, dtitAlpha12,
    dtitBeta12, dtitGamma12, dtitDelta12, dtitEpsilon12, dtitZeta12, dtitEta12,
    dtitTheta12, dtitIota12, dtitKappa12, dtitLambda12, dtitMu12, dtitNu12,
    dtitXi12, dtitOmicron12, dtitPi12, dtitRho12, dtitSigma12, dtitTau12,
    dtitUpsilon12, dtitPhi12, dtitChi12, dtitPsi12, dtitOmega12, dtitAlpha13,
    dtitBeta13, dtitGamma13, dtitDelta13, dtitEpsilon13, dtitZeta13, dtitEta13,
    dtitTheta13, dtitIota13, dtitKappa13, dtitLambda13, dtitMu13, dtitNu13,
    dtitXi13, dtitOmicron13, dtitPi13, dtitRho13, dtitSigmaf6, dtitSigma13,
    dtitTau13, dtitUpsilon13, dtitPhi13, dtitChi13, dtitPsi13, dtitOmega13,
    dtitThetasym6, dtitUpsih6, dtitPiv6, dtitBull6, dtitHellip6, dtitPrime12,
    dtitPrime13, dtitOline6, dtitFrasl6, dtitWeierp6, dtitImaginary6, dtitReal6,
    dtitTrademark6, dtitAlefsym6, dtitLarr12, dtitUarr12, dtitRarr12,
    dtitDarr12, dtitHarr12, dtitCrarr6, dtitLArr13, dtitUArr13, dtitRArr13,
    dtitDArr13, dtitHArr13, dtitForall6, dtitPart6, dtitExist6, dtitEmpty6,
    dtitNabla6, dtitIsin6, dtitNotin6, dtitNi6, dtitProd6, dtitSum6, dtitMinus6,
    dtitLowast6, dtitRadic6, dtitProp6, dtitInfin6, dtitAng6, dtitAnd6, dtitOr6,
    dtitCap6, dtitCup6, dtitInt6, dtitThere46, dtitSim6, dtitCong6, dtitAsymp6,
    dtitNe6, dtitEquiv6, dtitLe6, dtitGe6, dtitSub6, dtitSup6, dtitNsub6,
    dtitSube6, dtitSupe6, dtitOplus6, dtitOtimes6, dtitPerp6, dtitSdot6,
    dtitLceil6, dtitRceil6, dtitLfloor6, dtitRfloor6, dtitLang6, dtitRang6,
    dtitLoz6, dtitSpades6, dtitClubs6, dtitHearts6, dtitDiams6, dtitOElig12,
    dtitOelig13, dtitScaron12, dtitScaron13, dtitYumlaut13, dtitCirc6,
    dtitTilde6, dtitEnsp6, dtitEmsp6, dtitThinsp6, dtitZwnj6, dtitZwj6,
    dtitLrm6, dtitRlm6, dtitNdash6, dtitMdash6, dtitLsquo6, dtitRsquo6,
    dtitSbquo6, dtitLdquo6, dtitRdquo6, dtitBdquo6, dtitDagger12, dtitDagger13,
    dtitPermil6, dtitLsaquo6, dtitRsaquo6, dtitEuro6, dtitTm6, dtitMixedStr25
  DocTocItemTypeBody* = object
    case kind*: DocTocItemTypeKind
    of dtitUlink6:
        docURLLink*: DocURLLink

    of dtitBold6, dtitS6, dtitStrike6, dtitUnderline6, dtitEmphasis6,
       dtitComputeroutput6, dtitSubscript6, dtitSuperscript6, dtitCenter6,
       dtitSmall6, dtitDel6, dtitIns6:
        docMarkupType*: DocMarkupType

    of dtitHtmlonly6:
        docHtmlOnlyType*: DocHtmlOnlyType

    of dtitManonly6, dtitXmlonly6, dtitRtfonly6, dtitLatexonly6,
       dtitDocbookonly6:
        string*: string

    of dtitImage6, dtitDot6, dtitMsc6, dtitPlantuml6:
        docImageType*: DocImageType

    of dtitAnchor6:
        docAnchorType*: DocAnchorType

    of dtitFormula6:
        docFormulaType*: DocFormulaType

    of dtitRef8:
        docRefTextType*: DocRefTextType

    of dtitEmoji6:
        docEmojiType*: DocEmojiType

    of dtitLinebreak6, dtitNonbreakablespace6, dtitIexcl6, dtitCent6,
       dtitPound6, dtitCurren6, dtitYen6, dtitBrvbar6, dtitSect6, dtitUmlaut6,
       dtitCopy6, dtitOrdf6, dtitLaquo6, dtitNot6, dtitShy6, dtitRegistered6,
       dtitMacr6, dtitDeg6, dtitPlusmn6, dtitSup26, dtitSup36, dtitAcute6,
       dtitMicro6, dtitPara14, dtitMiddot6, dtitCedil6, dtitSup16, dtitOrdm6,
       dtitRaquo6, dtitFrac146, dtitFrac126, dtitFrac346, dtitIquest6,
       dtitAgrave12, dtitAacute12, dtitAcirc12, dtitAtilde12, dtitAumlaut12,
       dtitAring12, dtitAElig12, dtitCcedil12, dtitEgrave12, dtitEacute12,
       dtitEcirc12, dtitEumlaut12, dtitIgrave12, dtitIacute12, dtitIcirc12,
       dtitIumlaut12, dtitETH12, dtitNtilde12, dtitOgrave12, dtitOacute12,
       dtitOcirc12, dtitOtilde12, dtitOumlaut12, dtitTimes6, dtitOslash12,
       dtitUgrave12, dtitUacute12, dtitUcirc12, dtitUumlaut12, dtitYacute12,
       dtitTHORN12, dtitSzlig6, dtitAgrave13, dtitAacute13, dtitAcirc13,
       dtitAtilde13, dtitAumlaut13, dtitAring13, dtitAelig13, dtitCcedil13,
       dtitEgrave13, dtitEacute13, dtitEcirc13, dtitEumlaut13, dtitIgrave13,
       dtitIacute13, dtitIcirc13, dtitIumlaut13, dtitEth13, dtitNtilde13,
       dtitOgrave13, dtitOacute13, dtitOcirc13, dtitOtilde13, dtitOumlaut13,
       dtitDivide6, dtitOslash13, dtitUgrave13, dtitUacute13, dtitUcirc13,
       dtitUumlaut13, dtitYacute13, dtitThorn13, dtitYumlaut12, dtitFnof6,
       dtitAlpha12, dtitBeta12, dtitGamma12, dtitDelta12, dtitEpsilon12,
       dtitZeta12, dtitEta12, dtitTheta12, dtitIota12, dtitKappa12,
       dtitLambda12, dtitMu12, dtitNu12, dtitXi12, dtitOmicron12, dtitPi12,
       dtitRho12, dtitSigma12, dtitTau12, dtitUpsilon12, dtitPhi12, dtitChi12,
       dtitPsi12, dtitOmega12, dtitAlpha13, dtitBeta13, dtitGamma13,
       dtitDelta13, dtitEpsilon13, dtitZeta13, dtitEta13, dtitTheta13,
       dtitIota13, dtitKappa13, dtitLambda13, dtitMu13, dtitNu13, dtitXi13,
       dtitOmicron13, dtitPi13, dtitRho13, dtitSigmaf6, dtitSigma13, dtitTau13,
       dtitUpsilon13, dtitPhi13, dtitChi13, dtitPsi13, dtitOmega13,
       dtitThetasym6, dtitUpsih6, dtitPiv6, dtitBull6, dtitHellip6, dtitPrime12,
       dtitPrime13, dtitOline6, dtitFrasl6, dtitWeierp6, dtitImaginary6,
       dtitReal6, dtitTrademark6, dtitAlefsym6, dtitLarr12, dtitUarr12,
       dtitRarr12, dtitDarr12, dtitHarr12, dtitCrarr6, dtitLArr13, dtitUArr13,
       dtitRArr13, dtitDArr13, dtitHArr13, dtitForall6, dtitPart6, dtitExist6,
       dtitEmpty6, dtitNabla6, dtitIsin6, dtitNotin6, dtitNi6, dtitProd6,
       dtitSum6, dtitMinus6, dtitLowast6, dtitRadic6, dtitProp6, dtitInfin6,
       dtitAng6, dtitAnd6, dtitOr6, dtitCap6, dtitCup6, dtitInt6, dtitThere46,
       dtitSim6, dtitCong6, dtitAsymp6, dtitNe6, dtitEquiv6, dtitLe6, dtitGe6,
       dtitSub6, dtitSup6, dtitNsub6, dtitSube6, dtitSupe6, dtitOplus6,
       dtitOtimes6, dtitPerp6, dtitSdot6, dtitLceil6, dtitRceil6, dtitLfloor6,
       dtitRfloor6, dtitLang6, dtitRang6, dtitLoz6, dtitSpades6, dtitClubs6,
       dtitHearts6, dtitDiams6, dtitOElig12, dtitOelig13, dtitScaron12,
       dtitScaron13, dtitYumlaut13, dtitCirc6, dtitTilde6, dtitEnsp6, dtitEmsp6,
       dtitThinsp6, dtitZwnj6, dtitZwj6, dtitLrm6, dtitRlm6, dtitNdash6,
       dtitMdash6, dtitLsquo6, dtitRsquo6, dtitSbquo6, dtitLdquo6, dtitRdquo6,
       dtitBdquo6, dtitDagger12, dtitDagger13, dtitPermil6, dtitLsaquo6,
       dtitRsaquo6, dtitEuro6, dtitTm6:
        docEmptyType*: DocEmptyType

    of dtitMixedStr25:
        mixedStr*: string

  
  DocTocItemType* = object
    id*: string
    xsdChoice*: seq[DocTocItemTypeBody]

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

  DocParamTypeKind* = enum
    doptRef9, doptMixedStr26
  DocParamTypeBody* = object
    case kind*: DocParamTypeKind
    of doptRef9:
        refTextType*: RefTextType

    of doptMixedStr26:
        mixedStr*: string

  
  DocParamType* = object
    xsdChoice*: seq[DocParamTypeBody]

  DocParamNameKind* = enum
    dpnRef10, dpnMixedStr27
  DocParamNameBody* = object
    case kind*: DocParamNameKind
    of dpnRef10:
        refTextType*: RefTextType

    of dpnMixedStr27:
        mixedStr*: string

  
  DocParamName* = object
    direction*: Option[DoxParamDir]
    xsdChoice*: seq[DocParamNameBody]

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
    tocsect*: seq[TableofcontentsKindType]

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
          parseDoxVersionNumber(target.version, parser, "version")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "compounddef":
          ## 633:48:xml_to_types.nim
          parseCompounddefType(target.compounddef, parser, "compounddef", false)
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


proc parseCompounddefType*(target: var (seq[CompounddefType] | CompounddefType |
    Option[CompounddefType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
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
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "compoundname":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "compoundname")
          parseXsdString(target.compoundname, parser, "compoundname")
          skipElementEnd(parser, "compoundname")
        of "title":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "title")
          parseXsdString(target.title, parser, "title")
          skipElementEnd(parser, "title")
        of "basecompoundref":
          ## 633:48:xml_to_types.nim
          parseCompoundRefType(target.basecompoundref, parser,
                               "basecompoundref", false)
        of "derivedcompoundref":
          ## 633:48:xml_to_types.nim
          parseCompoundRefType(target.derivedcompoundref, parser,
                               "derivedcompoundref", false)
        of "includes":
          ## 633:48:xml_to_types.nim
          parseIncType(target.includes, parser, "includes", false)
        of "includedby":
          ## 633:48:xml_to_types.nim
          parseIncType(target.includedby, parser, "includedby", false)
        of "incdepgraph":
          ## 633:48:xml_to_types.nim
          parseGraphType(target.incdepgraph, parser, "incdepgraph", false)
        of "invincdepgraph":
          ## 633:48:xml_to_types.nim
          parseGraphType(target.invincdepgraph, parser, "invincdepgraph", false)
        of "innerdir":
          ## 633:48:xml_to_types.nim
          parseRefType(target.innerdir, parser, "innerdir", false)
        of "innerfile":
          ## 633:48:xml_to_types.nim
          parseRefType(target.innerfile, parser, "innerfile", false)
        of "innerclass":
          ## 633:48:xml_to_types.nim
          parseRefType(target.innerclass, parser, "innerclass", false)
        of "innernamespace":
          ## 633:48:xml_to_types.nim
          parseRefType(target.innernamespace, parser, "innernamespace", false)
        of "innerpage":
          ## 633:48:xml_to_types.nim
          parseRefType(target.innerpage, parser, "innerpage", false)
        of "innergroup":
          ## 633:48:xml_to_types.nim
          parseRefType(target.innergroup, parser, "innergroup", false)
        of "templateparamlist":
          ## 633:48:xml_to_types.nim
          parseTemplateparamlistType(target.templateparamlist, parser,
                                     "templateparamlist", false)
        of "sectiondef":
          ## 633:48:xml_to_types.nim
          parseSectiondefType(target.sectiondef, parser, "sectiondef", false)
        of "tableofcontents":
          ## 633:48:xml_to_types.nim
          parseTableofcontentsType(target.tableofcontents, parser,
                                   "tableofcontents", false)
        of "briefdescription":
          ## 633:48:xml_to_types.nim
          parseDescriptionType(target.briefdescription, parser,
                               "briefdescription", false)
        of "detaileddescription":
          ## 633:48:xml_to_types.nim
          parseDescriptionType(target.detaileddescription, parser,
                               "detaileddescription", false)
        of "inheritancegraph":
          ## 633:48:xml_to_types.nim
          parseGraphType(target.inheritancegraph, parser, "inheritancegraph",
                         false)
        of "collaborationgraph":
          ## 633:48:xml_to_types.nim
          parseGraphType(target.collaborationgraph, parser,
                         "collaborationgraph", false)
        of "programlisting":
          ## 633:48:xml_to_types.nim
          parseListingType(target.programlisting, parser, "programlisting",
                           false)
        of "location":
          ## 633:48:xml_to_types.nim
          parseLocationType(target.location, parser, "location", false)
        of "listofallmembers":
          ## 633:48:xml_to_types.nim
          parseListofallmembersType(target.listofallmembers, parser,
                                    "listofallmembers", false)
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


proc parseListofallmembersType*(target: var (seq[ListofallmembersType] |
    ListofallmembersType |
    Option[ListofallmembersType]); parser: var HXmlParser; tag: string;
                                inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "member":
          ## 633:48:xml_to_types.nim
          parseMemberRefType(target.member, parser, "member", false)
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


proc parseMemberRefType*(target: var (seq[MemberRefType] | MemberRefType |
    Option[MemberRefType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
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
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "scope":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "scope")
          parseXsdAnytype(target.scope, parser, "scope")
          skipElementEnd(parser, "scope")
        of "name":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "name")
          parseXsdAnytype(target.name, parser, "name")
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


proc parseDocHtmlOnlyType*(target: var (seq[DocHtmlOnlyType] | DocHtmlOnlyType |
    Option[DocHtmlOnlyType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "block":
          parseXsdString(target.fBlock, parser, "block")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 540:8:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        target.baseExt = tmp
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseCompoundRefType*(target: var (seq[CompoundRefType] | CompoundRefType |
    Option[CompoundRefType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
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
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 540:8:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        target.baseExt = tmp
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseReimplementType*(target: var (seq[ReimplementType] | ReimplementType |
    Option[ReimplementType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "refid":
          parseXsdString(target.refid, parser, "refid")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 540:8:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        target.baseExt = tmp
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseIncType*(target: var (seq[IncType] | IncType | Option[IncType]);
                   parser: var HXmlParser; tag: string; inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "refid":
          parseXsdString(target.refid, parser, "refid")
        of "local":
          parseDoxBool(target.local, parser, "local")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 540:8:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        target.baseExt = tmp
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseRefType*(target: var (seq[RefType] | RefType | Option[RefType]);
                   parser: var HXmlParser; tag: string; inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
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
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 540:8:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        target.baseExt = tmp
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseRefTextType*(target: var (seq[RefTextType] | RefTextType |
    Option[RefTextType]); parser: var HXmlParser; tag: string;
                       inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
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
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 540:8:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        target.baseExt = tmp
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseSectiondefType*(target: var (seq[SectiondefType] | SectiondefType |
    Option[SectiondefType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "kind":
          parseDoxSectionKind(target.kind, parser, "kind")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "header":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "header")
          parseXsdString(target.header, parser, "header")
          skipElementEnd(parser, "header")
        of "description":
          ## 633:48:xml_to_types.nim
          parseDescriptionType(target.description, parser, "description", false)
        of "memberdef":
          ## 633:48:xml_to_types.nim
          parseMemberdefType(target.memberdef, parser, "memberdef", false)
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


proc parseMemberdefType*(target: var (seq[MemberdefType] | MemberdefType |
    Option[MemberdefType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
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
          parseDoxBool(target.fStatic, parser, "static")
        of "strong":
          parseDoxBool(target.strong, parser, "strong")
        of "const":
          parseDoxBool(target.fConst, parser, "const")
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
          parseDoxBool(target.fRaise, parser, "raise")
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
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "templateparamlist":
          ## 633:48:xml_to_types.nim
          parseTemplateparamlistType(target.templateparamlist, parser,
                                     "templateparamlist", false)
        of "type":
          ## 633:48:xml_to_types.nim
          parseLinkedTextType(target.fType, parser, "type", false)
        of "definition":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "definition")
          parseXsdAnytype(target.definition, parser, "definition")
          skipElementEnd(parser, "definition")
        of "argsstring":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "argsstring")
          parseXsdAnytype(target.argsstring, parser, "argsstring")
          skipElementEnd(parser, "argsstring")
        of "name":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "name")
          parseXsdAnytype(target.name, parser, "name")
          skipElementEnd(parser, "name")
        of "read":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "read")
          parseXsdAnytype(target.read, parser, "read")
          skipElementEnd(parser, "read")
        of "write":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "write")
          parseXsdAnytype(target.write, parser, "write")
          skipElementEnd(parser, "write")
        of "bitfield":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "bitfield")
          parseXsdAnytype(target.bitfield, parser, "bitfield")
          skipElementEnd(parser, "bitfield")
        of "reimplements":
          ## 633:48:xml_to_types.nim
          parseReimplementType(target.reimplements, parser, "reimplements",
                               false)
        of "reimplementedby":
          ## 633:48:xml_to_types.nim
          parseReimplementType(target.reimplementedby, parser,
                               "reimplementedby", false)
        of "param":
          ## 633:48:xml_to_types.nim
          parseParamType(target.param, parser, "param", false)
        of "enumvalue":
          ## 633:48:xml_to_types.nim
          parseEnumvalueType(target.enumvalue, parser, "enumvalue", false)
        of "initializer":
          ## 633:48:xml_to_types.nim
          parseLinkedTextType(target.initializer, parser, "initializer", false)
        of "exceptions":
          ## 633:48:xml_to_types.nim
          parseLinkedTextType(target.exceptions, parser, "exceptions", false)
        of "briefdescription":
          ## 633:48:xml_to_types.nim
          parseDescriptionType(target.briefdescription, parser,
                               "briefdescription", false)
        of "detaileddescription":
          ## 633:48:xml_to_types.nim
          parseDescriptionType(target.detaileddescription, parser,
                               "detaileddescription", false)
        of "inbodydescription":
          ## 633:48:xml_to_types.nim
          parseDescriptionType(target.inbodydescription, parser,
                               "inbodydescription", false)
        of "location":
          ## 633:48:xml_to_types.nim
          parseLocationType(target.location, parser, "location", false)
        of "references":
          ## 633:48:xml_to_types.nim
          parseReferenceType(target.references, parser, "references", false)
        of "referencedby":
          ## 633:48:xml_to_types.nim
          parseReferenceType(target.referencedby, parser, "referencedby", false)
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


proc parseDescriptionType*(target: var (seq[DescriptionType] | DescriptionType |
    Option[DescriptionType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DescriptionTypeBody(kind: dtMixedStr, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "title":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "title":
            dtTitle1
          else:
            dtTitle1
          var tmp: string
          parseXsdString(tmp, parser, parser.elementName())
          var tmp2 = DescriptionTypeBody(kind: kind)
          tmp2.string = tmp
          add(target.xsdChoice, tmp2)
        of "para":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "para":
            dtPara
          else:
            dtPara
          var tmp: DocParaType
          parseDocParaType(tmp, parser, parser.elementName(), true)
          var tmp2 = DescriptionTypeBody(kind: kind)
          tmp2.docParaType = tmp
          add(target.xsdChoice, tmp2)
        of "internal":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "internal":
            dtInternal
          else:
            dtInternal
          var tmp: DocInternalType
          parseDocInternalType(tmp, parser, parser.elementName(), true)
          var tmp2 = DescriptionTypeBody(kind: kind)
          tmp2.docInternalType = tmp
          add(target.xsdChoice, tmp2)
        of "sect1":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "sect1":
            dtSect1
          else:
            dtSect1
          var tmp: DocSect1Type
          parseDocSect1Type(tmp, parser, parser.elementName(), true)
          var tmp2 = DescriptionTypeBody(kind: kind)
          tmp2.docSect1Type = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseEnumvalueType*(target: var (seq[EnumvalueType] | EnumvalueType |
    Option[EnumvalueType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        of "prot":
          parseDoxProtectionKind(target.prot, parser, "prot")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            EnumvalueTypeBody(kind: etMixedStr1, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "name":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "name":
            etName2
          else:
            etName2
          var tmp: XmlNode
          parseXsdAnytype(tmp, parser, parser.elementName())
          var tmp2 = EnumvalueTypeBody(kind: kind)
          tmp2.xmlNode = tmp
          add(target.xsdChoice, tmp2)
        of "initializer":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "initializer":
            etInitializer1
          else:
            etInitializer1
          var tmp: LinkedTextType
          parseLinkedTextType(tmp, parser, parser.elementName(), true)
          var tmp2 = EnumvalueTypeBody(kind: kind)
          tmp2.linkedTextType = tmp
          add(target.xsdChoice, tmp2)
        of "briefdescription", "detaileddescription":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "briefdescription":
            etBriefdescription2
          of "detaileddescription":
            etDetaileddescription2
          else:
            etBriefdescription2
          var tmp: DescriptionType
          parseDescriptionType(tmp, parser, parser.elementName(), true)
          var tmp2 = EnumvalueTypeBody(kind: kind)
          tmp2.descriptionType = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseTemplateparamlistType*(target: var (seq[TemplateparamlistType] |
    TemplateparamlistType |
    Option[TemplateparamlistType]); parser: var HXmlParser; tag: string;
                                 inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "param":
          ## 633:48:xml_to_types.nim
          parseParamType(target.param, parser, "param", false)
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


proc parseParamType*(target: var (seq[ParamType] | ParamType | Option[ParamType]);
                     parser: var HXmlParser; tag: string; inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "attributes":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "attributes")
          parseXsdAnytype(target.attributes, parser, "attributes")
          skipElementEnd(parser, "attributes")
        of "type":
          ## 633:48:xml_to_types.nim
          parseLinkedTextType(target.fType, parser, "type", false)
        of "declname":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "declname")
          parseXsdAnytype(target.declname, parser, "declname")
          skipElementEnd(parser, "declname")
        of "defname":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "defname")
          parseXsdAnytype(target.defname, parser, "defname")
          skipElementEnd(parser, "defname")
        of "array":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "array")
          parseXsdAnytype(target.array, parser, "array")
          skipElementEnd(parser, "array")
        of "defval":
          ## 633:48:xml_to_types.nim
          parseLinkedTextType(target.defval, parser, "defval", false)
        of "typeconstraint":
          ## 633:48:xml_to_types.nim
          parseLinkedTextType(target.typeconstraint, parser, "typeconstraint",
                              false)
        of "briefdescription":
          ## 633:48:xml_to_types.nim
          parseDescriptionType(target.briefdescription, parser,
                               "briefdescription", false)
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


proc parseLinkedTextType*(target: var (seq[LinkedTextType] | LinkedTextType |
    Option[LinkedTextType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            LinkedTextTypeBody(kind: lttMixedStr2, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "ref":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "ref":
            lttRef
          else:
            lttRef
          var tmp: RefTextType
          parseRefTextType(tmp, parser, parser.elementName(), true)
          var tmp2 = LinkedTextTypeBody(kind: kind)
          tmp2.refTextType = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseGraphType*(target: var (seq[GraphType] | GraphType | Option[GraphType]);
                     parser: var HXmlParser; tag: string; inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "node":
          ## 633:48:xml_to_types.nim
          parseNodeType(target.node, parser, "node", false)
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


proc parseNodeType*(target: var (seq[NodeType] | NodeType | Option[NodeType]);
                    parser: var HXmlParser; tag: string; inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "label":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "label")
          parseXsdAnytype(target.label, parser, "label")
          skipElementEnd(parser, "label")
        of "link":
          ## 633:48:xml_to_types.nim
          parseLinkType(target.link, parser, "link", false)
        of "childnode":
          ## 633:48:xml_to_types.nim
          parseChildnodeType(target.childnode, parser, "childnode", false)
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


proc parseChildnodeType*(target: var (seq[ChildnodeType] | ChildnodeType |
    Option[ChildnodeType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "refid":
          parseXsdString(target.refid, parser, "refid")
        of "relation":
          parseDoxGraphRelation(target.relation, parser, "relation")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "edgelabel":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "edgelabel")
          parseXsdAnytype(target.edgelabel, parser, "edgelabel")
          skipElementEnd(parser, "edgelabel")
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


proc parseLinkType*(target: var (seq[LinkType] | LinkType | Option[LinkType]);
                    parser: var HXmlParser; tag: string; inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "refid":
          parseXsdString(target.refid, parser, "refid")
        of "external":
          parseXsdString(target.external, parser, "external")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
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


proc parseListingType*(target: var (seq[ListingType] | ListingType |
    Option[ListingType]); parser: var HXmlParser; tag: string;
                       inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "filename":
          parseXsdString(target.filename, parser, "filename")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "codeline":
          ## 633:48:xml_to_types.nim
          parseCodelineType(target.codeline, parser, "codeline", false)
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


proc parseCodelineType*(target: var (seq[CodelineType] | CodelineType |
    Option[CodelineType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
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
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "highlight":
          ## 633:48:xml_to_types.nim
          parseHighlightType(target.highlight, parser, "highlight", false)
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


proc parseHighlightType*(target: var (seq[HighlightType] | HighlightType |
    Option[HighlightType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "class":
          parseDoxHighlightClass(target.class, parser, "class")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            HighlightTypeBody(kind: htMixedStr3, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "sp":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "sp":
            htSp
          else:
            htSp
          var tmp: SpType
          parseSpType(tmp, parser, parser.elementName(), true)
          var tmp2 = HighlightTypeBody(kind: kind)
          tmp2.spType = tmp
          add(target.xsdChoice, tmp2)
        of "ref":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "ref":
            htRef1
          else:
            htRef1
          var tmp: RefTextType
          parseRefTextType(tmp, parser, parser.elementName(), true)
          var tmp2 = HighlightTypeBody(kind: kind)
          tmp2.refTextType = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseSpType*(target: var (seq[SpType] | SpType | Option[SpType]);
                  parser: var HXmlParser; tag: string; inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "value":
          parseXsdInteger(target.value, parser, "value")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice, SpTypeBody(kind: stMixedStr4, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseReferenceType*(target: var (seq[ReferenceType] | ReferenceType |
    Option[ReferenceType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
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
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            ReferenceTypeBody(kind: rtMixedStr5, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseLocationType*(target: var (seq[LocationType] | LocationType |
    Option[LocationType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
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
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
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


proc parseDocSect1Type*(target: var (seq[DocSect1Type] | DocSect1Type |
    Option[DocSect1Type]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocSect1TypeBody(kind: dstMixedStr6, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "title":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "title":
            dstTitle2
          else:
            dstTitle2
          var tmp: string
          parseXsdString(tmp, parser, parser.elementName())
          var tmp2 = DocSect1TypeBody(kind: kind)
          tmp2.string = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocSect2Type*(target: var (seq[DocSect2Type] | DocSect2Type |
    Option[DocSect2Type]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocSect2TypeBody(kind: dostMixedStr7, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "title":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "title":
            dostTitle3
          else:
            dostTitle3
          var tmp: string
          parseXsdString(tmp, parser, parser.elementName())
          var tmp2 = DocSect2TypeBody(kind: kind)
          tmp2.string = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocSect3Type*(target: var (seq[DocSect3Type] | DocSect3Type |
    Option[DocSect3Type]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocSect3TypeBody(kind: docstMixedStr8, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "title":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "title":
            docstTitle4
          else:
            docstTitle4
          var tmp: string
          parseXsdString(tmp, parser, parser.elementName())
          var tmp2 = DocSect3TypeBody(kind: kind)
          tmp2.string = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocSect4Type*(target: var (seq[DocSect4Type] | DocSect4Type |
    Option[DocSect4Type]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocSect4TypeBody(kind: docsetMixedStr9, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "title":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "title":
            docsetTitle5
          else:
            docsetTitle5
          var tmp: string
          parseXsdString(tmp, parser, parser.elementName())
          var tmp2 = DocSect4TypeBody(kind: kind)
          tmp2.string = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocInternalType*(target: var (seq[DocInternalType] | DocInternalType |
    Option[DocInternalType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocInternalTypeBody(kind: ditMixedStr10, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "para":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "para":
            ditPara1
          else:
            ditPara1
          var tmp: DocParaType
          parseDocParaType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocInternalTypeBody(kind: kind)
          tmp2.docParaType = tmp
          add(target.xsdChoice, tmp2)
        of "sect1":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "sect1":
            ditSect11
          else:
            ditSect11
          var tmp: DocSect1Type
          parseDocSect1Type(tmp, parser, parser.elementName(), true)
          var tmp2 = DocInternalTypeBody(kind: kind)
          tmp2.docSect1Type = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocInternalS1Type*(target: var (
    seq[DocInternalS1Type] | DocInternalS1Type | Option[DocInternalS1Type]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocInternalS1TypeBody(kind: distMixedStr11, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "para":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "para":
            distPara2
          else:
            distPara2
          var tmp: DocParaType
          parseDocParaType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocInternalS1TypeBody(kind: kind)
          tmp2.docParaType = tmp
          add(target.xsdChoice, tmp2)
        of "sect2":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "sect2":
            distSect2
          else:
            distSect2
          var tmp: DocSect2Type
          parseDocSect2Type(tmp, parser, parser.elementName(), true)
          var tmp2 = DocInternalS1TypeBody(kind: kind)
          tmp2.docSect2Type = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocInternalS2Type*(target: var (
    seq[DocInternalS2Type] | DocInternalS2Type | Option[DocInternalS2Type]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocInternalS2TypeBody(kind: dis2tMixedStr12, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "para":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "para":
            dis2tPara3
          else:
            dis2tPara3
          var tmp: DocParaType
          parseDocParaType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocInternalS2TypeBody(kind: kind)
          tmp2.docParaType = tmp
          add(target.xsdChoice, tmp2)
        of "sect3":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "sect3":
            dis2tSect3
          else:
            dis2tSect3
          var tmp: DocSect3Type
          parseDocSect3Type(tmp, parser, parser.elementName(), true)
          var tmp2 = DocInternalS2TypeBody(kind: kind)
          tmp2.docSect3Type = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocInternalS3Type*(target: var (
    seq[DocInternalS3Type] | DocInternalS3Type | Option[DocInternalS3Type]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocInternalS3TypeBody(kind: dis3tMixedStr13, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "para":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "para":
            dis3tPara4
          else:
            dis3tPara4
          var tmp: DocParaType
          parseDocParaType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocInternalS3TypeBody(kind: kind)
          tmp2.docParaType = tmp
          add(target.xsdChoice, tmp2)
        of "sect3":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "sect3":
            dis3tSect31
          else:
            dis3tSect31
          var tmp: DocSect4Type
          parseDocSect4Type(tmp, parser, parser.elementName(), true)
          var tmp2 = DocInternalS3TypeBody(kind: kind)
          tmp2.docSect4Type = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocInternalS4Type*(target: var (
    seq[DocInternalS4Type] | DocInternalS4Type | Option[DocInternalS4Type]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocInternalS4TypeBody(kind: dis4tMixedStr14, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "para":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "para":
            dis4tPara5
          else:
            dis4tPara5
          var tmp: DocParaType
          parseDocParaType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocInternalS4TypeBody(kind: kind)
          tmp2.docParaType = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocTitleType*(target: var (seq[DocTitleType] | DocTitleType |
    Option[DocTitleType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocTitleTypeBody(kind: dttMixedStr15, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "ulink":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "ulink":
            dttUlink
          else:
            dttUlink
          var tmp: DocURLLink
          parseDocURLLink(tmp, parser, parser.elementName(), true)
          var tmp2 = DocTitleTypeBody(kind: kind)
          tmp2.docURLLink = tmp
          add(target.xsdChoice, tmp2)
        of "bold", "s", "strike", "underline", "emphasis", "computeroutput",
           "subscript", "superscript", "center", "small", "del", "ins":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "bold":
            dttBold
          of "s":
            dttS
          of "strike":
            dttStrike
          of "underline":
            dttUnderline
          of "emphasis":
            dttEmphasis
          of "computeroutput":
            dttComputeroutput
          of "subscript":
            dttSubscript
          of "superscript":
            dttSuperscript
          of "center":
            dttCenter
          of "small":
            dttSmall
          of "del":
            dttDel
          of "ins":
            dttIns
          else:
            dttBold
          var tmp: DocMarkupType
          parseDocMarkupType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocTitleTypeBody(kind: kind)
          tmp2.docMarkupType = tmp
          add(target.xsdChoice, tmp2)
        of "htmlonly":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "htmlonly":
            dttHtmlonly
          else:
            dttHtmlonly
          var tmp: DocHtmlOnlyType
          parseDocHtmlOnlyType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocTitleTypeBody(kind: kind)
          tmp2.docHtmlOnlyType = tmp
          add(target.xsdChoice, tmp2)
        of "manonly", "xmlonly", "rtfonly", "latexonly", "docbookonly":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "manonly":
            dttManonly
          of "xmlonly":
            dttXmlonly
          of "rtfonly":
            dttRtfonly
          of "latexonly":
            dttLatexonly
          of "docbookonly":
            dttDocbookonly
          else:
            dttManonly
          var tmp: string
          parseXsdString(tmp, parser, parser.elementName())
          var tmp2 = DocTitleTypeBody(kind: kind)
          tmp2.string = tmp
          add(target.xsdChoice, tmp2)
        of "image", "dot", "msc", "plantuml":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "image":
            dttImage
          of "dot":
            dttDot
          of "msc":
            dttMsc
          of "plantuml":
            dttPlantuml
          else:
            dttImage
          var tmp: DocImageType
          parseDocImageType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocTitleTypeBody(kind: kind)
          tmp2.docImageType = tmp
          add(target.xsdChoice, tmp2)
        of "anchor":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "anchor":
            dttAnchor
          else:
            dttAnchor
          var tmp: DocAnchorType
          parseDocAnchorType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocTitleTypeBody(kind: kind)
          tmp2.docAnchorType = tmp
          add(target.xsdChoice, tmp2)
        of "formula":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "formula":
            dttFormula
          else:
            dttFormula
          var tmp: DocFormulaType
          parseDocFormulaType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocTitleTypeBody(kind: kind)
          tmp2.docFormulaType = tmp
          add(target.xsdChoice, tmp2)
        of "ref":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "ref":
            dttRef2
          else:
            dttRef2
          var tmp: DocRefTextType
          parseDocRefTextType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocTitleTypeBody(kind: kind)
          tmp2.docRefTextType = tmp
          add(target.xsdChoice, tmp2)
        of "emoji":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "emoji":
            dttEmoji
          else:
            dttEmoji
          var tmp: DocEmojiType
          parseDocEmojiType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocTitleTypeBody(kind: kind)
          tmp2.docEmojiType = tmp
          add(target.xsdChoice, tmp2)
        of "linebreak", "nonbreakablespace", "iexcl", "cent", "pound", "curren",
           "yen", "brvbar", "sect", "umlaut", "copy", "ordf", "laquo", "not",
           "shy", "registered", "macr", "deg", "plusmn", "sup2", "sup3",
           "acute", "micro", "para", "middot", "cedil", "sup1", "ordm", "raquo",
           "frac14", "frac12", "frac34", "iquest", "Agrave", "Aacute", "Acirc",
           "Atilde", "Aumlaut", "Aring", "AElig", "Ccedil", "Egrave", "Eacute",
           "Ecirc", "Eumlaut", "Igrave", "Iacute", "Icirc", "Iumlaut", "ETH",
           "Ntilde", "Ograve", "Oacute", "Ocirc", "Otilde", "Oumlaut", "times",
           "Oslash", "Ugrave", "Uacute", "Ucirc", "Uumlaut", "Yacute", "THORN",
           "szlig", "agrave", "aacute", "acirc", "atilde", "aumlaut", "aring",
           "aelig", "ccedil", "egrave", "eacute", "ecirc", "eumlaut", "igrave",
           "iacute", "icirc", "iumlaut", "eth", "ntilde", "ograve", "oacute",
           "ocirc", "otilde", "oumlaut", "divide", "oslash", "ugrave", "uacute",
           "ucirc", "uumlaut", "yacute", "thorn", "yumlaut", "fnof", "Alpha",
           "Beta", "Gamma", "Delta", "Epsilon", "Zeta", "Eta", "Theta", "Iota",
           "Kappa", "Lambda", "Mu", "Nu", "Xi", "Omicron", "Pi", "Rho", "Sigma",
           "Tau", "Upsilon", "Phi", "Chi", "Psi", "Omega", "alpha", "beta",
           "gamma", "delta", "epsilon", "zeta", "eta", "theta", "iota", "kappa",
           "lambda", "mu", "nu", "xi", "omicron", "pi", "rho", "sigmaf",
           "sigma", "tau", "upsilon", "phi", "chi", "psi", "omega", "thetasym",
           "upsih", "piv", "bull", "hellip", "prime", "Prime", "oline", "frasl",
           "weierp", "imaginary", "real", "trademark", "alefsym", "larr",
           "uarr", "rarr", "darr", "harr", "crarr", "lArr", "uArr", "rArr",
           "dArr", "hArr", "forall", "part", "exist", "empty", "nabla", "isin",
           "notin", "ni", "prod", "sum", "minus", "lowast", "radic", "prop",
           "infin", "ang", "and", "or", "cap", "cup", "int", "there4", "sim",
           "cong", "asymp", "ne", "equiv", "le", "ge", "sub", "sup", "nsub",
           "sube", "supe", "oplus", "otimes", "perp", "sdot", "lceil", "rceil",
           "lfloor", "rfloor", "lang", "rang", "loz", "spades", "clubs",
           "hearts", "diams", "OElig", "oelig", "Scaron", "scaron", "Yumlaut",
           "circ", "tilde", "ensp", "emsp", "thinsp", "zwnj", "zwj", "lrm",
           "rlm", "ndash", "mdash", "lsquo", "rsquo", "sbquo", "ldquo", "rdquo",
           "bdquo", "dagger", "Dagger", "permil", "lsaquo", "rsaquo", "euro",
           "tm":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "linebreak":
            dttLinebreak
          of "nonbreakablespace":
            dttNonbreakablespace
          of "iexcl":
            dttIexcl
          of "cent":
            dttCent
          of "pound":
            dttPound
          of "curren":
            dttCurren
          of "yen":
            dttYen
          of "brvbar":
            dttBrvbar
          of "sect":
            dttSect
          of "umlaut":
            dttUmlaut
          of "copy":
            dttCopy
          of "ordf":
            dttOrdf
          of "laquo":
            dttLaquo
          of "not":
            dttNot
          of "shy":
            dttShy
          of "registered":
            dttRegistered
          of "macr":
            dttMacr
          of "deg":
            dttDeg
          of "plusmn":
            dttPlusmn
          of "sup2":
            dttSup2
          of "sup3":
            dttSup3
          of "acute":
            dttAcute
          of "micro":
            dttMicro
          of "para":
            dttPara6
          of "middot":
            dttMiddot
          of "cedil":
            dttCedil
          of "sup1":
            dttSup1
          of "ordm":
            dttOrdm
          of "raquo":
            dttRaquo
          of "frac14":
            dttFrac14
          of "frac12":
            dttFrac12
          of "frac34":
            dttFrac34
          of "iquest":
            dttIquest
          of "Agrave":
            dttAgrave
          of "Aacute":
            dttAacute
          of "Acirc":
            dttAcirc
          of "Atilde":
            dttAtilde
          of "Aumlaut":
            dttAumlaut
          of "Aring":
            dttAring
          of "AElig":
            dttAElig
          of "Ccedil":
            dttCcedil
          of "Egrave":
            dttEgrave
          of "Eacute":
            dttEacute
          of "Ecirc":
            dttEcirc
          of "Eumlaut":
            dttEumlaut
          of "Igrave":
            dttIgrave
          of "Iacute":
            dttIacute
          of "Icirc":
            dttIcirc
          of "Iumlaut":
            dttIumlaut
          of "ETH":
            dttETH
          of "Ntilde":
            dttNtilde
          of "Ograve":
            dttOgrave
          of "Oacute":
            dttOacute
          of "Ocirc":
            dttOcirc
          of "Otilde":
            dttOtilde
          of "Oumlaut":
            dttOumlaut
          of "times":
            dttTimes
          of "Oslash":
            dttOslash
          of "Ugrave":
            dttUgrave
          of "Uacute":
            dttUacute
          of "Ucirc":
            dttUcirc
          of "Uumlaut":
            dttUumlaut
          of "Yacute":
            dttYacute
          of "THORN":
            dttTHORN
          of "szlig":
            dttSzlig
          of "agrave":
            dttAgrave1
          of "aacute":
            dttAacute1
          of "acirc":
            dttAcirc1
          of "atilde":
            dttAtilde1
          of "aumlaut":
            dttAumlaut1
          of "aring":
            dttAring1
          of "aelig":
            dttAelig1
          of "ccedil":
            dttCcedil1
          of "egrave":
            dttEgrave1
          of "eacute":
            dttEacute1
          of "ecirc":
            dttEcirc1
          of "eumlaut":
            dttEumlaut1
          of "igrave":
            dttIgrave1
          of "iacute":
            dttIacute1
          of "icirc":
            dttIcirc1
          of "iumlaut":
            dttIumlaut1
          of "eth":
            dttEth1
          of "ntilde":
            dttNtilde1
          of "ograve":
            dttOgrave1
          of "oacute":
            dttOacute1
          of "ocirc":
            dttOcirc1
          of "otilde":
            dttOtilde1
          of "oumlaut":
            dttOumlaut1
          of "divide":
            dttDivide
          of "oslash":
            dttOslash1
          of "ugrave":
            dttUgrave1
          of "uacute":
            dttUacute1
          of "ucirc":
            dttUcirc1
          of "uumlaut":
            dttUumlaut1
          of "yacute":
            dttYacute1
          of "thorn":
            dttThorn1
          of "yumlaut":
            dttYumlaut
          of "fnof":
            dttFnof
          of "Alpha":
            dttAlpha
          of "Beta":
            dttBeta
          of "Gamma":
            dttGamma
          of "Delta":
            dttDelta
          of "Epsilon":
            dttEpsilon
          of "Zeta":
            dttZeta
          of "Eta":
            dttEta
          of "Theta":
            dttTheta
          of "Iota":
            dttIota
          of "Kappa":
            dttKappa
          of "Lambda":
            dttLambda
          of "Mu":
            dttMu
          of "Nu":
            dttNu
          of "Xi":
            dttXi
          of "Omicron":
            dttOmicron
          of "Pi":
            dttPi
          of "Rho":
            dttRho
          of "Sigma":
            dttSigma
          of "Tau":
            dttTau
          of "Upsilon":
            dttUpsilon
          of "Phi":
            dttPhi
          of "Chi":
            dttChi
          of "Psi":
            dttPsi
          of "Omega":
            dttOmega
          of "alpha":
            dttAlpha1
          of "beta":
            dttBeta1
          of "gamma":
            dttGamma1
          of "delta":
            dttDelta1
          of "epsilon":
            dttEpsilon1
          of "zeta":
            dttZeta1
          of "eta":
            dttEta1
          of "theta":
            dttTheta1
          of "iota":
            dttIota1
          of "kappa":
            dttKappa1
          of "lambda":
            dttLambda1
          of "mu":
            dttMu1
          of "nu":
            dttNu1
          of "xi":
            dttXi1
          of "omicron":
            dttOmicron1
          of "pi":
            dttPi1
          of "rho":
            dttRho1
          of "sigmaf":
            dttSigmaf
          of "sigma":
            dttSigma1
          of "tau":
            dttTau1
          of "upsilon":
            dttUpsilon1
          of "phi":
            dttPhi1
          of "chi":
            dttChi1
          of "psi":
            dttPsi1
          of "omega":
            dttOmega1
          of "thetasym":
            dttThetasym
          of "upsih":
            dttUpsih
          of "piv":
            dttPiv
          of "bull":
            dttBull
          of "hellip":
            dttHellip
          of "prime":
            dttPrime
          of "Prime":
            dttPrime1
          of "oline":
            dttOline
          of "frasl":
            dttFrasl
          of "weierp":
            dttWeierp
          of "imaginary":
            dttImaginary
          of "real":
            dttReal
          of "trademark":
            dttTrademark
          of "alefsym":
            dttAlefsym
          of "larr":
            dttLarr
          of "uarr":
            dttUarr
          of "rarr":
            dttRarr
          of "darr":
            dttDarr
          of "harr":
            dttHarr
          of "crarr":
            dttCrarr
          of "lArr":
            dttLArr1
          of "uArr":
            dttUArr1
          of "rArr":
            dttRArr1
          of "dArr":
            dttDArr1
          of "hArr":
            dttHArr1
          of "forall":
            dttForall
          of "part":
            dttPart
          of "exist":
            dttExist
          of "empty":
            dttEmpty
          of "nabla":
            dttNabla
          of "isin":
            dttIsin
          of "notin":
            dttNotin
          of "ni":
            dttNi
          of "prod":
            dttProd
          of "sum":
            dttSum
          of "minus":
            dttMinus
          of "lowast":
            dttLowast
          of "radic":
            dttRadic
          of "prop":
            dttProp
          of "infin":
            dttInfin
          of "ang":
            dttAng
          of "and":
            dttAnd
          of "or":
            dttOr
          of "cap":
            dttCap
          of "cup":
            dttCup
          of "int":
            dttInt
          of "there4":
            dttThere4
          of "sim":
            dttSim
          of "cong":
            dttCong
          of "asymp":
            dttAsymp
          of "ne":
            dttNe
          of "equiv":
            dttEquiv
          of "le":
            dttLe
          of "ge":
            dttGe
          of "sub":
            dttSub
          of "sup":
            dttSup
          of "nsub":
            dttNsub
          of "sube":
            dttSube
          of "supe":
            dttSupe
          of "oplus":
            dttOplus
          of "otimes":
            dttOtimes
          of "perp":
            dttPerp
          of "sdot":
            dttSdot
          of "lceil":
            dttLceil
          of "rceil":
            dttRceil
          of "lfloor":
            dttLfloor
          of "rfloor":
            dttRfloor
          of "lang":
            dttLang
          of "rang":
            dttRang
          of "loz":
            dttLoz
          of "spades":
            dttSpades
          of "clubs":
            dttClubs
          of "hearts":
            dttHearts
          of "diams":
            dttDiams
          of "OElig":
            dttOElig
          of "oelig":
            dttOelig1
          of "Scaron":
            dttScaron
          of "scaron":
            dttScaron1
          of "Yumlaut":
            dttYumlaut1
          of "circ":
            dttCirc
          of "tilde":
            dttTilde
          of "ensp":
            dttEnsp
          of "emsp":
            dttEmsp
          of "thinsp":
            dttThinsp
          of "zwnj":
            dttZwnj
          of "zwj":
            dttZwj
          of "lrm":
            dttLrm
          of "rlm":
            dttRlm
          of "ndash":
            dttNdash
          of "mdash":
            dttMdash
          of "lsquo":
            dttLsquo
          of "rsquo":
            dttRsquo
          of "sbquo":
            dttSbquo
          of "ldquo":
            dttLdquo
          of "rdquo":
            dttRdquo
          of "bdquo":
            dttBdquo
          of "dagger":
            dttDagger
          of "Dagger":
            dttDagger1
          of "permil":
            dttPermil
          of "lsaquo":
            dttLsaquo
          of "rsaquo":
            dttRsaquo
          of "euro":
            dttEuro
          of "tm":
            dttTm
          else:
            dttLinebreak
          var tmp: DocEmptyType
          parseDocEmptyType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocTitleTypeBody(kind: kind)
          tmp2.docEmptyType = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocParaType*(target: var (seq[DocParaType] | DocParaType |
    Option[DocParaType]); parser: var HXmlParser; tag: string;
                       inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocParaTypeBody(kind: dptMixedStr16, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "hruler":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "hruler":
            dptHruler
          else:
            dptHruler
          var tmp: DocEmptyType
          parseDocEmptyType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocParaTypeBody(kind: kind)
          tmp2.docEmptyType = tmp
          add(target.xsdChoice, tmp2)
        of "preformatted":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "preformatted":
            dptPreformatted
          else:
            dptPreformatted
          var tmp: DocMarkupType
          parseDocMarkupType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocParaTypeBody(kind: kind)
          tmp2.docMarkupType = tmp
          add(target.xsdChoice, tmp2)
        of "programlisting":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "programlisting":
            dptProgramlisting1
          else:
            dptProgramlisting1
          var tmp: ListingType
          parseListingType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocParaTypeBody(kind: kind)
          tmp2.listingType = tmp
          add(target.xsdChoice, tmp2)
        of "verbatim":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "verbatim":
            dptVerbatim
          else:
            dptVerbatim
          var tmp: string
          parseXsdString(tmp, parser, parser.elementName())
          var tmp2 = DocParaTypeBody(kind: kind)
          tmp2.string = tmp
          add(target.xsdChoice, tmp2)
        of "indexentry":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "indexentry":
            dptIndexentry
          else:
            dptIndexentry
          var tmp: DocIndexEntryType
          parseDocIndexEntryType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocParaTypeBody(kind: kind)
          tmp2.docIndexEntryType = tmp
          add(target.xsdChoice, tmp2)
        of "orderedlist", "itemizedlist":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "orderedlist":
            dptOrderedlist
          of "itemizedlist":
            dptItemizedlist
          else:
            dptOrderedlist
          var tmp: DocListType
          parseDocListType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocParaTypeBody(kind: kind)
          tmp2.docListType = tmp
          add(target.xsdChoice, tmp2)
        of "simplesect":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "simplesect":
            dptSimplesect
          else:
            dptSimplesect
          var tmp: DocSimpleSectType
          parseDocSimpleSectType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocParaTypeBody(kind: kind)
          tmp2.docSimpleSectType = tmp
          add(target.xsdChoice, tmp2)
        of "title":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "title":
            dptTitle6
          else:
            dptTitle6
          var tmp: DocTitleType
          parseDocTitleType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocParaTypeBody(kind: kind)
          tmp2.docTitleType = tmp
          add(target.xsdChoice, tmp2)
        of "variablelist":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "variablelist":
            dptVariablelist
          else:
            dptVariablelist
          var tmp: DocVariableListType
          parseDocVariableListType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocParaTypeBody(kind: kind)
          tmp2.docVariableListType = tmp
          add(target.xsdChoice, tmp2)
        of "table":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "table":
            dptTable
          else:
            dptTable
          var tmp: DocTableType
          parseDocTableType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocParaTypeBody(kind: kind)
          tmp2.docTableType = tmp
          add(target.xsdChoice, tmp2)
        of "heading":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "heading":
            dptHeading
          else:
            dptHeading
          var tmp: DocHeadingType
          parseDocHeadingType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocParaTypeBody(kind: kind)
          tmp2.docHeadingType = tmp
          add(target.xsdChoice, tmp2)
        of "dotfile", "mscfile", "diafile":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "dotfile":
            dptDotfile
          of "mscfile":
            dptMscfile
          of "diafile":
            dptDiafile
          else:
            dptDotfile
          var tmp: DocImageType
          parseDocImageType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocParaTypeBody(kind: kind)
          tmp2.docImageType = tmp
          add(target.xsdChoice, tmp2)
        of "toclist":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "toclist":
            dptToclist
          else:
            dptToclist
          var tmp: DocTocListType
          parseDocTocListType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocParaTypeBody(kind: kind)
          tmp2.docTocListType = tmp
          add(target.xsdChoice, tmp2)
        of "language":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "language":
            dptLanguage
          else:
            dptLanguage
          var tmp: DocLanguageType
          parseDocLanguageType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocParaTypeBody(kind: kind)
          tmp2.docLanguageType = tmp
          add(target.xsdChoice, tmp2)
        of "parameterlist":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "parameterlist":
            dptParameterlist
          else:
            dptParameterlist
          var tmp: DocParamListType
          parseDocParamListType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocParaTypeBody(kind: kind)
          tmp2.docParamListType = tmp
          add(target.xsdChoice, tmp2)
        of "xrefsect":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "xrefsect":
            dptXrefsect
          else:
            dptXrefsect
          var tmp: DocXRefSectType
          parseDocXRefSectType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocParaTypeBody(kind: kind)
          tmp2.docXRefSectType = tmp
          add(target.xsdChoice, tmp2)
        of "copydoc":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "copydoc":
            dptCopydoc
          else:
            dptCopydoc
          var tmp: DocCopyType
          parseDocCopyType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocParaTypeBody(kind: kind)
          tmp2.docCopyType = tmp
          add(target.xsdChoice, tmp2)
        of "blockquote":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "blockquote":
            dptBlockquote
          else:
            dptBlockquote
          var tmp: DocBlockQuoteType
          parseDocBlockQuoteType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocParaTypeBody(kind: kind)
          tmp2.docBlockQuoteType = tmp
          add(target.xsdChoice, tmp2)
        of "parblock":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "parblock":
            dptParblock
          else:
            dptParblock
          var tmp: DocParBlockType
          parseDocParBlockType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocParaTypeBody(kind: kind)
          tmp2.docParBlockType = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocMarkupType*(target: var (seq[DocMarkupType] | DocMarkupType |
    Option[DocMarkupType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocMarkupTypeBody(kind: dmtMixedStr17, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "hruler":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "hruler":
            dmtHruler1
          else:
            dmtHruler1
          var tmp: DocEmptyType
          parseDocEmptyType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocMarkupTypeBody(kind: kind)
          tmp2.docEmptyType = tmp
          add(target.xsdChoice, tmp2)
        of "preformatted":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "preformatted":
            dmtPreformatted1
          else:
            dmtPreformatted1
          var tmp: DocMarkupType
          parseDocMarkupType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocMarkupTypeBody(kind: kind)
          tmp2.docMarkupType = tmp
          add(target.xsdChoice, tmp2)
        of "programlisting":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "programlisting":
            dmtProgramlisting2
          else:
            dmtProgramlisting2
          var tmp: ListingType
          parseListingType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocMarkupTypeBody(kind: kind)
          tmp2.listingType = tmp
          add(target.xsdChoice, tmp2)
        of "verbatim":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "verbatim":
            dmtVerbatim1
          else:
            dmtVerbatim1
          var tmp: string
          parseXsdString(tmp, parser, parser.elementName())
          var tmp2 = DocMarkupTypeBody(kind: kind)
          tmp2.string = tmp
          add(target.xsdChoice, tmp2)
        of "indexentry":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "indexentry":
            dmtIndexentry1
          else:
            dmtIndexentry1
          var tmp: DocIndexEntryType
          parseDocIndexEntryType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocMarkupTypeBody(kind: kind)
          tmp2.docIndexEntryType = tmp
          add(target.xsdChoice, tmp2)
        of "orderedlist", "itemizedlist":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "orderedlist":
            dmtOrderedlist1
          of "itemizedlist":
            dmtItemizedlist1
          else:
            dmtOrderedlist1
          var tmp: DocListType
          parseDocListType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocMarkupTypeBody(kind: kind)
          tmp2.docListType = tmp
          add(target.xsdChoice, tmp2)
        of "simplesect":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "simplesect":
            dmtSimplesect1
          else:
            dmtSimplesect1
          var tmp: DocSimpleSectType
          parseDocSimpleSectType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocMarkupTypeBody(kind: kind)
          tmp2.docSimpleSectType = tmp
          add(target.xsdChoice, tmp2)
        of "title":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "title":
            dmtTitle7
          else:
            dmtTitle7
          var tmp: DocTitleType
          parseDocTitleType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocMarkupTypeBody(kind: kind)
          tmp2.docTitleType = tmp
          add(target.xsdChoice, tmp2)
        of "variablelist":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "variablelist":
            dmtVariablelist1
          else:
            dmtVariablelist1
          var tmp: DocVariableListType
          parseDocVariableListType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocMarkupTypeBody(kind: kind)
          tmp2.docVariableListType = tmp
          add(target.xsdChoice, tmp2)
        of "table":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "table":
            dmtTable1
          else:
            dmtTable1
          var tmp: DocTableType
          parseDocTableType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocMarkupTypeBody(kind: kind)
          tmp2.docTableType = tmp
          add(target.xsdChoice, tmp2)
        of "heading":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "heading":
            dmtHeading1
          else:
            dmtHeading1
          var tmp: DocHeadingType
          parseDocHeadingType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocMarkupTypeBody(kind: kind)
          tmp2.docHeadingType = tmp
          add(target.xsdChoice, tmp2)
        of "dotfile", "mscfile", "diafile":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "dotfile":
            dmtDotfile1
          of "mscfile":
            dmtMscfile1
          of "diafile":
            dmtDiafile1
          else:
            dmtDotfile1
          var tmp: DocImageType
          parseDocImageType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocMarkupTypeBody(kind: kind)
          tmp2.docImageType = tmp
          add(target.xsdChoice, tmp2)
        of "toclist":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "toclist":
            dmtToclist1
          else:
            dmtToclist1
          var tmp: DocTocListType
          parseDocTocListType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocMarkupTypeBody(kind: kind)
          tmp2.docTocListType = tmp
          add(target.xsdChoice, tmp2)
        of "language":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "language":
            dmtLanguage1
          else:
            dmtLanguage1
          var tmp: DocLanguageType
          parseDocLanguageType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocMarkupTypeBody(kind: kind)
          tmp2.docLanguageType = tmp
          add(target.xsdChoice, tmp2)
        of "parameterlist":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "parameterlist":
            dmtParameterlist1
          else:
            dmtParameterlist1
          var tmp: DocParamListType
          parseDocParamListType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocMarkupTypeBody(kind: kind)
          tmp2.docParamListType = tmp
          add(target.xsdChoice, tmp2)
        of "xrefsect":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "xrefsect":
            dmtXrefsect1
          else:
            dmtXrefsect1
          var tmp: DocXRefSectType
          parseDocXRefSectType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocMarkupTypeBody(kind: kind)
          tmp2.docXRefSectType = tmp
          add(target.xsdChoice, tmp2)
        of "copydoc":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "copydoc":
            dmtCopydoc1
          else:
            dmtCopydoc1
          var tmp: DocCopyType
          parseDocCopyType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocMarkupTypeBody(kind: kind)
          tmp2.docCopyType = tmp
          add(target.xsdChoice, tmp2)
        of "blockquote":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "blockquote":
            dmtBlockquote1
          else:
            dmtBlockquote1
          var tmp: DocBlockQuoteType
          parseDocBlockQuoteType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocMarkupTypeBody(kind: kind)
          tmp2.docBlockQuoteType = tmp
          add(target.xsdChoice, tmp2)
        of "parblock":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "parblock":
            dmtParblock1
          else:
            dmtParblock1
          var tmp: DocParBlockType
          parseDocParBlockType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocMarkupTypeBody(kind: kind)
          tmp2.docParBlockType = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocURLLink*(target: var (seq[DocURLLink] | DocURLLink |
    Option[DocURLLink]); parser: var HXmlParser; tag: string;
                      inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "url":
          parseXsdString(target.url, parser, "url")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice, DocURLLinkBody(kind: dulMixedStr18, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "ulink":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "ulink":
            dulUlink1
          else:
            dulUlink1
          var tmp: DocURLLink
          parseDocURLLink(tmp, parser, parser.elementName(), true)
          var tmp2 = DocURLLinkBody(kind: kind)
          tmp2.docURLLink = tmp
          add(target.xsdChoice, tmp2)
        of "bold", "s", "strike", "underline", "emphasis", "computeroutput",
           "subscript", "superscript", "center", "small", "del", "ins":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "bold":
            dulBold1
          of "s":
            dulS1
          of "strike":
            dulStrike1
          of "underline":
            dulUnderline1
          of "emphasis":
            dulEmphasis1
          of "computeroutput":
            dulComputeroutput1
          of "subscript":
            dulSubscript1
          of "superscript":
            dulSuperscript1
          of "center":
            dulCenter1
          of "small":
            dulSmall1
          of "del":
            dulDel1
          of "ins":
            dulIns1
          else:
            dulBold1
          var tmp: DocMarkupType
          parseDocMarkupType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocURLLinkBody(kind: kind)
          tmp2.docMarkupType = tmp
          add(target.xsdChoice, tmp2)
        of "htmlonly":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "htmlonly":
            dulHtmlonly1
          else:
            dulHtmlonly1
          var tmp: DocHtmlOnlyType
          parseDocHtmlOnlyType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocURLLinkBody(kind: kind)
          tmp2.docHtmlOnlyType = tmp
          add(target.xsdChoice, tmp2)
        of "manonly", "xmlonly", "rtfonly", "latexonly", "docbookonly":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "manonly":
            dulManonly1
          of "xmlonly":
            dulXmlonly1
          of "rtfonly":
            dulRtfonly1
          of "latexonly":
            dulLatexonly1
          of "docbookonly":
            dulDocbookonly1
          else:
            dulManonly1
          var tmp: string
          parseXsdString(tmp, parser, parser.elementName())
          var tmp2 = DocURLLinkBody(kind: kind)
          tmp2.string = tmp
          add(target.xsdChoice, tmp2)
        of "image", "dot", "msc", "plantuml":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "image":
            dulImage1
          of "dot":
            dulDot1
          of "msc":
            dulMsc1
          of "plantuml":
            dulPlantuml1
          else:
            dulImage1
          var tmp: DocImageType
          parseDocImageType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocURLLinkBody(kind: kind)
          tmp2.docImageType = tmp
          add(target.xsdChoice, tmp2)
        of "anchor":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "anchor":
            dulAnchor1
          else:
            dulAnchor1
          var tmp: DocAnchorType
          parseDocAnchorType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocURLLinkBody(kind: kind)
          tmp2.docAnchorType = tmp
          add(target.xsdChoice, tmp2)
        of "formula":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "formula":
            dulFormula1
          else:
            dulFormula1
          var tmp: DocFormulaType
          parseDocFormulaType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocURLLinkBody(kind: kind)
          tmp2.docFormulaType = tmp
          add(target.xsdChoice, tmp2)
        of "ref":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "ref":
            dulRef3
          else:
            dulRef3
          var tmp: DocRefTextType
          parseDocRefTextType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocURLLinkBody(kind: kind)
          tmp2.docRefTextType = tmp
          add(target.xsdChoice, tmp2)
        of "emoji":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "emoji":
            dulEmoji1
          else:
            dulEmoji1
          var tmp: DocEmojiType
          parseDocEmojiType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocURLLinkBody(kind: kind)
          tmp2.docEmojiType = tmp
          add(target.xsdChoice, tmp2)
        of "linebreak", "nonbreakablespace", "iexcl", "cent", "pound", "curren",
           "yen", "brvbar", "sect", "umlaut", "copy", "ordf", "laquo", "not",
           "shy", "registered", "macr", "deg", "plusmn", "sup2", "sup3",
           "acute", "micro", "para", "middot", "cedil", "sup1", "ordm", "raquo",
           "frac14", "frac12", "frac34", "iquest", "Agrave", "Aacute", "Acirc",
           "Atilde", "Aumlaut", "Aring", "AElig", "Ccedil", "Egrave", "Eacute",
           "Ecirc", "Eumlaut", "Igrave", "Iacute", "Icirc", "Iumlaut", "ETH",
           "Ntilde", "Ograve", "Oacute", "Ocirc", "Otilde", "Oumlaut", "times",
           "Oslash", "Ugrave", "Uacute", "Ucirc", "Uumlaut", "Yacute", "THORN",
           "szlig", "agrave", "aacute", "acirc", "atilde", "aumlaut", "aring",
           "aelig", "ccedil", "egrave", "eacute", "ecirc", "eumlaut", "igrave",
           "iacute", "icirc", "iumlaut", "eth", "ntilde", "ograve", "oacute",
           "ocirc", "otilde", "oumlaut", "divide", "oslash", "ugrave", "uacute",
           "ucirc", "uumlaut", "yacute", "thorn", "yumlaut", "fnof", "Alpha",
           "Beta", "Gamma", "Delta", "Epsilon", "Zeta", "Eta", "Theta", "Iota",
           "Kappa", "Lambda", "Mu", "Nu", "Xi", "Omicron", "Pi", "Rho", "Sigma",
           "Tau", "Upsilon", "Phi", "Chi", "Psi", "Omega", "alpha", "beta",
           "gamma", "delta", "epsilon", "zeta", "eta", "theta", "iota", "kappa",
           "lambda", "mu", "nu", "xi", "omicron", "pi", "rho", "sigmaf",
           "sigma", "tau", "upsilon", "phi", "chi", "psi", "omega", "thetasym",
           "upsih", "piv", "bull", "hellip", "prime", "Prime", "oline", "frasl",
           "weierp", "imaginary", "real", "trademark", "alefsym", "larr",
           "uarr", "rarr", "darr", "harr", "crarr", "lArr", "uArr", "rArr",
           "dArr", "hArr", "forall", "part", "exist", "empty", "nabla", "isin",
           "notin", "ni", "prod", "sum", "minus", "lowast", "radic", "prop",
           "infin", "ang", "and", "or", "cap", "cup", "int", "there4", "sim",
           "cong", "asymp", "ne", "equiv", "le", "ge", "sub", "sup", "nsub",
           "sube", "supe", "oplus", "otimes", "perp", "sdot", "lceil", "rceil",
           "lfloor", "rfloor", "lang", "rang", "loz", "spades", "clubs",
           "hearts", "diams", "OElig", "oelig", "Scaron", "scaron", "Yumlaut",
           "circ", "tilde", "ensp", "emsp", "thinsp", "zwnj", "zwj", "lrm",
           "rlm", "ndash", "mdash", "lsquo", "rsquo", "sbquo", "ldquo", "rdquo",
           "bdquo", "dagger", "Dagger", "permil", "lsaquo", "rsaquo", "euro",
           "tm":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "linebreak":
            dulLinebreak1
          of "nonbreakablespace":
            dulNonbreakablespace1
          of "iexcl":
            dulIexcl1
          of "cent":
            dulCent1
          of "pound":
            dulPound1
          of "curren":
            dulCurren1
          of "yen":
            dulYen1
          of "brvbar":
            dulBrvbar1
          of "sect":
            dulSect1
          of "umlaut":
            dulUmlaut1
          of "copy":
            dulCopy1
          of "ordf":
            dulOrdf1
          of "laquo":
            dulLaquo1
          of "not":
            dulNot1
          of "shy":
            dulShy1
          of "registered":
            dulRegistered1
          of "macr":
            dulMacr1
          of "deg":
            dulDeg1
          of "plusmn":
            dulPlusmn1
          of "sup2":
            dulSup21
          of "sup3":
            dulSup31
          of "acute":
            dulAcute1
          of "micro":
            dulMicro1
          of "para":
            dulPara7
          of "middot":
            dulMiddot1
          of "cedil":
            dulCedil1
          of "sup1":
            dulSup11
          of "ordm":
            dulOrdm1
          of "raquo":
            dulRaquo1
          of "frac14":
            dulFrac141
          of "frac12":
            dulFrac121
          of "frac34":
            dulFrac341
          of "iquest":
            dulIquest1
          of "Agrave":
            dulAgrave2
          of "Aacute":
            dulAacute2
          of "Acirc":
            dulAcirc2
          of "Atilde":
            dulAtilde2
          of "Aumlaut":
            dulAumlaut2
          of "Aring":
            dulAring2
          of "AElig":
            dulAElig2
          of "Ccedil":
            dulCcedil2
          of "Egrave":
            dulEgrave2
          of "Eacute":
            dulEacute2
          of "Ecirc":
            dulEcirc2
          of "Eumlaut":
            dulEumlaut2
          of "Igrave":
            dulIgrave2
          of "Iacute":
            dulIacute2
          of "Icirc":
            dulIcirc2
          of "Iumlaut":
            dulIumlaut2
          of "ETH":
            dulETH2
          of "Ntilde":
            dulNtilde2
          of "Ograve":
            dulOgrave2
          of "Oacute":
            dulOacute2
          of "Ocirc":
            dulOcirc2
          of "Otilde":
            dulOtilde2
          of "Oumlaut":
            dulOumlaut2
          of "times":
            dulTimes1
          of "Oslash":
            dulOslash2
          of "Ugrave":
            dulUgrave2
          of "Uacute":
            dulUacute2
          of "Ucirc":
            dulUcirc2
          of "Uumlaut":
            dulUumlaut2
          of "Yacute":
            dulYacute2
          of "THORN":
            dulTHORN2
          of "szlig":
            dulSzlig1
          of "agrave":
            dulAgrave3
          of "aacute":
            dulAacute3
          of "acirc":
            dulAcirc3
          of "atilde":
            dulAtilde3
          of "aumlaut":
            dulAumlaut3
          of "aring":
            dulAring3
          of "aelig":
            dulAelig3
          of "ccedil":
            dulCcedil3
          of "egrave":
            dulEgrave3
          of "eacute":
            dulEacute3
          of "ecirc":
            dulEcirc3
          of "eumlaut":
            dulEumlaut3
          of "igrave":
            dulIgrave3
          of "iacute":
            dulIacute3
          of "icirc":
            dulIcirc3
          of "iumlaut":
            dulIumlaut3
          of "eth":
            dulEth3
          of "ntilde":
            dulNtilde3
          of "ograve":
            dulOgrave3
          of "oacute":
            dulOacute3
          of "ocirc":
            dulOcirc3
          of "otilde":
            dulOtilde3
          of "oumlaut":
            dulOumlaut3
          of "divide":
            dulDivide1
          of "oslash":
            dulOslash3
          of "ugrave":
            dulUgrave3
          of "uacute":
            dulUacute3
          of "ucirc":
            dulUcirc3
          of "uumlaut":
            dulUumlaut3
          of "yacute":
            dulYacute3
          of "thorn":
            dulThorn3
          of "yumlaut":
            dulYumlaut2
          of "fnof":
            dulFnof1
          of "Alpha":
            dulAlpha2
          of "Beta":
            dulBeta2
          of "Gamma":
            dulGamma2
          of "Delta":
            dulDelta2
          of "Epsilon":
            dulEpsilon2
          of "Zeta":
            dulZeta2
          of "Eta":
            dulEta2
          of "Theta":
            dulTheta2
          of "Iota":
            dulIota2
          of "Kappa":
            dulKappa2
          of "Lambda":
            dulLambda2
          of "Mu":
            dulMu2
          of "Nu":
            dulNu2
          of "Xi":
            dulXi2
          of "Omicron":
            dulOmicron2
          of "Pi":
            dulPi2
          of "Rho":
            dulRho2
          of "Sigma":
            dulSigma2
          of "Tau":
            dulTau2
          of "Upsilon":
            dulUpsilon2
          of "Phi":
            dulPhi2
          of "Chi":
            dulChi2
          of "Psi":
            dulPsi2
          of "Omega":
            dulOmega2
          of "alpha":
            dulAlpha3
          of "beta":
            dulBeta3
          of "gamma":
            dulGamma3
          of "delta":
            dulDelta3
          of "epsilon":
            dulEpsilon3
          of "zeta":
            dulZeta3
          of "eta":
            dulEta3
          of "theta":
            dulTheta3
          of "iota":
            dulIota3
          of "kappa":
            dulKappa3
          of "lambda":
            dulLambda3
          of "mu":
            dulMu3
          of "nu":
            dulNu3
          of "xi":
            dulXi3
          of "omicron":
            dulOmicron3
          of "pi":
            dulPi3
          of "rho":
            dulRho3
          of "sigmaf":
            dulSigmaf1
          of "sigma":
            dulSigma3
          of "tau":
            dulTau3
          of "upsilon":
            dulUpsilon3
          of "phi":
            dulPhi3
          of "chi":
            dulChi3
          of "psi":
            dulPsi3
          of "omega":
            dulOmega3
          of "thetasym":
            dulThetasym1
          of "upsih":
            dulUpsih1
          of "piv":
            dulPiv1
          of "bull":
            dulBull1
          of "hellip":
            dulHellip1
          of "prime":
            dulPrime2
          of "Prime":
            dulPrime3
          of "oline":
            dulOline1
          of "frasl":
            dulFrasl1
          of "weierp":
            dulWeierp1
          of "imaginary":
            dulImaginary1
          of "real":
            dulReal1
          of "trademark":
            dulTrademark1
          of "alefsym":
            dulAlefsym1
          of "larr":
            dulLarr2
          of "uarr":
            dulUarr2
          of "rarr":
            dulRarr2
          of "darr":
            dulDarr2
          of "harr":
            dulHarr2
          of "crarr":
            dulCrarr1
          of "lArr":
            dulLArr3
          of "uArr":
            dulUArr3
          of "rArr":
            dulRArr3
          of "dArr":
            dulDArr3
          of "hArr":
            dulHArr3
          of "forall":
            dulForall1
          of "part":
            dulPart1
          of "exist":
            dulExist1
          of "empty":
            dulEmpty1
          of "nabla":
            dulNabla1
          of "isin":
            dulIsin1
          of "notin":
            dulNotin1
          of "ni":
            dulNi1
          of "prod":
            dulProd1
          of "sum":
            dulSum1
          of "minus":
            dulMinus1
          of "lowast":
            dulLowast1
          of "radic":
            dulRadic1
          of "prop":
            dulProp1
          of "infin":
            dulInfin1
          of "ang":
            dulAng1
          of "and":
            dulAnd1
          of "or":
            dulOr1
          of "cap":
            dulCap1
          of "cup":
            dulCup1
          of "int":
            dulInt1
          of "there4":
            dulThere41
          of "sim":
            dulSim1
          of "cong":
            dulCong1
          of "asymp":
            dulAsymp1
          of "ne":
            dulNe1
          of "equiv":
            dulEquiv1
          of "le":
            dulLe1
          of "ge":
            dulGe1
          of "sub":
            dulSub1
          of "sup":
            dulSup1
          of "nsub":
            dulNsub1
          of "sube":
            dulSube1
          of "supe":
            dulSupe1
          of "oplus":
            dulOplus1
          of "otimes":
            dulOtimes1
          of "perp":
            dulPerp1
          of "sdot":
            dulSdot1
          of "lceil":
            dulLceil1
          of "rceil":
            dulRceil1
          of "lfloor":
            dulLfloor1
          of "rfloor":
            dulRfloor1
          of "lang":
            dulLang1
          of "rang":
            dulRang1
          of "loz":
            dulLoz1
          of "spades":
            dulSpades1
          of "clubs":
            dulClubs1
          of "hearts":
            dulHearts1
          of "diams":
            dulDiams1
          of "OElig":
            dulOElig2
          of "oelig":
            dulOelig3
          of "Scaron":
            dulScaron2
          of "scaron":
            dulScaron3
          of "Yumlaut":
            dulYumlaut3
          of "circ":
            dulCirc1
          of "tilde":
            dulTilde1
          of "ensp":
            dulEnsp1
          of "emsp":
            dulEmsp1
          of "thinsp":
            dulThinsp1
          of "zwnj":
            dulZwnj1
          of "zwj":
            dulZwj1
          of "lrm":
            dulLrm1
          of "rlm":
            dulRlm1
          of "ndash":
            dulNdash1
          of "mdash":
            dulMdash1
          of "lsquo":
            dulLsquo1
          of "rsquo":
            dulRsquo1
          of "sbquo":
            dulSbquo1
          of "ldquo":
            dulLdquo1
          of "rdquo":
            dulRdquo1
          of "bdquo":
            dulBdquo1
          of "dagger":
            dulDagger2
          of "Dagger":
            dulDagger3
          of "permil":
            dulPermil1
          of "lsaquo":
            dulLsaquo1
          of "rsaquo":
            dulRsaquo1
          of "euro":
            dulEuro1
          of "tm":
            dulTm1
          else:
            dulLinebreak1
          var tmp: DocEmptyType
          parseDocEmptyType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocURLLinkBody(kind: kind)
          tmp2.docEmptyType = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocAnchorType*(target: var (seq[DocAnchorType] | DocAnchorType |
    Option[DocAnchorType]); parser: var HXmlParser; tag: string;
                         inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocAnchorTypeBody(kind: datMixedStr19, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocFormulaType*(target: var (seq[DocFormulaType] | DocFormulaType |
    Option[DocFormulaType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocFormulaTypeBody(kind: dftMixedStr20, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocIndexEntryType*(target: var (
    seq[DocIndexEntryType] | DocIndexEntryType | Option[DocIndexEntryType]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "primaryie":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "primaryie")
          parseXsdString(target.primaryie, parser, "primaryie")
          skipElementEnd(parser, "primaryie")
        of "secondaryie":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "secondaryie")
          parseXsdString(target.secondaryie, parser, "secondaryie")
          skipElementEnd(parser, "secondaryie")
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


proc parseDocListType*(target: var (seq[DocListType] | DocListType |
    Option[DocListType]); parser: var HXmlParser; tag: string;
                       inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "listitem":
          ## 633:48:xml_to_types.nim
          parseDocListItemType(target.listitem, parser, "listitem", false)
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


proc parseDocListItemType*(target: var (seq[DocListItemType] | DocListItemType |
    Option[DocListItemType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "para":
          ## 633:48:xml_to_types.nim
          parseDocParaType(target.para, parser, "para", false)
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


proc parseDocSimpleSectType*(target: var (
    seq[DocSimpleSectType] | DocSimpleSectType | Option[DocSimpleSectType]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "kind":
          parseDoxSimpleSectKind(target.kind, parser, "kind")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "title":
          ## 633:48:xml_to_types.nim
          parseDocTitleType(target.title, parser, "title", false)
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


proc parseDocVarListEntryType*(target: var (seq[DocVarListEntryType] |
    DocVarListEntryType |
    Option[DocVarListEntryType]); parser: var HXmlParser; tag: string;
                               inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "term":
          ## 633:48:xml_to_types.nim
          parseDocTitleType(target.term, parser, "term", false)
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


proc parseDocVariableListType*(target: var (seq[DocVariableListType] |
    DocVariableListType |
    Option[DocVariableListType]); parser: var HXmlParser; tag: string;
                               inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
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


proc parseDocRefTextType*(target: var (seq[DocRefTextType] | DocRefTextType |
    Option[DocRefTextType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
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
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocRefTextTypeBody(kind: drttMixedStr21, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "ulink":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "ulink":
            drttUlink2
          else:
            drttUlink2
          var tmp: DocURLLink
          parseDocURLLink(tmp, parser, parser.elementName(), true)
          var tmp2 = DocRefTextTypeBody(kind: kind)
          tmp2.docURLLink = tmp
          add(target.xsdChoice, tmp2)
        of "bold", "s", "strike", "underline", "emphasis", "computeroutput",
           "subscript", "superscript", "center", "small", "del", "ins":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "bold":
            drttBold2
          of "s":
            drttS2
          of "strike":
            drttStrike2
          of "underline":
            drttUnderline2
          of "emphasis":
            drttEmphasis2
          of "computeroutput":
            drttComputeroutput2
          of "subscript":
            drttSubscript2
          of "superscript":
            drttSuperscript2
          of "center":
            drttCenter2
          of "small":
            drttSmall2
          of "del":
            drttDel2
          of "ins":
            drttIns2
          else:
            drttBold2
          var tmp: DocMarkupType
          parseDocMarkupType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocRefTextTypeBody(kind: kind)
          tmp2.docMarkupType = tmp
          add(target.xsdChoice, tmp2)
        of "htmlonly":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "htmlonly":
            drttHtmlonly2
          else:
            drttHtmlonly2
          var tmp: DocHtmlOnlyType
          parseDocHtmlOnlyType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocRefTextTypeBody(kind: kind)
          tmp2.docHtmlOnlyType = tmp
          add(target.xsdChoice, tmp2)
        of "manonly", "xmlonly", "rtfonly", "latexonly", "docbookonly":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "manonly":
            drttManonly2
          of "xmlonly":
            drttXmlonly2
          of "rtfonly":
            drttRtfonly2
          of "latexonly":
            drttLatexonly2
          of "docbookonly":
            drttDocbookonly2
          else:
            drttManonly2
          var tmp: string
          parseXsdString(tmp, parser, parser.elementName())
          var tmp2 = DocRefTextTypeBody(kind: kind)
          tmp2.string = tmp
          add(target.xsdChoice, tmp2)
        of "image", "dot", "msc", "plantuml":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "image":
            drttImage2
          of "dot":
            drttDot2
          of "msc":
            drttMsc2
          of "plantuml":
            drttPlantuml2
          else:
            drttImage2
          var tmp: DocImageType
          parseDocImageType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocRefTextTypeBody(kind: kind)
          tmp2.docImageType = tmp
          add(target.xsdChoice, tmp2)
        of "anchor":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "anchor":
            drttAnchor2
          else:
            drttAnchor2
          var tmp: DocAnchorType
          parseDocAnchorType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocRefTextTypeBody(kind: kind)
          tmp2.docAnchorType = tmp
          add(target.xsdChoice, tmp2)
        of "formula":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "formula":
            drttFormula2
          else:
            drttFormula2
          var tmp: DocFormulaType
          parseDocFormulaType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocRefTextTypeBody(kind: kind)
          tmp2.docFormulaType = tmp
          add(target.xsdChoice, tmp2)
        of "ref":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "ref":
            drttRef4
          else:
            drttRef4
          var tmp: DocRefTextType
          parseDocRefTextType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocRefTextTypeBody(kind: kind)
          tmp2.docRefTextType = tmp
          add(target.xsdChoice, tmp2)
        of "emoji":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "emoji":
            drttEmoji2
          else:
            drttEmoji2
          var tmp: DocEmojiType
          parseDocEmojiType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocRefTextTypeBody(kind: kind)
          tmp2.docEmojiType = tmp
          add(target.xsdChoice, tmp2)
        of "linebreak", "nonbreakablespace", "iexcl", "cent", "pound", "curren",
           "yen", "brvbar", "sect", "umlaut", "copy", "ordf", "laquo", "not",
           "shy", "registered", "macr", "deg", "plusmn", "sup2", "sup3",
           "acute", "micro", "para", "middot", "cedil", "sup1", "ordm", "raquo",
           "frac14", "frac12", "frac34", "iquest", "Agrave", "Aacute", "Acirc",
           "Atilde", "Aumlaut", "Aring", "AElig", "Ccedil", "Egrave", "Eacute",
           "Ecirc", "Eumlaut", "Igrave", "Iacute", "Icirc", "Iumlaut", "ETH",
           "Ntilde", "Ograve", "Oacute", "Ocirc", "Otilde", "Oumlaut", "times",
           "Oslash", "Ugrave", "Uacute", "Ucirc", "Uumlaut", "Yacute", "THORN",
           "szlig", "agrave", "aacute", "acirc", "atilde", "aumlaut", "aring",
           "aelig", "ccedil", "egrave", "eacute", "ecirc", "eumlaut", "igrave",
           "iacute", "icirc", "iumlaut", "eth", "ntilde", "ograve", "oacute",
           "ocirc", "otilde", "oumlaut", "divide", "oslash", "ugrave", "uacute",
           "ucirc", "uumlaut", "yacute", "thorn", "yumlaut", "fnof", "Alpha",
           "Beta", "Gamma", "Delta", "Epsilon", "Zeta", "Eta", "Theta", "Iota",
           "Kappa", "Lambda", "Mu", "Nu", "Xi", "Omicron", "Pi", "Rho", "Sigma",
           "Tau", "Upsilon", "Phi", "Chi", "Psi", "Omega", "alpha", "beta",
           "gamma", "delta", "epsilon", "zeta", "eta", "theta", "iota", "kappa",
           "lambda", "mu", "nu", "xi", "omicron", "pi", "rho", "sigmaf",
           "sigma", "tau", "upsilon", "phi", "chi", "psi", "omega", "thetasym",
           "upsih", "piv", "bull", "hellip", "prime", "Prime", "oline", "frasl",
           "weierp", "imaginary", "real", "trademark", "alefsym", "larr",
           "uarr", "rarr", "darr", "harr", "crarr", "lArr", "uArr", "rArr",
           "dArr", "hArr", "forall", "part", "exist", "empty", "nabla", "isin",
           "notin", "ni", "prod", "sum", "minus", "lowast", "radic", "prop",
           "infin", "ang", "and", "or", "cap", "cup", "int", "there4", "sim",
           "cong", "asymp", "ne", "equiv", "le", "ge", "sub", "sup", "nsub",
           "sube", "supe", "oplus", "otimes", "perp", "sdot", "lceil", "rceil",
           "lfloor", "rfloor", "lang", "rang", "loz", "spades", "clubs",
           "hearts", "diams", "OElig", "oelig", "Scaron", "scaron", "Yumlaut",
           "circ", "tilde", "ensp", "emsp", "thinsp", "zwnj", "zwj", "lrm",
           "rlm", "ndash", "mdash", "lsquo", "rsquo", "sbquo", "ldquo", "rdquo",
           "bdquo", "dagger", "Dagger", "permil", "lsaquo", "rsaquo", "euro",
           "tm":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "linebreak":
            drttLinebreak2
          of "nonbreakablespace":
            drttNonbreakablespace2
          of "iexcl":
            drttIexcl2
          of "cent":
            drttCent2
          of "pound":
            drttPound2
          of "curren":
            drttCurren2
          of "yen":
            drttYen2
          of "brvbar":
            drttBrvbar2
          of "sect":
            drttSect2
          of "umlaut":
            drttUmlaut2
          of "copy":
            drttCopy2
          of "ordf":
            drttOrdf2
          of "laquo":
            drttLaquo2
          of "not":
            drttNot2
          of "shy":
            drttShy2
          of "registered":
            drttRegistered2
          of "macr":
            drttMacr2
          of "deg":
            drttDeg2
          of "plusmn":
            drttPlusmn2
          of "sup2":
            drttSup22
          of "sup3":
            drttSup32
          of "acute":
            drttAcute2
          of "micro":
            drttMicro2
          of "para":
            drttPara9
          of "middot":
            drttMiddot2
          of "cedil":
            drttCedil2
          of "sup1":
            drttSup12
          of "ordm":
            drttOrdm2
          of "raquo":
            drttRaquo2
          of "frac14":
            drttFrac142
          of "frac12":
            drttFrac122
          of "frac34":
            drttFrac342
          of "iquest":
            drttIquest2
          of "Agrave":
            drttAgrave4
          of "Aacute":
            drttAacute4
          of "Acirc":
            drttAcirc4
          of "Atilde":
            drttAtilde4
          of "Aumlaut":
            drttAumlaut4
          of "Aring":
            drttAring4
          of "AElig":
            drttAElig4
          of "Ccedil":
            drttCcedil4
          of "Egrave":
            drttEgrave4
          of "Eacute":
            drttEacute4
          of "Ecirc":
            drttEcirc4
          of "Eumlaut":
            drttEumlaut4
          of "Igrave":
            drttIgrave4
          of "Iacute":
            drttIacute4
          of "Icirc":
            drttIcirc4
          of "Iumlaut":
            drttIumlaut4
          of "ETH":
            drttETH4
          of "Ntilde":
            drttNtilde4
          of "Ograve":
            drttOgrave4
          of "Oacute":
            drttOacute4
          of "Ocirc":
            drttOcirc4
          of "Otilde":
            drttOtilde4
          of "Oumlaut":
            drttOumlaut4
          of "times":
            drttTimes2
          of "Oslash":
            drttOslash4
          of "Ugrave":
            drttUgrave4
          of "Uacute":
            drttUacute4
          of "Ucirc":
            drttUcirc4
          of "Uumlaut":
            drttUumlaut4
          of "Yacute":
            drttYacute4
          of "THORN":
            drttTHORN4
          of "szlig":
            drttSzlig2
          of "agrave":
            drttAgrave5
          of "aacute":
            drttAacute5
          of "acirc":
            drttAcirc5
          of "atilde":
            drttAtilde5
          of "aumlaut":
            drttAumlaut5
          of "aring":
            drttAring5
          of "aelig":
            drttAelig5
          of "ccedil":
            drttCcedil5
          of "egrave":
            drttEgrave5
          of "eacute":
            drttEacute5
          of "ecirc":
            drttEcirc5
          of "eumlaut":
            drttEumlaut5
          of "igrave":
            drttIgrave5
          of "iacute":
            drttIacute5
          of "icirc":
            drttIcirc5
          of "iumlaut":
            drttIumlaut5
          of "eth":
            drttEth5
          of "ntilde":
            drttNtilde5
          of "ograve":
            drttOgrave5
          of "oacute":
            drttOacute5
          of "ocirc":
            drttOcirc5
          of "otilde":
            drttOtilde5
          of "oumlaut":
            drttOumlaut5
          of "divide":
            drttDivide2
          of "oslash":
            drttOslash5
          of "ugrave":
            drttUgrave5
          of "uacute":
            drttUacute5
          of "ucirc":
            drttUcirc5
          of "uumlaut":
            drttUumlaut5
          of "yacute":
            drttYacute5
          of "thorn":
            drttThorn5
          of "yumlaut":
            drttYumlaut4
          of "fnof":
            drttFnof2
          of "Alpha":
            drttAlpha4
          of "Beta":
            drttBeta4
          of "Gamma":
            drttGamma4
          of "Delta":
            drttDelta4
          of "Epsilon":
            drttEpsilon4
          of "Zeta":
            drttZeta4
          of "Eta":
            drttEta4
          of "Theta":
            drttTheta4
          of "Iota":
            drttIota4
          of "Kappa":
            drttKappa4
          of "Lambda":
            drttLambda4
          of "Mu":
            drttMu4
          of "Nu":
            drttNu4
          of "Xi":
            drttXi4
          of "Omicron":
            drttOmicron4
          of "Pi":
            drttPi4
          of "Rho":
            drttRho4
          of "Sigma":
            drttSigma4
          of "Tau":
            drttTau4
          of "Upsilon":
            drttUpsilon4
          of "Phi":
            drttPhi4
          of "Chi":
            drttChi4
          of "Psi":
            drttPsi4
          of "Omega":
            drttOmega4
          of "alpha":
            drttAlpha5
          of "beta":
            drttBeta5
          of "gamma":
            drttGamma5
          of "delta":
            drttDelta5
          of "epsilon":
            drttEpsilon5
          of "zeta":
            drttZeta5
          of "eta":
            drttEta5
          of "theta":
            drttTheta5
          of "iota":
            drttIota5
          of "kappa":
            drttKappa5
          of "lambda":
            drttLambda5
          of "mu":
            drttMu5
          of "nu":
            drttNu5
          of "xi":
            drttXi5
          of "omicron":
            drttOmicron5
          of "pi":
            drttPi5
          of "rho":
            drttRho5
          of "sigmaf":
            drttSigmaf2
          of "sigma":
            drttSigma5
          of "tau":
            drttTau5
          of "upsilon":
            drttUpsilon5
          of "phi":
            drttPhi5
          of "chi":
            drttChi5
          of "psi":
            drttPsi5
          of "omega":
            drttOmega5
          of "thetasym":
            drttThetasym2
          of "upsih":
            drttUpsih2
          of "piv":
            drttPiv2
          of "bull":
            drttBull2
          of "hellip":
            drttHellip2
          of "prime":
            drttPrime4
          of "Prime":
            drttPrime5
          of "oline":
            drttOline2
          of "frasl":
            drttFrasl2
          of "weierp":
            drttWeierp2
          of "imaginary":
            drttImaginary2
          of "real":
            drttReal2
          of "trademark":
            drttTrademark2
          of "alefsym":
            drttAlefsym2
          of "larr":
            drttLarr4
          of "uarr":
            drttUarr4
          of "rarr":
            drttRarr4
          of "darr":
            drttDarr4
          of "harr":
            drttHarr4
          of "crarr":
            drttCrarr2
          of "lArr":
            drttLArr5
          of "uArr":
            drttUArr5
          of "rArr":
            drttRArr5
          of "dArr":
            drttDArr5
          of "hArr":
            drttHArr5
          of "forall":
            drttForall2
          of "part":
            drttPart2
          of "exist":
            drttExist2
          of "empty":
            drttEmpty2
          of "nabla":
            drttNabla2
          of "isin":
            drttIsin2
          of "notin":
            drttNotin2
          of "ni":
            drttNi2
          of "prod":
            drttProd2
          of "sum":
            drttSum2
          of "minus":
            drttMinus2
          of "lowast":
            drttLowast2
          of "radic":
            drttRadic2
          of "prop":
            drttProp2
          of "infin":
            drttInfin2
          of "ang":
            drttAng2
          of "and":
            drttAnd2
          of "or":
            drttOr2
          of "cap":
            drttCap2
          of "cup":
            drttCup2
          of "int":
            drttInt2
          of "there4":
            drttThere42
          of "sim":
            drttSim2
          of "cong":
            drttCong2
          of "asymp":
            drttAsymp2
          of "ne":
            drttNe2
          of "equiv":
            drttEquiv2
          of "le":
            drttLe2
          of "ge":
            drttGe2
          of "sub":
            drttSub2
          of "sup":
            drttSup2
          of "nsub":
            drttNsub2
          of "sube":
            drttSube2
          of "supe":
            drttSupe2
          of "oplus":
            drttOplus2
          of "otimes":
            drttOtimes2
          of "perp":
            drttPerp2
          of "sdot":
            drttSdot2
          of "lceil":
            drttLceil2
          of "rceil":
            drttRceil2
          of "lfloor":
            drttLfloor2
          of "rfloor":
            drttRfloor2
          of "lang":
            drttLang2
          of "rang":
            drttRang2
          of "loz":
            drttLoz2
          of "spades":
            drttSpades2
          of "clubs":
            drttClubs2
          of "hearts":
            drttHearts2
          of "diams":
            drttDiams2
          of "OElig":
            drttOElig4
          of "oelig":
            drttOelig5
          of "Scaron":
            drttScaron4
          of "scaron":
            drttScaron5
          of "Yumlaut":
            drttYumlaut5
          of "circ":
            drttCirc2
          of "tilde":
            drttTilde2
          of "ensp":
            drttEnsp2
          of "emsp":
            drttEmsp2
          of "thinsp":
            drttThinsp2
          of "zwnj":
            drttZwnj2
          of "zwj":
            drttZwj2
          of "lrm":
            drttLrm2
          of "rlm":
            drttRlm2
          of "ndash":
            drttNdash2
          of "mdash":
            drttMdash2
          of "lsquo":
            drttLsquo2
          of "rsquo":
            drttRsquo2
          of "sbquo":
            drttSbquo2
          of "ldquo":
            drttLdquo2
          of "rdquo":
            drttRdquo2
          of "bdquo":
            drttBdquo2
          of "dagger":
            drttDagger4
          of "Dagger":
            drttDagger5
          of "permil":
            drttPermil2
          of "lsaquo":
            drttLsaquo2
          of "rsaquo":
            drttRsaquo2
          of "euro":
            drttEuro2
          of "tm":
            drttTm2
          else:
            drttLinebreak2
          var tmp: DocEmptyType
          parseDocEmptyType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocRefTextTypeBody(kind: kind)
          tmp2.docEmptyType = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocTableType*(target: var (seq[DocTableType] | DocTableType |
    Option[DocTableType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
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
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "caption":
          ## 633:48:xml_to_types.nim
          parseDocCaptionType(target.caption, parser, "caption", false)
        of "row":
          ## 633:48:xml_to_types.nim
          parseDocRowType(target.row, parser, "row", false)
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


proc parseDocRowType*(target: var (seq[DocRowType] | DocRowType |
    Option[DocRowType]); parser: var HXmlParser; tag: string;
                      inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "entry":
          ## 633:48:xml_to_types.nim
          parseDocEntryType(target.entry, parser, "entry", false)
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


proc parseDocEntryType*(target: var (seq[DocEntryType] | DocEntryType |
    Option[DocEntryType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
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
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "para":
          ## 633:48:xml_to_types.nim
          parseDocParaType(target.para, parser, "para", false)
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


proc parseDocCaptionType*(target: var (seq[DocCaptionType] | DocCaptionType |
    Option[DocCaptionType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocCaptionTypeBody(kind: dctMixedStr22, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "ulink":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "ulink":
            dctUlink3
          else:
            dctUlink3
          var tmp: DocURLLink
          parseDocURLLink(tmp, parser, parser.elementName(), true)
          var tmp2 = DocCaptionTypeBody(kind: kind)
          tmp2.docURLLink = tmp
          add(target.xsdChoice, tmp2)
        of "bold", "s", "strike", "underline", "emphasis", "computeroutput",
           "subscript", "superscript", "center", "small", "del", "ins":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "bold":
            dctBold3
          of "s":
            dctS3
          of "strike":
            dctStrike3
          of "underline":
            dctUnderline3
          of "emphasis":
            dctEmphasis3
          of "computeroutput":
            dctComputeroutput3
          of "subscript":
            dctSubscript3
          of "superscript":
            dctSuperscript3
          of "center":
            dctCenter3
          of "small":
            dctSmall3
          of "del":
            dctDel3
          of "ins":
            dctIns3
          else:
            dctBold3
          var tmp: DocMarkupType
          parseDocMarkupType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocCaptionTypeBody(kind: kind)
          tmp2.docMarkupType = tmp
          add(target.xsdChoice, tmp2)
        of "htmlonly":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "htmlonly":
            dctHtmlonly3
          else:
            dctHtmlonly3
          var tmp: DocHtmlOnlyType
          parseDocHtmlOnlyType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocCaptionTypeBody(kind: kind)
          tmp2.docHtmlOnlyType = tmp
          add(target.xsdChoice, tmp2)
        of "manonly", "xmlonly", "rtfonly", "latexonly", "docbookonly":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "manonly":
            dctManonly3
          of "xmlonly":
            dctXmlonly3
          of "rtfonly":
            dctRtfonly3
          of "latexonly":
            dctLatexonly3
          of "docbookonly":
            dctDocbookonly3
          else:
            dctManonly3
          var tmp: string
          parseXsdString(tmp, parser, parser.elementName())
          var tmp2 = DocCaptionTypeBody(kind: kind)
          tmp2.string = tmp
          add(target.xsdChoice, tmp2)
        of "image", "dot", "msc", "plantuml":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "image":
            dctImage3
          of "dot":
            dctDot3
          of "msc":
            dctMsc3
          of "plantuml":
            dctPlantuml3
          else:
            dctImage3
          var tmp: DocImageType
          parseDocImageType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocCaptionTypeBody(kind: kind)
          tmp2.docImageType = tmp
          add(target.xsdChoice, tmp2)
        of "anchor":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "anchor":
            dctAnchor3
          else:
            dctAnchor3
          var tmp: DocAnchorType
          parseDocAnchorType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocCaptionTypeBody(kind: kind)
          tmp2.docAnchorType = tmp
          add(target.xsdChoice, tmp2)
        of "formula":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "formula":
            dctFormula3
          else:
            dctFormula3
          var tmp: DocFormulaType
          parseDocFormulaType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocCaptionTypeBody(kind: kind)
          tmp2.docFormulaType = tmp
          add(target.xsdChoice, tmp2)
        of "ref":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "ref":
            dctRef5
          else:
            dctRef5
          var tmp: DocRefTextType
          parseDocRefTextType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocCaptionTypeBody(kind: kind)
          tmp2.docRefTextType = tmp
          add(target.xsdChoice, tmp2)
        of "emoji":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "emoji":
            dctEmoji3
          else:
            dctEmoji3
          var tmp: DocEmojiType
          parseDocEmojiType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocCaptionTypeBody(kind: kind)
          tmp2.docEmojiType = tmp
          add(target.xsdChoice, tmp2)
        of "linebreak", "nonbreakablespace", "iexcl", "cent", "pound", "curren",
           "yen", "brvbar", "sect", "umlaut", "copy", "ordf", "laquo", "not",
           "shy", "registered", "macr", "deg", "plusmn", "sup2", "sup3",
           "acute", "micro", "para", "middot", "cedil", "sup1", "ordm", "raquo",
           "frac14", "frac12", "frac34", "iquest", "Agrave", "Aacute", "Acirc",
           "Atilde", "Aumlaut", "Aring", "AElig", "Ccedil", "Egrave", "Eacute",
           "Ecirc", "Eumlaut", "Igrave", "Iacute", "Icirc", "Iumlaut", "ETH",
           "Ntilde", "Ograve", "Oacute", "Ocirc", "Otilde", "Oumlaut", "times",
           "Oslash", "Ugrave", "Uacute", "Ucirc", "Uumlaut", "Yacute", "THORN",
           "szlig", "agrave", "aacute", "acirc", "atilde", "aumlaut", "aring",
           "aelig", "ccedil", "egrave", "eacute", "ecirc", "eumlaut", "igrave",
           "iacute", "icirc", "iumlaut", "eth", "ntilde", "ograve", "oacute",
           "ocirc", "otilde", "oumlaut", "divide", "oslash", "ugrave", "uacute",
           "ucirc", "uumlaut", "yacute", "thorn", "yumlaut", "fnof", "Alpha",
           "Beta", "Gamma", "Delta", "Epsilon", "Zeta", "Eta", "Theta", "Iota",
           "Kappa", "Lambda", "Mu", "Nu", "Xi", "Omicron", "Pi", "Rho", "Sigma",
           "Tau", "Upsilon", "Phi", "Chi", "Psi", "Omega", "alpha", "beta",
           "gamma", "delta", "epsilon", "zeta", "eta", "theta", "iota", "kappa",
           "lambda", "mu", "nu", "xi", "omicron", "pi", "rho", "sigmaf",
           "sigma", "tau", "upsilon", "phi", "chi", "psi", "omega", "thetasym",
           "upsih", "piv", "bull", "hellip", "prime", "Prime", "oline", "frasl",
           "weierp", "imaginary", "real", "trademark", "alefsym", "larr",
           "uarr", "rarr", "darr", "harr", "crarr", "lArr", "uArr", "rArr",
           "dArr", "hArr", "forall", "part", "exist", "empty", "nabla", "isin",
           "notin", "ni", "prod", "sum", "minus", "lowast", "radic", "prop",
           "infin", "ang", "and", "or", "cap", "cup", "int", "there4", "sim",
           "cong", "asymp", "ne", "equiv", "le", "ge", "sub", "sup", "nsub",
           "sube", "supe", "oplus", "otimes", "perp", "sdot", "lceil", "rceil",
           "lfloor", "rfloor", "lang", "rang", "loz", "spades", "clubs",
           "hearts", "diams", "OElig", "oelig", "Scaron", "scaron", "Yumlaut",
           "circ", "tilde", "ensp", "emsp", "thinsp", "zwnj", "zwj", "lrm",
           "rlm", "ndash", "mdash", "lsquo", "rsquo", "sbquo", "ldquo", "rdquo",
           "bdquo", "dagger", "Dagger", "permil", "lsaquo", "rsaquo", "euro",
           "tm":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "linebreak":
            dctLinebreak3
          of "nonbreakablespace":
            dctNonbreakablespace3
          of "iexcl":
            dctIexcl3
          of "cent":
            dctCent3
          of "pound":
            dctPound3
          of "curren":
            dctCurren3
          of "yen":
            dctYen3
          of "brvbar":
            dctBrvbar3
          of "sect":
            dctSect3
          of "umlaut":
            dctUmlaut3
          of "copy":
            dctCopy3
          of "ordf":
            dctOrdf3
          of "laquo":
            dctLaquo3
          of "not":
            dctNot3
          of "shy":
            dctShy3
          of "registered":
            dctRegistered3
          of "macr":
            dctMacr3
          of "deg":
            dctDeg3
          of "plusmn":
            dctPlusmn3
          of "sup2":
            dctSup23
          of "sup3":
            dctSup33
          of "acute":
            dctAcute3
          of "micro":
            dctMicro3
          of "para":
            dctPara11
          of "middot":
            dctMiddot3
          of "cedil":
            dctCedil3
          of "sup1":
            dctSup13
          of "ordm":
            dctOrdm3
          of "raquo":
            dctRaquo3
          of "frac14":
            dctFrac143
          of "frac12":
            dctFrac123
          of "frac34":
            dctFrac343
          of "iquest":
            dctIquest3
          of "Agrave":
            dctAgrave6
          of "Aacute":
            dctAacute6
          of "Acirc":
            dctAcirc6
          of "Atilde":
            dctAtilde6
          of "Aumlaut":
            dctAumlaut6
          of "Aring":
            dctAring6
          of "AElig":
            dctAElig6
          of "Ccedil":
            dctCcedil6
          of "Egrave":
            dctEgrave6
          of "Eacute":
            dctEacute6
          of "Ecirc":
            dctEcirc6
          of "Eumlaut":
            dctEumlaut6
          of "Igrave":
            dctIgrave6
          of "Iacute":
            dctIacute6
          of "Icirc":
            dctIcirc6
          of "Iumlaut":
            dctIumlaut6
          of "ETH":
            dctETH6
          of "Ntilde":
            dctNtilde6
          of "Ograve":
            dctOgrave6
          of "Oacute":
            dctOacute6
          of "Ocirc":
            dctOcirc6
          of "Otilde":
            dctOtilde6
          of "Oumlaut":
            dctOumlaut6
          of "times":
            dctTimes3
          of "Oslash":
            dctOslash6
          of "Ugrave":
            dctUgrave6
          of "Uacute":
            dctUacute6
          of "Ucirc":
            dctUcirc6
          of "Uumlaut":
            dctUumlaut6
          of "Yacute":
            dctYacute6
          of "THORN":
            dctTHORN6
          of "szlig":
            dctSzlig3
          of "agrave":
            dctAgrave7
          of "aacute":
            dctAacute7
          of "acirc":
            dctAcirc7
          of "atilde":
            dctAtilde7
          of "aumlaut":
            dctAumlaut7
          of "aring":
            dctAring7
          of "aelig":
            dctAelig7
          of "ccedil":
            dctCcedil7
          of "egrave":
            dctEgrave7
          of "eacute":
            dctEacute7
          of "ecirc":
            dctEcirc7
          of "eumlaut":
            dctEumlaut7
          of "igrave":
            dctIgrave7
          of "iacute":
            dctIacute7
          of "icirc":
            dctIcirc7
          of "iumlaut":
            dctIumlaut7
          of "eth":
            dctEth7
          of "ntilde":
            dctNtilde7
          of "ograve":
            dctOgrave7
          of "oacute":
            dctOacute7
          of "ocirc":
            dctOcirc7
          of "otilde":
            dctOtilde7
          of "oumlaut":
            dctOumlaut7
          of "divide":
            dctDivide3
          of "oslash":
            dctOslash7
          of "ugrave":
            dctUgrave7
          of "uacute":
            dctUacute7
          of "ucirc":
            dctUcirc7
          of "uumlaut":
            dctUumlaut7
          of "yacute":
            dctYacute7
          of "thorn":
            dctThorn7
          of "yumlaut":
            dctYumlaut6
          of "fnof":
            dctFnof3
          of "Alpha":
            dctAlpha6
          of "Beta":
            dctBeta6
          of "Gamma":
            dctGamma6
          of "Delta":
            dctDelta6
          of "Epsilon":
            dctEpsilon6
          of "Zeta":
            dctZeta6
          of "Eta":
            dctEta6
          of "Theta":
            dctTheta6
          of "Iota":
            dctIota6
          of "Kappa":
            dctKappa6
          of "Lambda":
            dctLambda6
          of "Mu":
            dctMu6
          of "Nu":
            dctNu6
          of "Xi":
            dctXi6
          of "Omicron":
            dctOmicron6
          of "Pi":
            dctPi6
          of "Rho":
            dctRho6
          of "Sigma":
            dctSigma6
          of "Tau":
            dctTau6
          of "Upsilon":
            dctUpsilon6
          of "Phi":
            dctPhi6
          of "Chi":
            dctChi6
          of "Psi":
            dctPsi6
          of "Omega":
            dctOmega6
          of "alpha":
            dctAlpha7
          of "beta":
            dctBeta7
          of "gamma":
            dctGamma7
          of "delta":
            dctDelta7
          of "epsilon":
            dctEpsilon7
          of "zeta":
            dctZeta7
          of "eta":
            dctEta7
          of "theta":
            dctTheta7
          of "iota":
            dctIota7
          of "kappa":
            dctKappa7
          of "lambda":
            dctLambda7
          of "mu":
            dctMu7
          of "nu":
            dctNu7
          of "xi":
            dctXi7
          of "omicron":
            dctOmicron7
          of "pi":
            dctPi7
          of "rho":
            dctRho7
          of "sigmaf":
            dctSigmaf3
          of "sigma":
            dctSigma7
          of "tau":
            dctTau7
          of "upsilon":
            dctUpsilon7
          of "phi":
            dctPhi7
          of "chi":
            dctChi7
          of "psi":
            dctPsi7
          of "omega":
            dctOmega7
          of "thetasym":
            dctThetasym3
          of "upsih":
            dctUpsih3
          of "piv":
            dctPiv3
          of "bull":
            dctBull3
          of "hellip":
            dctHellip3
          of "prime":
            dctPrime6
          of "Prime":
            dctPrime7
          of "oline":
            dctOline3
          of "frasl":
            dctFrasl3
          of "weierp":
            dctWeierp3
          of "imaginary":
            dctImaginary3
          of "real":
            dctReal3
          of "trademark":
            dctTrademark3
          of "alefsym":
            dctAlefsym3
          of "larr":
            dctLarr6
          of "uarr":
            dctUarr6
          of "rarr":
            dctRarr6
          of "darr":
            dctDarr6
          of "harr":
            dctHarr6
          of "crarr":
            dctCrarr3
          of "lArr":
            dctLArr7
          of "uArr":
            dctUArr7
          of "rArr":
            dctRArr7
          of "dArr":
            dctDArr7
          of "hArr":
            dctHArr7
          of "forall":
            dctForall3
          of "part":
            dctPart3
          of "exist":
            dctExist3
          of "empty":
            dctEmpty3
          of "nabla":
            dctNabla3
          of "isin":
            dctIsin3
          of "notin":
            dctNotin3
          of "ni":
            dctNi3
          of "prod":
            dctProd3
          of "sum":
            dctSum3
          of "minus":
            dctMinus3
          of "lowast":
            dctLowast3
          of "radic":
            dctRadic3
          of "prop":
            dctProp3
          of "infin":
            dctInfin3
          of "ang":
            dctAng3
          of "and":
            dctAnd3
          of "or":
            dctOr3
          of "cap":
            dctCap3
          of "cup":
            dctCup3
          of "int":
            dctInt3
          of "there4":
            dctThere43
          of "sim":
            dctSim3
          of "cong":
            dctCong3
          of "asymp":
            dctAsymp3
          of "ne":
            dctNe3
          of "equiv":
            dctEquiv3
          of "le":
            dctLe3
          of "ge":
            dctGe3
          of "sub":
            dctSub3
          of "sup":
            dctSup3
          of "nsub":
            dctNsub3
          of "sube":
            dctSube3
          of "supe":
            dctSupe3
          of "oplus":
            dctOplus3
          of "otimes":
            dctOtimes3
          of "perp":
            dctPerp3
          of "sdot":
            dctSdot3
          of "lceil":
            dctLceil3
          of "rceil":
            dctRceil3
          of "lfloor":
            dctLfloor3
          of "rfloor":
            dctRfloor3
          of "lang":
            dctLang3
          of "rang":
            dctRang3
          of "loz":
            dctLoz3
          of "spades":
            dctSpades3
          of "clubs":
            dctClubs3
          of "hearts":
            dctHearts3
          of "diams":
            dctDiams3
          of "OElig":
            dctOElig6
          of "oelig":
            dctOelig7
          of "Scaron":
            dctScaron6
          of "scaron":
            dctScaron7
          of "Yumlaut":
            dctYumlaut7
          of "circ":
            dctCirc3
          of "tilde":
            dctTilde3
          of "ensp":
            dctEnsp3
          of "emsp":
            dctEmsp3
          of "thinsp":
            dctThinsp3
          of "zwnj":
            dctZwnj3
          of "zwj":
            dctZwj3
          of "lrm":
            dctLrm3
          of "rlm":
            dctRlm3
          of "ndash":
            dctNdash3
          of "mdash":
            dctMdash3
          of "lsquo":
            dctLsquo3
          of "rsquo":
            dctRsquo3
          of "sbquo":
            dctSbquo3
          of "ldquo":
            dctLdquo3
          of "rdquo":
            dctRdquo3
          of "bdquo":
            dctBdquo3
          of "dagger":
            dctDagger6
          of "Dagger":
            dctDagger7
          of "permil":
            dctPermil3
          of "lsaquo":
            dctLsaquo3
          of "rsaquo":
            dctRsaquo3
          of "euro":
            dctEuro3
          of "tm":
            dctTm3
          else:
            dctLinebreak3
          var tmp: DocEmptyType
          parseDocEmptyType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocCaptionTypeBody(kind: kind)
          tmp2.docEmptyType = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocHeadingType*(target: var (seq[DocHeadingType] | DocHeadingType |
    Option[DocHeadingType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "level":
          parseXsdInteger(target.level, parser, "level")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocHeadingTypeBody(kind: dhtMixedStr23, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "ulink":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "ulink":
            dhtUlink4
          else:
            dhtUlink4
          var tmp: DocURLLink
          parseDocURLLink(tmp, parser, parser.elementName(), true)
          var tmp2 = DocHeadingTypeBody(kind: kind)
          tmp2.docURLLink = tmp
          add(target.xsdChoice, tmp2)
        of "bold", "s", "strike", "underline", "emphasis", "computeroutput",
           "subscript", "superscript", "center", "small", "del", "ins":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "bold":
            dhtBold4
          of "s":
            dhtS4
          of "strike":
            dhtStrike4
          of "underline":
            dhtUnderline4
          of "emphasis":
            dhtEmphasis4
          of "computeroutput":
            dhtComputeroutput4
          of "subscript":
            dhtSubscript4
          of "superscript":
            dhtSuperscript4
          of "center":
            dhtCenter4
          of "small":
            dhtSmall4
          of "del":
            dhtDel4
          of "ins":
            dhtIns4
          else:
            dhtBold4
          var tmp: DocMarkupType
          parseDocMarkupType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocHeadingTypeBody(kind: kind)
          tmp2.docMarkupType = tmp
          add(target.xsdChoice, tmp2)
        of "htmlonly":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "htmlonly":
            dhtHtmlonly4
          else:
            dhtHtmlonly4
          var tmp: DocHtmlOnlyType
          parseDocHtmlOnlyType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocHeadingTypeBody(kind: kind)
          tmp2.docHtmlOnlyType = tmp
          add(target.xsdChoice, tmp2)
        of "manonly", "xmlonly", "rtfonly", "latexonly", "docbookonly":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "manonly":
            dhtManonly4
          of "xmlonly":
            dhtXmlonly4
          of "rtfonly":
            dhtRtfonly4
          of "latexonly":
            dhtLatexonly4
          of "docbookonly":
            dhtDocbookonly4
          else:
            dhtManonly4
          var tmp: string
          parseXsdString(tmp, parser, parser.elementName())
          var tmp2 = DocHeadingTypeBody(kind: kind)
          tmp2.string = tmp
          add(target.xsdChoice, tmp2)
        of "image", "dot", "msc", "plantuml":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "image":
            dhtImage4
          of "dot":
            dhtDot4
          of "msc":
            dhtMsc4
          of "plantuml":
            dhtPlantuml4
          else:
            dhtImage4
          var tmp: DocImageType
          parseDocImageType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocHeadingTypeBody(kind: kind)
          tmp2.docImageType = tmp
          add(target.xsdChoice, tmp2)
        of "anchor":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "anchor":
            dhtAnchor4
          else:
            dhtAnchor4
          var tmp: DocAnchorType
          parseDocAnchorType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocHeadingTypeBody(kind: kind)
          tmp2.docAnchorType = tmp
          add(target.xsdChoice, tmp2)
        of "formula":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "formula":
            dhtFormula4
          else:
            dhtFormula4
          var tmp: DocFormulaType
          parseDocFormulaType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocHeadingTypeBody(kind: kind)
          tmp2.docFormulaType = tmp
          add(target.xsdChoice, tmp2)
        of "ref":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "ref":
            dhtRef6
          else:
            dhtRef6
          var tmp: DocRefTextType
          parseDocRefTextType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocHeadingTypeBody(kind: kind)
          tmp2.docRefTextType = tmp
          add(target.xsdChoice, tmp2)
        of "emoji":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "emoji":
            dhtEmoji4
          else:
            dhtEmoji4
          var tmp: DocEmojiType
          parseDocEmojiType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocHeadingTypeBody(kind: kind)
          tmp2.docEmojiType = tmp
          add(target.xsdChoice, tmp2)
        of "linebreak", "nonbreakablespace", "iexcl", "cent", "pound", "curren",
           "yen", "brvbar", "sect", "umlaut", "copy", "ordf", "laquo", "not",
           "shy", "registered", "macr", "deg", "plusmn", "sup2", "sup3",
           "acute", "micro", "para", "middot", "cedil", "sup1", "ordm", "raquo",
           "frac14", "frac12", "frac34", "iquest", "Agrave", "Aacute", "Acirc",
           "Atilde", "Aumlaut", "Aring", "AElig", "Ccedil", "Egrave", "Eacute",
           "Ecirc", "Eumlaut", "Igrave", "Iacute", "Icirc", "Iumlaut", "ETH",
           "Ntilde", "Ograve", "Oacute", "Ocirc", "Otilde", "Oumlaut", "times",
           "Oslash", "Ugrave", "Uacute", "Ucirc", "Uumlaut", "Yacute", "THORN",
           "szlig", "agrave", "aacute", "acirc", "atilde", "aumlaut", "aring",
           "aelig", "ccedil", "egrave", "eacute", "ecirc", "eumlaut", "igrave",
           "iacute", "icirc", "iumlaut", "eth", "ntilde", "ograve", "oacute",
           "ocirc", "otilde", "oumlaut", "divide", "oslash", "ugrave", "uacute",
           "ucirc", "uumlaut", "yacute", "thorn", "yumlaut", "fnof", "Alpha",
           "Beta", "Gamma", "Delta", "Epsilon", "Zeta", "Eta", "Theta", "Iota",
           "Kappa", "Lambda", "Mu", "Nu", "Xi", "Omicron", "Pi", "Rho", "Sigma",
           "Tau", "Upsilon", "Phi", "Chi", "Psi", "Omega", "alpha", "beta",
           "gamma", "delta", "epsilon", "zeta", "eta", "theta", "iota", "kappa",
           "lambda", "mu", "nu", "xi", "omicron", "pi", "rho", "sigmaf",
           "sigma", "tau", "upsilon", "phi", "chi", "psi", "omega", "thetasym",
           "upsih", "piv", "bull", "hellip", "prime", "Prime", "oline", "frasl",
           "weierp", "imaginary", "real", "trademark", "alefsym", "larr",
           "uarr", "rarr", "darr", "harr", "crarr", "lArr", "uArr", "rArr",
           "dArr", "hArr", "forall", "part", "exist", "empty", "nabla", "isin",
           "notin", "ni", "prod", "sum", "minus", "lowast", "radic", "prop",
           "infin", "ang", "and", "or", "cap", "cup", "int", "there4", "sim",
           "cong", "asymp", "ne", "equiv", "le", "ge", "sub", "sup", "nsub",
           "sube", "supe", "oplus", "otimes", "perp", "sdot", "lceil", "rceil",
           "lfloor", "rfloor", "lang", "rang", "loz", "spades", "clubs",
           "hearts", "diams", "OElig", "oelig", "Scaron", "scaron", "Yumlaut",
           "circ", "tilde", "ensp", "emsp", "thinsp", "zwnj", "zwj", "lrm",
           "rlm", "ndash", "mdash", "lsquo", "rsquo", "sbquo", "ldquo", "rdquo",
           "bdquo", "dagger", "Dagger", "permil", "lsaquo", "rsaquo", "euro",
           "tm":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "linebreak":
            dhtLinebreak4
          of "nonbreakablespace":
            dhtNonbreakablespace4
          of "iexcl":
            dhtIexcl4
          of "cent":
            dhtCent4
          of "pound":
            dhtPound4
          of "curren":
            dhtCurren4
          of "yen":
            dhtYen4
          of "brvbar":
            dhtBrvbar4
          of "sect":
            dhtSect4
          of "umlaut":
            dhtUmlaut4
          of "copy":
            dhtCopy4
          of "ordf":
            dhtOrdf4
          of "laquo":
            dhtLaquo4
          of "not":
            dhtNot4
          of "shy":
            dhtShy4
          of "registered":
            dhtRegistered4
          of "macr":
            dhtMacr4
          of "deg":
            dhtDeg4
          of "plusmn":
            dhtPlusmn4
          of "sup2":
            dhtSup24
          of "sup3":
            dhtSup34
          of "acute":
            dhtAcute4
          of "micro":
            dhtMicro4
          of "para":
            dhtPara12
          of "middot":
            dhtMiddot4
          of "cedil":
            dhtCedil4
          of "sup1":
            dhtSup14
          of "ordm":
            dhtOrdm4
          of "raquo":
            dhtRaquo4
          of "frac14":
            dhtFrac144
          of "frac12":
            dhtFrac124
          of "frac34":
            dhtFrac344
          of "iquest":
            dhtIquest4
          of "Agrave":
            dhtAgrave8
          of "Aacute":
            dhtAacute8
          of "Acirc":
            dhtAcirc8
          of "Atilde":
            dhtAtilde8
          of "Aumlaut":
            dhtAumlaut8
          of "Aring":
            dhtAring8
          of "AElig":
            dhtAElig8
          of "Ccedil":
            dhtCcedil8
          of "Egrave":
            dhtEgrave8
          of "Eacute":
            dhtEacute8
          of "Ecirc":
            dhtEcirc8
          of "Eumlaut":
            dhtEumlaut8
          of "Igrave":
            dhtIgrave8
          of "Iacute":
            dhtIacute8
          of "Icirc":
            dhtIcirc8
          of "Iumlaut":
            dhtIumlaut8
          of "ETH":
            dhtETH8
          of "Ntilde":
            dhtNtilde8
          of "Ograve":
            dhtOgrave8
          of "Oacute":
            dhtOacute8
          of "Ocirc":
            dhtOcirc8
          of "Otilde":
            dhtOtilde8
          of "Oumlaut":
            dhtOumlaut8
          of "times":
            dhtTimes4
          of "Oslash":
            dhtOslash8
          of "Ugrave":
            dhtUgrave8
          of "Uacute":
            dhtUacute8
          of "Ucirc":
            dhtUcirc8
          of "Uumlaut":
            dhtUumlaut8
          of "Yacute":
            dhtYacute8
          of "THORN":
            dhtTHORN8
          of "szlig":
            dhtSzlig4
          of "agrave":
            dhtAgrave9
          of "aacute":
            dhtAacute9
          of "acirc":
            dhtAcirc9
          of "atilde":
            dhtAtilde9
          of "aumlaut":
            dhtAumlaut9
          of "aring":
            dhtAring9
          of "aelig":
            dhtAelig9
          of "ccedil":
            dhtCcedil9
          of "egrave":
            dhtEgrave9
          of "eacute":
            dhtEacute9
          of "ecirc":
            dhtEcirc9
          of "eumlaut":
            dhtEumlaut9
          of "igrave":
            dhtIgrave9
          of "iacute":
            dhtIacute9
          of "icirc":
            dhtIcirc9
          of "iumlaut":
            dhtIumlaut9
          of "eth":
            dhtEth9
          of "ntilde":
            dhtNtilde9
          of "ograve":
            dhtOgrave9
          of "oacute":
            dhtOacute9
          of "ocirc":
            dhtOcirc9
          of "otilde":
            dhtOtilde9
          of "oumlaut":
            dhtOumlaut9
          of "divide":
            dhtDivide4
          of "oslash":
            dhtOslash9
          of "ugrave":
            dhtUgrave9
          of "uacute":
            dhtUacute9
          of "ucirc":
            dhtUcirc9
          of "uumlaut":
            dhtUumlaut9
          of "yacute":
            dhtYacute9
          of "thorn":
            dhtThorn9
          of "yumlaut":
            dhtYumlaut8
          of "fnof":
            dhtFnof4
          of "Alpha":
            dhtAlpha8
          of "Beta":
            dhtBeta8
          of "Gamma":
            dhtGamma8
          of "Delta":
            dhtDelta8
          of "Epsilon":
            dhtEpsilon8
          of "Zeta":
            dhtZeta8
          of "Eta":
            dhtEta8
          of "Theta":
            dhtTheta8
          of "Iota":
            dhtIota8
          of "Kappa":
            dhtKappa8
          of "Lambda":
            dhtLambda8
          of "Mu":
            dhtMu8
          of "Nu":
            dhtNu8
          of "Xi":
            dhtXi8
          of "Omicron":
            dhtOmicron8
          of "Pi":
            dhtPi8
          of "Rho":
            dhtRho8
          of "Sigma":
            dhtSigma8
          of "Tau":
            dhtTau8
          of "Upsilon":
            dhtUpsilon8
          of "Phi":
            dhtPhi8
          of "Chi":
            dhtChi8
          of "Psi":
            dhtPsi8
          of "Omega":
            dhtOmega8
          of "alpha":
            dhtAlpha9
          of "beta":
            dhtBeta9
          of "gamma":
            dhtGamma9
          of "delta":
            dhtDelta9
          of "epsilon":
            dhtEpsilon9
          of "zeta":
            dhtZeta9
          of "eta":
            dhtEta9
          of "theta":
            dhtTheta9
          of "iota":
            dhtIota9
          of "kappa":
            dhtKappa9
          of "lambda":
            dhtLambda9
          of "mu":
            dhtMu9
          of "nu":
            dhtNu9
          of "xi":
            dhtXi9
          of "omicron":
            dhtOmicron9
          of "pi":
            dhtPi9
          of "rho":
            dhtRho9
          of "sigmaf":
            dhtSigmaf4
          of "sigma":
            dhtSigma9
          of "tau":
            dhtTau9
          of "upsilon":
            dhtUpsilon9
          of "phi":
            dhtPhi9
          of "chi":
            dhtChi9
          of "psi":
            dhtPsi9
          of "omega":
            dhtOmega9
          of "thetasym":
            dhtThetasym4
          of "upsih":
            dhtUpsih4
          of "piv":
            dhtPiv4
          of "bull":
            dhtBull4
          of "hellip":
            dhtHellip4
          of "prime":
            dhtPrime8
          of "Prime":
            dhtPrime9
          of "oline":
            dhtOline4
          of "frasl":
            dhtFrasl4
          of "weierp":
            dhtWeierp4
          of "imaginary":
            dhtImaginary4
          of "real":
            dhtReal4
          of "trademark":
            dhtTrademark4
          of "alefsym":
            dhtAlefsym4
          of "larr":
            dhtLarr8
          of "uarr":
            dhtUarr8
          of "rarr":
            dhtRarr8
          of "darr":
            dhtDarr8
          of "harr":
            dhtHarr8
          of "crarr":
            dhtCrarr4
          of "lArr":
            dhtLArr9
          of "uArr":
            dhtUArr9
          of "rArr":
            dhtRArr9
          of "dArr":
            dhtDArr9
          of "hArr":
            dhtHArr9
          of "forall":
            dhtForall4
          of "part":
            dhtPart4
          of "exist":
            dhtExist4
          of "empty":
            dhtEmpty4
          of "nabla":
            dhtNabla4
          of "isin":
            dhtIsin4
          of "notin":
            dhtNotin4
          of "ni":
            dhtNi4
          of "prod":
            dhtProd4
          of "sum":
            dhtSum4
          of "minus":
            dhtMinus4
          of "lowast":
            dhtLowast4
          of "radic":
            dhtRadic4
          of "prop":
            dhtProp4
          of "infin":
            dhtInfin4
          of "ang":
            dhtAng4
          of "and":
            dhtAnd4
          of "or":
            dhtOr4
          of "cap":
            dhtCap4
          of "cup":
            dhtCup4
          of "int":
            dhtInt4
          of "there4":
            dhtThere44
          of "sim":
            dhtSim4
          of "cong":
            dhtCong4
          of "asymp":
            dhtAsymp4
          of "ne":
            dhtNe4
          of "equiv":
            dhtEquiv4
          of "le":
            dhtLe4
          of "ge":
            dhtGe4
          of "sub":
            dhtSub4
          of "sup":
            dhtSup4
          of "nsub":
            dhtNsub4
          of "sube":
            dhtSube4
          of "supe":
            dhtSupe4
          of "oplus":
            dhtOplus4
          of "otimes":
            dhtOtimes4
          of "perp":
            dhtPerp4
          of "sdot":
            dhtSdot4
          of "lceil":
            dhtLceil4
          of "rceil":
            dhtRceil4
          of "lfloor":
            dhtLfloor4
          of "rfloor":
            dhtRfloor4
          of "lang":
            dhtLang4
          of "rang":
            dhtRang4
          of "loz":
            dhtLoz4
          of "spades":
            dhtSpades4
          of "clubs":
            dhtClubs4
          of "hearts":
            dhtHearts4
          of "diams":
            dhtDiams4
          of "OElig":
            dhtOElig8
          of "oelig":
            dhtOelig9
          of "Scaron":
            dhtScaron8
          of "scaron":
            dhtScaron9
          of "Yumlaut":
            dhtYumlaut9
          of "circ":
            dhtCirc4
          of "tilde":
            dhtTilde4
          of "ensp":
            dhtEnsp4
          of "emsp":
            dhtEmsp4
          of "thinsp":
            dhtThinsp4
          of "zwnj":
            dhtZwnj4
          of "zwj":
            dhtZwj4
          of "lrm":
            dhtLrm4
          of "rlm":
            dhtRlm4
          of "ndash":
            dhtNdash4
          of "mdash":
            dhtMdash4
          of "lsquo":
            dhtLsquo4
          of "rsquo":
            dhtRsquo4
          of "sbquo":
            dhtSbquo4
          of "ldquo":
            dhtLdquo4
          of "rdquo":
            dhtRdquo4
          of "bdquo":
            dhtBdquo4
          of "dagger":
            dhtDagger8
          of "Dagger":
            dhtDagger9
          of "permil":
            dhtPermil4
          of "lsaquo":
            dhtLsaquo4
          of "rsaquo":
            dhtRsaquo4
          of "euro":
            dhtEuro4
          of "tm":
            dhtTm4
          else:
            dhtLinebreak4
          var tmp: DocEmptyType
          parseDocEmptyType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocHeadingTypeBody(kind: kind)
          tmp2.docEmptyType = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocImageType*(target: var (seq[DocImageType] | DocImageType |
    Option[DocImageType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "type":
          parseDoxImageKind(target.fType, parser, "type")
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
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocImageTypeBody(kind: doitMixedStr24, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "ulink":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "ulink":
            doitUlink5
          else:
            doitUlink5
          var tmp: DocURLLink
          parseDocURLLink(tmp, parser, parser.elementName(), true)
          var tmp2 = DocImageTypeBody(kind: kind)
          tmp2.docURLLink = tmp
          add(target.xsdChoice, tmp2)
        of "bold", "s", "strike", "underline", "emphasis", "computeroutput",
           "subscript", "superscript", "center", "small", "del", "ins":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "bold":
            doitBold5
          of "s":
            doitS5
          of "strike":
            doitStrike5
          of "underline":
            doitUnderline5
          of "emphasis":
            doitEmphasis5
          of "computeroutput":
            doitComputeroutput5
          of "subscript":
            doitSubscript5
          of "superscript":
            doitSuperscript5
          of "center":
            doitCenter5
          of "small":
            doitSmall5
          of "del":
            doitDel5
          of "ins":
            doitIns5
          else:
            doitBold5
          var tmp: DocMarkupType
          parseDocMarkupType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocImageTypeBody(kind: kind)
          tmp2.docMarkupType = tmp
          add(target.xsdChoice, tmp2)
        of "htmlonly":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "htmlonly":
            doitHtmlonly5
          else:
            doitHtmlonly5
          var tmp: DocHtmlOnlyType
          parseDocHtmlOnlyType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocImageTypeBody(kind: kind)
          tmp2.docHtmlOnlyType = tmp
          add(target.xsdChoice, tmp2)
        of "manonly", "xmlonly", "rtfonly", "latexonly", "docbookonly":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "manonly":
            doitManonly5
          of "xmlonly":
            doitXmlonly5
          of "rtfonly":
            doitRtfonly5
          of "latexonly":
            doitLatexonly5
          of "docbookonly":
            doitDocbookonly5
          else:
            doitManonly5
          var tmp: string
          parseXsdString(tmp, parser, parser.elementName())
          var tmp2 = DocImageTypeBody(kind: kind)
          tmp2.string = tmp
          add(target.xsdChoice, tmp2)
        of "image", "dot", "msc", "plantuml":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "image":
            doitImage5
          of "dot":
            doitDot5
          of "msc":
            doitMsc5
          of "plantuml":
            doitPlantuml5
          else:
            doitImage5
          var tmp: DocImageType
          parseDocImageType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocImageTypeBody(kind: kind)
          tmp2.docImageType = tmp
          add(target.xsdChoice, tmp2)
        of "anchor":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "anchor":
            doitAnchor5
          else:
            doitAnchor5
          var tmp: DocAnchorType
          parseDocAnchorType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocImageTypeBody(kind: kind)
          tmp2.docAnchorType = tmp
          add(target.xsdChoice, tmp2)
        of "formula":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "formula":
            doitFormula5
          else:
            doitFormula5
          var tmp: DocFormulaType
          parseDocFormulaType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocImageTypeBody(kind: kind)
          tmp2.docFormulaType = tmp
          add(target.xsdChoice, tmp2)
        of "ref":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "ref":
            doitRef7
          else:
            doitRef7
          var tmp: DocRefTextType
          parseDocRefTextType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocImageTypeBody(kind: kind)
          tmp2.docRefTextType = tmp
          add(target.xsdChoice, tmp2)
        of "emoji":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "emoji":
            doitEmoji5
          else:
            doitEmoji5
          var tmp: DocEmojiType
          parseDocEmojiType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocImageTypeBody(kind: kind)
          tmp2.docEmojiType = tmp
          add(target.xsdChoice, tmp2)
        of "linebreak", "nonbreakablespace", "iexcl", "cent", "pound", "curren",
           "yen", "brvbar", "sect", "umlaut", "copy", "ordf", "laquo", "not",
           "shy", "registered", "macr", "deg", "plusmn", "sup2", "sup3",
           "acute", "micro", "para", "middot", "cedil", "sup1", "ordm", "raquo",
           "frac14", "frac12", "frac34", "iquest", "Agrave", "Aacute", "Acirc",
           "Atilde", "Aumlaut", "Aring", "AElig", "Ccedil", "Egrave", "Eacute",
           "Ecirc", "Eumlaut", "Igrave", "Iacute", "Icirc", "Iumlaut", "ETH",
           "Ntilde", "Ograve", "Oacute", "Ocirc", "Otilde", "Oumlaut", "times",
           "Oslash", "Ugrave", "Uacute", "Ucirc", "Uumlaut", "Yacute", "THORN",
           "szlig", "agrave", "aacute", "acirc", "atilde", "aumlaut", "aring",
           "aelig", "ccedil", "egrave", "eacute", "ecirc", "eumlaut", "igrave",
           "iacute", "icirc", "iumlaut", "eth", "ntilde", "ograve", "oacute",
           "ocirc", "otilde", "oumlaut", "divide", "oslash", "ugrave", "uacute",
           "ucirc", "uumlaut", "yacute", "thorn", "yumlaut", "fnof", "Alpha",
           "Beta", "Gamma", "Delta", "Epsilon", "Zeta", "Eta", "Theta", "Iota",
           "Kappa", "Lambda", "Mu", "Nu", "Xi", "Omicron", "Pi", "Rho", "Sigma",
           "Tau", "Upsilon", "Phi", "Chi", "Psi", "Omega", "alpha", "beta",
           "gamma", "delta", "epsilon", "zeta", "eta", "theta", "iota", "kappa",
           "lambda", "mu", "nu", "xi", "omicron", "pi", "rho", "sigmaf",
           "sigma", "tau", "upsilon", "phi", "chi", "psi", "omega", "thetasym",
           "upsih", "piv", "bull", "hellip", "prime", "Prime", "oline", "frasl",
           "weierp", "imaginary", "real", "trademark", "alefsym", "larr",
           "uarr", "rarr", "darr", "harr", "crarr", "lArr", "uArr", "rArr",
           "dArr", "hArr", "forall", "part", "exist", "empty", "nabla", "isin",
           "notin", "ni", "prod", "sum", "minus", "lowast", "radic", "prop",
           "infin", "ang", "and", "or", "cap", "cup", "int", "there4", "sim",
           "cong", "asymp", "ne", "equiv", "le", "ge", "sub", "sup", "nsub",
           "sube", "supe", "oplus", "otimes", "perp", "sdot", "lceil", "rceil",
           "lfloor", "rfloor", "lang", "rang", "loz", "spades", "clubs",
           "hearts", "diams", "OElig", "oelig", "Scaron", "scaron", "Yumlaut",
           "circ", "tilde", "ensp", "emsp", "thinsp", "zwnj", "zwj", "lrm",
           "rlm", "ndash", "mdash", "lsquo", "rsquo", "sbquo", "ldquo", "rdquo",
           "bdquo", "dagger", "Dagger", "permil", "lsaquo", "rsaquo", "euro",
           "tm":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "linebreak":
            doitLinebreak5
          of "nonbreakablespace":
            doitNonbreakablespace5
          of "iexcl":
            doitIexcl5
          of "cent":
            doitCent5
          of "pound":
            doitPound5
          of "curren":
            doitCurren5
          of "yen":
            doitYen5
          of "brvbar":
            doitBrvbar5
          of "sect":
            doitSect5
          of "umlaut":
            doitUmlaut5
          of "copy":
            doitCopy5
          of "ordf":
            doitOrdf5
          of "laquo":
            doitLaquo5
          of "not":
            doitNot5
          of "shy":
            doitShy5
          of "registered":
            doitRegistered5
          of "macr":
            doitMacr5
          of "deg":
            doitDeg5
          of "plusmn":
            doitPlusmn5
          of "sup2":
            doitSup25
          of "sup3":
            doitSup35
          of "acute":
            doitAcute5
          of "micro":
            doitMicro5
          of "para":
            doitPara13
          of "middot":
            doitMiddot5
          of "cedil":
            doitCedil5
          of "sup1":
            doitSup15
          of "ordm":
            doitOrdm5
          of "raquo":
            doitRaquo5
          of "frac14":
            doitFrac145
          of "frac12":
            doitFrac125
          of "frac34":
            doitFrac345
          of "iquest":
            doitIquest5
          of "Agrave":
            doitAgrave10
          of "Aacute":
            doitAacute10
          of "Acirc":
            doitAcirc10
          of "Atilde":
            doitAtilde10
          of "Aumlaut":
            doitAumlaut10
          of "Aring":
            doitAring10
          of "AElig":
            doitAElig10
          of "Ccedil":
            doitCcedil10
          of "Egrave":
            doitEgrave10
          of "Eacute":
            doitEacute10
          of "Ecirc":
            doitEcirc10
          of "Eumlaut":
            doitEumlaut10
          of "Igrave":
            doitIgrave10
          of "Iacute":
            doitIacute10
          of "Icirc":
            doitIcirc10
          of "Iumlaut":
            doitIumlaut10
          of "ETH":
            doitETH10
          of "Ntilde":
            doitNtilde10
          of "Ograve":
            doitOgrave10
          of "Oacute":
            doitOacute10
          of "Ocirc":
            doitOcirc10
          of "Otilde":
            doitOtilde10
          of "Oumlaut":
            doitOumlaut10
          of "times":
            doitTimes5
          of "Oslash":
            doitOslash10
          of "Ugrave":
            doitUgrave10
          of "Uacute":
            doitUacute10
          of "Ucirc":
            doitUcirc10
          of "Uumlaut":
            doitUumlaut10
          of "Yacute":
            doitYacute10
          of "THORN":
            doitTHORN10
          of "szlig":
            doitSzlig5
          of "agrave":
            doitAgrave11
          of "aacute":
            doitAacute11
          of "acirc":
            doitAcirc11
          of "atilde":
            doitAtilde11
          of "aumlaut":
            doitAumlaut11
          of "aring":
            doitAring11
          of "aelig":
            doitAelig11
          of "ccedil":
            doitCcedil11
          of "egrave":
            doitEgrave11
          of "eacute":
            doitEacute11
          of "ecirc":
            doitEcirc11
          of "eumlaut":
            doitEumlaut11
          of "igrave":
            doitIgrave11
          of "iacute":
            doitIacute11
          of "icirc":
            doitIcirc11
          of "iumlaut":
            doitIumlaut11
          of "eth":
            doitEth11
          of "ntilde":
            doitNtilde11
          of "ograve":
            doitOgrave11
          of "oacute":
            doitOacute11
          of "ocirc":
            doitOcirc11
          of "otilde":
            doitOtilde11
          of "oumlaut":
            doitOumlaut11
          of "divide":
            doitDivide5
          of "oslash":
            doitOslash11
          of "ugrave":
            doitUgrave11
          of "uacute":
            doitUacute11
          of "ucirc":
            doitUcirc11
          of "uumlaut":
            doitUumlaut11
          of "yacute":
            doitYacute11
          of "thorn":
            doitThorn11
          of "yumlaut":
            doitYumlaut10
          of "fnof":
            doitFnof5
          of "Alpha":
            doitAlpha10
          of "Beta":
            doitBeta10
          of "Gamma":
            doitGamma10
          of "Delta":
            doitDelta10
          of "Epsilon":
            doitEpsilon10
          of "Zeta":
            doitZeta10
          of "Eta":
            doitEta10
          of "Theta":
            doitTheta10
          of "Iota":
            doitIota10
          of "Kappa":
            doitKappa10
          of "Lambda":
            doitLambda10
          of "Mu":
            doitMu10
          of "Nu":
            doitNu10
          of "Xi":
            doitXi10
          of "Omicron":
            doitOmicron10
          of "Pi":
            doitPi10
          of "Rho":
            doitRho10
          of "Sigma":
            doitSigma10
          of "Tau":
            doitTau10
          of "Upsilon":
            doitUpsilon10
          of "Phi":
            doitPhi10
          of "Chi":
            doitChi10
          of "Psi":
            doitPsi10
          of "Omega":
            doitOmega10
          of "alpha":
            doitAlpha11
          of "beta":
            doitBeta11
          of "gamma":
            doitGamma11
          of "delta":
            doitDelta11
          of "epsilon":
            doitEpsilon11
          of "zeta":
            doitZeta11
          of "eta":
            doitEta11
          of "theta":
            doitTheta11
          of "iota":
            doitIota11
          of "kappa":
            doitKappa11
          of "lambda":
            doitLambda11
          of "mu":
            doitMu11
          of "nu":
            doitNu11
          of "xi":
            doitXi11
          of "omicron":
            doitOmicron11
          of "pi":
            doitPi11
          of "rho":
            doitRho11
          of "sigmaf":
            doitSigmaf5
          of "sigma":
            doitSigma11
          of "tau":
            doitTau11
          of "upsilon":
            doitUpsilon11
          of "phi":
            doitPhi11
          of "chi":
            doitChi11
          of "psi":
            doitPsi11
          of "omega":
            doitOmega11
          of "thetasym":
            doitThetasym5
          of "upsih":
            doitUpsih5
          of "piv":
            doitPiv5
          of "bull":
            doitBull5
          of "hellip":
            doitHellip5
          of "prime":
            doitPrime10
          of "Prime":
            doitPrime11
          of "oline":
            doitOline5
          of "frasl":
            doitFrasl5
          of "weierp":
            doitWeierp5
          of "imaginary":
            doitImaginary5
          of "real":
            doitReal5
          of "trademark":
            doitTrademark5
          of "alefsym":
            doitAlefsym5
          of "larr":
            doitLarr10
          of "uarr":
            doitUarr10
          of "rarr":
            doitRarr10
          of "darr":
            doitDarr10
          of "harr":
            doitHarr10
          of "crarr":
            doitCrarr5
          of "lArr":
            doitLArr11
          of "uArr":
            doitUArr11
          of "rArr":
            doitRArr11
          of "dArr":
            doitDArr11
          of "hArr":
            doitHArr11
          of "forall":
            doitForall5
          of "part":
            doitPart5
          of "exist":
            doitExist5
          of "empty":
            doitEmpty5
          of "nabla":
            doitNabla5
          of "isin":
            doitIsin5
          of "notin":
            doitNotin5
          of "ni":
            doitNi5
          of "prod":
            doitProd5
          of "sum":
            doitSum5
          of "minus":
            doitMinus5
          of "lowast":
            doitLowast5
          of "radic":
            doitRadic5
          of "prop":
            doitProp5
          of "infin":
            doitInfin5
          of "ang":
            doitAng5
          of "and":
            doitAnd5
          of "or":
            doitOr5
          of "cap":
            doitCap5
          of "cup":
            doitCup5
          of "int":
            doitInt5
          of "there4":
            doitThere45
          of "sim":
            doitSim5
          of "cong":
            doitCong5
          of "asymp":
            doitAsymp5
          of "ne":
            doitNe5
          of "equiv":
            doitEquiv5
          of "le":
            doitLe5
          of "ge":
            doitGe5
          of "sub":
            doitSub5
          of "sup":
            doitSup5
          of "nsub":
            doitNsub5
          of "sube":
            doitSube5
          of "supe":
            doitSupe5
          of "oplus":
            doitOplus5
          of "otimes":
            doitOtimes5
          of "perp":
            doitPerp5
          of "sdot":
            doitSdot5
          of "lceil":
            doitLceil5
          of "rceil":
            doitRceil5
          of "lfloor":
            doitLfloor5
          of "rfloor":
            doitRfloor5
          of "lang":
            doitLang5
          of "rang":
            doitRang5
          of "loz":
            doitLoz5
          of "spades":
            doitSpades5
          of "clubs":
            doitClubs5
          of "hearts":
            doitHearts5
          of "diams":
            doitDiams5
          of "OElig":
            doitOElig10
          of "oelig":
            doitOelig11
          of "Scaron":
            doitScaron10
          of "scaron":
            doitScaron11
          of "Yumlaut":
            doitYumlaut11
          of "circ":
            doitCirc5
          of "tilde":
            doitTilde5
          of "ensp":
            doitEnsp5
          of "emsp":
            doitEmsp5
          of "thinsp":
            doitThinsp5
          of "zwnj":
            doitZwnj5
          of "zwj":
            doitZwj5
          of "lrm":
            doitLrm5
          of "rlm":
            doitRlm5
          of "ndash":
            doitNdash5
          of "mdash":
            doitMdash5
          of "lsquo":
            doitLsquo5
          of "rsquo":
            doitRsquo5
          of "sbquo":
            doitSbquo5
          of "ldquo":
            doitLdquo5
          of "rdquo":
            doitRdquo5
          of "bdquo":
            doitBdquo5
          of "dagger":
            doitDagger10
          of "Dagger":
            doitDagger11
          of "permil":
            doitPermil5
          of "lsaquo":
            doitLsaquo5
          of "rsaquo":
            doitRsaquo5
          of "euro":
            doitEuro5
          of "tm":
            doitTm5
          else:
            doitLinebreak5
          var tmp: DocEmptyType
          parseDocEmptyType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocImageTypeBody(kind: kind)
          tmp2.docEmptyType = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocTocItemType*(target: var (seq[DocTocItemType] | DocTocItemType |
    Option[DocTocItemType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocTocItemTypeBody(kind: dtitMixedStr25, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "ulink":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "ulink":
            dtitUlink6
          else:
            dtitUlink6
          var tmp: DocURLLink
          parseDocURLLink(tmp, parser, parser.elementName(), true)
          var tmp2 = DocTocItemTypeBody(kind: kind)
          tmp2.docURLLink = tmp
          add(target.xsdChoice, tmp2)
        of "bold", "s", "strike", "underline", "emphasis", "computeroutput",
           "subscript", "superscript", "center", "small", "del", "ins":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "bold":
            dtitBold6
          of "s":
            dtitS6
          of "strike":
            dtitStrike6
          of "underline":
            dtitUnderline6
          of "emphasis":
            dtitEmphasis6
          of "computeroutput":
            dtitComputeroutput6
          of "subscript":
            dtitSubscript6
          of "superscript":
            dtitSuperscript6
          of "center":
            dtitCenter6
          of "small":
            dtitSmall6
          of "del":
            dtitDel6
          of "ins":
            dtitIns6
          else:
            dtitBold6
          var tmp: DocMarkupType
          parseDocMarkupType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocTocItemTypeBody(kind: kind)
          tmp2.docMarkupType = tmp
          add(target.xsdChoice, tmp2)
        of "htmlonly":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "htmlonly":
            dtitHtmlonly6
          else:
            dtitHtmlonly6
          var tmp: DocHtmlOnlyType
          parseDocHtmlOnlyType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocTocItemTypeBody(kind: kind)
          tmp2.docHtmlOnlyType = tmp
          add(target.xsdChoice, tmp2)
        of "manonly", "xmlonly", "rtfonly", "latexonly", "docbookonly":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "manonly":
            dtitManonly6
          of "xmlonly":
            dtitXmlonly6
          of "rtfonly":
            dtitRtfonly6
          of "latexonly":
            dtitLatexonly6
          of "docbookonly":
            dtitDocbookonly6
          else:
            dtitManonly6
          var tmp: string
          parseXsdString(tmp, parser, parser.elementName())
          var tmp2 = DocTocItemTypeBody(kind: kind)
          tmp2.string = tmp
          add(target.xsdChoice, tmp2)
        of "image", "dot", "msc", "plantuml":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "image":
            dtitImage6
          of "dot":
            dtitDot6
          of "msc":
            dtitMsc6
          of "plantuml":
            dtitPlantuml6
          else:
            dtitImage6
          var tmp: DocImageType
          parseDocImageType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocTocItemTypeBody(kind: kind)
          tmp2.docImageType = tmp
          add(target.xsdChoice, tmp2)
        of "anchor":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "anchor":
            dtitAnchor6
          else:
            dtitAnchor6
          var tmp: DocAnchorType
          parseDocAnchorType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocTocItemTypeBody(kind: kind)
          tmp2.docAnchorType = tmp
          add(target.xsdChoice, tmp2)
        of "formula":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "formula":
            dtitFormula6
          else:
            dtitFormula6
          var tmp: DocFormulaType
          parseDocFormulaType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocTocItemTypeBody(kind: kind)
          tmp2.docFormulaType = tmp
          add(target.xsdChoice, tmp2)
        of "ref":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "ref":
            dtitRef8
          else:
            dtitRef8
          var tmp: DocRefTextType
          parseDocRefTextType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocTocItemTypeBody(kind: kind)
          tmp2.docRefTextType = tmp
          add(target.xsdChoice, tmp2)
        of "emoji":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "emoji":
            dtitEmoji6
          else:
            dtitEmoji6
          var tmp: DocEmojiType
          parseDocEmojiType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocTocItemTypeBody(kind: kind)
          tmp2.docEmojiType = tmp
          add(target.xsdChoice, tmp2)
        of "linebreak", "nonbreakablespace", "iexcl", "cent", "pound", "curren",
           "yen", "brvbar", "sect", "umlaut", "copy", "ordf", "laquo", "not",
           "shy", "registered", "macr", "deg", "plusmn", "sup2", "sup3",
           "acute", "micro", "para", "middot", "cedil", "sup1", "ordm", "raquo",
           "frac14", "frac12", "frac34", "iquest", "Agrave", "Aacute", "Acirc",
           "Atilde", "Aumlaut", "Aring", "AElig", "Ccedil", "Egrave", "Eacute",
           "Ecirc", "Eumlaut", "Igrave", "Iacute", "Icirc", "Iumlaut", "ETH",
           "Ntilde", "Ograve", "Oacute", "Ocirc", "Otilde", "Oumlaut", "times",
           "Oslash", "Ugrave", "Uacute", "Ucirc", "Uumlaut", "Yacute", "THORN",
           "szlig", "agrave", "aacute", "acirc", "atilde", "aumlaut", "aring",
           "aelig", "ccedil", "egrave", "eacute", "ecirc", "eumlaut", "igrave",
           "iacute", "icirc", "iumlaut", "eth", "ntilde", "ograve", "oacute",
           "ocirc", "otilde", "oumlaut", "divide", "oslash", "ugrave", "uacute",
           "ucirc", "uumlaut", "yacute", "thorn", "yumlaut", "fnof", "Alpha",
           "Beta", "Gamma", "Delta", "Epsilon", "Zeta", "Eta", "Theta", "Iota",
           "Kappa", "Lambda", "Mu", "Nu", "Xi", "Omicron", "Pi", "Rho", "Sigma",
           "Tau", "Upsilon", "Phi", "Chi", "Psi", "Omega", "alpha", "beta",
           "gamma", "delta", "epsilon", "zeta", "eta", "theta", "iota", "kappa",
           "lambda", "mu", "nu", "xi", "omicron", "pi", "rho", "sigmaf",
           "sigma", "tau", "upsilon", "phi", "chi", "psi", "omega", "thetasym",
           "upsih", "piv", "bull", "hellip", "prime", "Prime", "oline", "frasl",
           "weierp", "imaginary", "real", "trademark", "alefsym", "larr",
           "uarr", "rarr", "darr", "harr", "crarr", "lArr", "uArr", "rArr",
           "dArr", "hArr", "forall", "part", "exist", "empty", "nabla", "isin",
           "notin", "ni", "prod", "sum", "minus", "lowast", "radic", "prop",
           "infin", "ang", "and", "or", "cap", "cup", "int", "there4", "sim",
           "cong", "asymp", "ne", "equiv", "le", "ge", "sub", "sup", "nsub",
           "sube", "supe", "oplus", "otimes", "perp", "sdot", "lceil", "rceil",
           "lfloor", "rfloor", "lang", "rang", "loz", "spades", "clubs",
           "hearts", "diams", "OElig", "oelig", "Scaron", "scaron", "Yumlaut",
           "circ", "tilde", "ensp", "emsp", "thinsp", "zwnj", "zwj", "lrm",
           "rlm", "ndash", "mdash", "lsquo", "rsquo", "sbquo", "ldquo", "rdquo",
           "bdquo", "dagger", "Dagger", "permil", "lsaquo", "rsaquo", "euro",
           "tm":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "linebreak":
            dtitLinebreak6
          of "nonbreakablespace":
            dtitNonbreakablespace6
          of "iexcl":
            dtitIexcl6
          of "cent":
            dtitCent6
          of "pound":
            dtitPound6
          of "curren":
            dtitCurren6
          of "yen":
            dtitYen6
          of "brvbar":
            dtitBrvbar6
          of "sect":
            dtitSect6
          of "umlaut":
            dtitUmlaut6
          of "copy":
            dtitCopy6
          of "ordf":
            dtitOrdf6
          of "laquo":
            dtitLaquo6
          of "not":
            dtitNot6
          of "shy":
            dtitShy6
          of "registered":
            dtitRegistered6
          of "macr":
            dtitMacr6
          of "deg":
            dtitDeg6
          of "plusmn":
            dtitPlusmn6
          of "sup2":
            dtitSup26
          of "sup3":
            dtitSup36
          of "acute":
            dtitAcute6
          of "micro":
            dtitMicro6
          of "para":
            dtitPara14
          of "middot":
            dtitMiddot6
          of "cedil":
            dtitCedil6
          of "sup1":
            dtitSup16
          of "ordm":
            dtitOrdm6
          of "raquo":
            dtitRaquo6
          of "frac14":
            dtitFrac146
          of "frac12":
            dtitFrac126
          of "frac34":
            dtitFrac346
          of "iquest":
            dtitIquest6
          of "Agrave":
            dtitAgrave12
          of "Aacute":
            dtitAacute12
          of "Acirc":
            dtitAcirc12
          of "Atilde":
            dtitAtilde12
          of "Aumlaut":
            dtitAumlaut12
          of "Aring":
            dtitAring12
          of "AElig":
            dtitAElig12
          of "Ccedil":
            dtitCcedil12
          of "Egrave":
            dtitEgrave12
          of "Eacute":
            dtitEacute12
          of "Ecirc":
            dtitEcirc12
          of "Eumlaut":
            dtitEumlaut12
          of "Igrave":
            dtitIgrave12
          of "Iacute":
            dtitIacute12
          of "Icirc":
            dtitIcirc12
          of "Iumlaut":
            dtitIumlaut12
          of "ETH":
            dtitETH12
          of "Ntilde":
            dtitNtilde12
          of "Ograve":
            dtitOgrave12
          of "Oacute":
            dtitOacute12
          of "Ocirc":
            dtitOcirc12
          of "Otilde":
            dtitOtilde12
          of "Oumlaut":
            dtitOumlaut12
          of "times":
            dtitTimes6
          of "Oslash":
            dtitOslash12
          of "Ugrave":
            dtitUgrave12
          of "Uacute":
            dtitUacute12
          of "Ucirc":
            dtitUcirc12
          of "Uumlaut":
            dtitUumlaut12
          of "Yacute":
            dtitYacute12
          of "THORN":
            dtitTHORN12
          of "szlig":
            dtitSzlig6
          of "agrave":
            dtitAgrave13
          of "aacute":
            dtitAacute13
          of "acirc":
            dtitAcirc13
          of "atilde":
            dtitAtilde13
          of "aumlaut":
            dtitAumlaut13
          of "aring":
            dtitAring13
          of "aelig":
            dtitAelig13
          of "ccedil":
            dtitCcedil13
          of "egrave":
            dtitEgrave13
          of "eacute":
            dtitEacute13
          of "ecirc":
            dtitEcirc13
          of "eumlaut":
            dtitEumlaut13
          of "igrave":
            dtitIgrave13
          of "iacute":
            dtitIacute13
          of "icirc":
            dtitIcirc13
          of "iumlaut":
            dtitIumlaut13
          of "eth":
            dtitEth13
          of "ntilde":
            dtitNtilde13
          of "ograve":
            dtitOgrave13
          of "oacute":
            dtitOacute13
          of "ocirc":
            dtitOcirc13
          of "otilde":
            dtitOtilde13
          of "oumlaut":
            dtitOumlaut13
          of "divide":
            dtitDivide6
          of "oslash":
            dtitOslash13
          of "ugrave":
            dtitUgrave13
          of "uacute":
            dtitUacute13
          of "ucirc":
            dtitUcirc13
          of "uumlaut":
            dtitUumlaut13
          of "yacute":
            dtitYacute13
          of "thorn":
            dtitThorn13
          of "yumlaut":
            dtitYumlaut12
          of "fnof":
            dtitFnof6
          of "Alpha":
            dtitAlpha12
          of "Beta":
            dtitBeta12
          of "Gamma":
            dtitGamma12
          of "Delta":
            dtitDelta12
          of "Epsilon":
            dtitEpsilon12
          of "Zeta":
            dtitZeta12
          of "Eta":
            dtitEta12
          of "Theta":
            dtitTheta12
          of "Iota":
            dtitIota12
          of "Kappa":
            dtitKappa12
          of "Lambda":
            dtitLambda12
          of "Mu":
            dtitMu12
          of "Nu":
            dtitNu12
          of "Xi":
            dtitXi12
          of "Omicron":
            dtitOmicron12
          of "Pi":
            dtitPi12
          of "Rho":
            dtitRho12
          of "Sigma":
            dtitSigma12
          of "Tau":
            dtitTau12
          of "Upsilon":
            dtitUpsilon12
          of "Phi":
            dtitPhi12
          of "Chi":
            dtitChi12
          of "Psi":
            dtitPsi12
          of "Omega":
            dtitOmega12
          of "alpha":
            dtitAlpha13
          of "beta":
            dtitBeta13
          of "gamma":
            dtitGamma13
          of "delta":
            dtitDelta13
          of "epsilon":
            dtitEpsilon13
          of "zeta":
            dtitZeta13
          of "eta":
            dtitEta13
          of "theta":
            dtitTheta13
          of "iota":
            dtitIota13
          of "kappa":
            dtitKappa13
          of "lambda":
            dtitLambda13
          of "mu":
            dtitMu13
          of "nu":
            dtitNu13
          of "xi":
            dtitXi13
          of "omicron":
            dtitOmicron13
          of "pi":
            dtitPi13
          of "rho":
            dtitRho13
          of "sigmaf":
            dtitSigmaf6
          of "sigma":
            dtitSigma13
          of "tau":
            dtitTau13
          of "upsilon":
            dtitUpsilon13
          of "phi":
            dtitPhi13
          of "chi":
            dtitChi13
          of "psi":
            dtitPsi13
          of "omega":
            dtitOmega13
          of "thetasym":
            dtitThetasym6
          of "upsih":
            dtitUpsih6
          of "piv":
            dtitPiv6
          of "bull":
            dtitBull6
          of "hellip":
            dtitHellip6
          of "prime":
            dtitPrime12
          of "Prime":
            dtitPrime13
          of "oline":
            dtitOline6
          of "frasl":
            dtitFrasl6
          of "weierp":
            dtitWeierp6
          of "imaginary":
            dtitImaginary6
          of "real":
            dtitReal6
          of "trademark":
            dtitTrademark6
          of "alefsym":
            dtitAlefsym6
          of "larr":
            dtitLarr12
          of "uarr":
            dtitUarr12
          of "rarr":
            dtitRarr12
          of "darr":
            dtitDarr12
          of "harr":
            dtitHarr12
          of "crarr":
            dtitCrarr6
          of "lArr":
            dtitLArr13
          of "uArr":
            dtitUArr13
          of "rArr":
            dtitRArr13
          of "dArr":
            dtitDArr13
          of "hArr":
            dtitHArr13
          of "forall":
            dtitForall6
          of "part":
            dtitPart6
          of "exist":
            dtitExist6
          of "empty":
            dtitEmpty6
          of "nabla":
            dtitNabla6
          of "isin":
            dtitIsin6
          of "notin":
            dtitNotin6
          of "ni":
            dtitNi6
          of "prod":
            dtitProd6
          of "sum":
            dtitSum6
          of "minus":
            dtitMinus6
          of "lowast":
            dtitLowast6
          of "radic":
            dtitRadic6
          of "prop":
            dtitProp6
          of "infin":
            dtitInfin6
          of "ang":
            dtitAng6
          of "and":
            dtitAnd6
          of "or":
            dtitOr6
          of "cap":
            dtitCap6
          of "cup":
            dtitCup6
          of "int":
            dtitInt6
          of "there4":
            dtitThere46
          of "sim":
            dtitSim6
          of "cong":
            dtitCong6
          of "asymp":
            dtitAsymp6
          of "ne":
            dtitNe6
          of "equiv":
            dtitEquiv6
          of "le":
            dtitLe6
          of "ge":
            dtitGe6
          of "sub":
            dtitSub6
          of "sup":
            dtitSup6
          of "nsub":
            dtitNsub6
          of "sube":
            dtitSube6
          of "supe":
            dtitSupe6
          of "oplus":
            dtitOplus6
          of "otimes":
            dtitOtimes6
          of "perp":
            dtitPerp6
          of "sdot":
            dtitSdot6
          of "lceil":
            dtitLceil6
          of "rceil":
            dtitRceil6
          of "lfloor":
            dtitLfloor6
          of "rfloor":
            dtitRfloor6
          of "lang":
            dtitLang6
          of "rang":
            dtitRang6
          of "loz":
            dtitLoz6
          of "spades":
            dtitSpades6
          of "clubs":
            dtitClubs6
          of "hearts":
            dtitHearts6
          of "diams":
            dtitDiams6
          of "OElig":
            dtitOElig12
          of "oelig":
            dtitOelig13
          of "Scaron":
            dtitScaron12
          of "scaron":
            dtitScaron13
          of "Yumlaut":
            dtitYumlaut13
          of "circ":
            dtitCirc6
          of "tilde":
            dtitTilde6
          of "ensp":
            dtitEnsp6
          of "emsp":
            dtitEmsp6
          of "thinsp":
            dtitThinsp6
          of "zwnj":
            dtitZwnj6
          of "zwj":
            dtitZwj6
          of "lrm":
            dtitLrm6
          of "rlm":
            dtitRlm6
          of "ndash":
            dtitNdash6
          of "mdash":
            dtitMdash6
          of "lsquo":
            dtitLsquo6
          of "rsquo":
            dtitRsquo6
          of "sbquo":
            dtitSbquo6
          of "ldquo":
            dtitLdquo6
          of "rdquo":
            dtitRdquo6
          of "bdquo":
            dtitBdquo6
          of "dagger":
            dtitDagger12
          of "Dagger":
            dtitDagger13
          of "permil":
            dtitPermil6
          of "lsaquo":
            dtitLsaquo6
          of "rsaquo":
            dtitRsaquo6
          of "euro":
            dtitEuro6
          of "tm":
            dtitTm6
          else:
            dtitLinebreak6
          var tmp: DocEmptyType
          parseDocEmptyType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocTocItemTypeBody(kind: kind)
          tmp2.docEmptyType = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocTocListType*(target: var (seq[DocTocListType] | DocTocListType |
    Option[DocTocListType]); parser: var HXmlParser; tag: string;
                          inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "tocitem":
          ## 633:48:xml_to_types.nim
          parseDocTocItemType(target.tocitem, parser, "tocitem", false)
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


proc parseDocLanguageType*(target: var (seq[DocLanguageType] | DocLanguageType |
    Option[DocLanguageType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "langid":
          parseXsdString(target.langid, parser, "langid")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "para":
          ## 633:48:xml_to_types.nim
          parseDocParaType(target.para, parser, "para", false)
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


proc parseDocParamListType*(target: var (
    seq[DocParamListType] | DocParamListType | Option[DocParamListType]);
                            parser: var HXmlParser; tag: string;
                            inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "kind":
          parseDoxParamListKind(target.kind, parser, "kind")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "parameteritem":
          ## 633:48:xml_to_types.nim
          parseDocParamListItem(target.parameteritem, parser, "parameteritem",
                                false)
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


proc parseDocParamListItem*(target: var (
    seq[DocParamListItem] | DocParamListItem | Option[DocParamListItem]);
                            parser: var HXmlParser; tag: string;
                            inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "parameternamelist":
          ## 633:48:xml_to_types.nim
          parseDocParamNameList(target.parameternamelist, parser,
                                "parameternamelist", false)
        of "parameterdescription":
          ## 633:48:xml_to_types.nim
          parseDescriptionType(target.parameterdescription, parser,
                               "parameterdescription", false)
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


proc parseDocParamNameList*(target: var (
    seq[DocParamNameList] | DocParamNameList | Option[DocParamNameList]);
                            parser: var HXmlParser; tag: string;
                            inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "parametertype":
          ## 633:48:xml_to_types.nim
          parseDocParamType(target.parametertype, parser, "parametertype", false)
        of "parametername":
          ## 633:48:xml_to_types.nim
          parseDocParamName(target.parametername, parser, "parametername", false)
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


proc parseDocParamType*(target: var (seq[DocParamType] | DocParamType |
    Option[DocParamType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocParamTypeBody(kind: doptMixedStr26, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "ref":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "ref":
            doptRef9
          else:
            doptRef9
          var tmp: RefTextType
          parseRefTextType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocParamTypeBody(kind: kind)
          tmp2.refTextType = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocParamName*(target: var (seq[DocParamName] | DocParamName |
    Option[DocParamName]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "direction":
          parseDoxParamDir(target.direction, parser, "direction")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of xmlCharData:
        ## 597:10:xml_to_types.nim
        var tmp: string
        parseXsdString(tmp, parser, "")
        add(target.xsdChoice,
            DocParamNameBody(kind: dpnMixedStr27, mixedStr: tmp))
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "ref":
          ## 575:8:xml_to_types.nim
          let kind = case parser.elementName()
          of "ref":
            dpnRef10
          else:
            dpnRef10
          var tmp: RefTextType
          parseRefTextType(tmp, parser, parser.elementName(), true)
          var tmp2 = DocParamNameBody(kind: kind)
          tmp2.refTextType = tmp
          add(target.xsdChoice, tmp2)
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
      of {xmlError, xmlEof, xmlWhitespace, xmlComment, xmlPI, xmlCData,
          xmlEntity, xmlSpecial}:
        ## 662:6:xml_to_types.nim
        echo parser.displayAt()
        assert false


proc parseDocXRefSectType*(target: var (seq[DocXRefSectType] | DocXRefSectType |
    Option[DocXRefSectType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "id":
          parseXsdString(target.id, parser, "id")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "xreftitle":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "xreftitle")
          parseXsdString(target.xreftitle, parser, "xreftitle")
          skipElementEnd(parser, "xreftitle")
        of "xrefdescription":
          ## 633:48:xml_to_types.nim
          parseDescriptionType(target.xrefdescription, parser,
                               "xrefdescription", false)
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


proc parseDocCopyType*(target: var (seq[DocCopyType] | DocCopyType |
    Option[DocCopyType]); parser: var HXmlParser; tag: string;
                       inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "link":
          parseXsdString(target.link, parser, "link")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "para":
          ## 633:48:xml_to_types.nim
          parseDocParaType(target.para, parser, "para", false)
        of "sect1":
          ## 633:48:xml_to_types.nim
          parseDocSect1Type(target.sect1, parser, "sect1", false)
        of "internal":
          ## 633:48:xml_to_types.nim
          parseDocInternalType(target.internal, parser, "internal", false)
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


proc parseDocBlockQuoteType*(target: var (
    seq[DocBlockQuoteType] | DocBlockQuoteType | Option[DocBlockQuoteType]);
                             parser: var HXmlParser; tag: string;
                             inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "para":
          ## 633:48:xml_to_types.nim
          parseDocParaType(target.para, parser, "para", false)
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


proc parseDocParBlockType*(target: var (seq[DocParBlockType] | DocParBlockType |
    Option[DocParBlockType]); parser: var HXmlParser; tag: string;
                           inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "para":
          ## 633:48:xml_to_types.nim
          parseDocParaType(target.para, parser, "para", false)
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


proc parseDocEmptyType*(target: var (seq[DocEmptyType] | DocEmptyType |
    Option[DocEmptyType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
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


proc parseTableofcontentsType*(target: var (seq[TableofcontentsType] |
    TableofcontentsType |
    Option[TableofcontentsType]); parser: var HXmlParser; tag: string;
                               inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
        of "tocsect":
          ## 633:48:xml_to_types.nim
          parseTableofcontentsKindType(target.tocsect, parser, "tocsect", false)
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


proc parseTableofcontentsKindType*(target: var (seq[TableofcontentsKindType] |
    TableofcontentsKindType |
    Option[TableofcontentsKindType]); parser: var HXmlParser; tag: string;
                                   inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
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
        of "reference":
          ## 633:48:xml_to_types.nim
          skipElementStart(parser, "reference")
          parseXsdString(target.reference, parser, "reference")
          skipElementEnd(parser, "reference")
        of "tableofcontents":
          ## 633:48:xml_to_types.nim
          parseTableofcontentsType(target.tableofcontents, parser,
                                   "tableofcontents", false)
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


proc parseDocEmojiType*(target: var (seq[DocEmojiType] | DocEmojiType |
    Option[DocEmojiType]); parser: var HXmlParser; tag: string;
                        inMixed: bool = false) =
  ## 669:4:xml_to_types.nim
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
    next(parser)
    while true:
      case parser.kind
      of xmlAttribute:
        case parser.attrKey
        of "name":
          parseXsdString(target.name, parser, "name")
        of "unicode":
          parseXsdString(target.unicode, parser, "unicode")
        else:
          ## 520:4:xml_to_types.nim
          if not(startsWith(parser.attrKey(), ["xmlns:", "xsi:", "xml:"])):
            raiseUnexpectedAttribute(parser)
        parser.next()
      of {xmlElementStart, xmlElementOpen}:
        case parser.elementName()
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


proc parseDoxBool*(target: var (seq[DoxBool] | DoxBool | Option[DoxBool]);
                   parser: var HXmlParser; tag: string) =
  ## 715:4:xml_to_types.nim
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
  ## 715:4:xml_to_types.nim
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
  ## 715:4:xml_to_types.nim
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
  ## 715:4:xml_to_types.nim
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
  ## 715:4:xml_to_types.nim
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
  ## 715:4:xml_to_types.nim
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
  ## 715:4:xml_to_types.nim
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
  ## 715:4:xml_to_types.nim
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
  ## 715:4:xml_to_types.nim
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
  ## 715:4:xml_to_types.nim
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
  ## 715:4:xml_to_types.nim
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
  ## 715:4:xml_to_types.nim
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
  ## 748:4:xml_to_types.nim
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
  ## 715:4:xml_to_types.nim
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
  ## 715:4:xml_to_types.nim
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
  ## 748:4:xml_to_types.nim
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
  ## 715:4:xml_to_types.nim
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
  ## 715:4:xml_to_types.nim
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
  ## 715:4:xml_to_types.nim
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
  ## 715:4:xml_to_types.nim
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
