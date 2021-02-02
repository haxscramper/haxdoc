import haxdoc/[docentry, compiler_aux]
import std/[streams, json, strformat, strutils, sequtils, sugar]
import haxorg/[semorg, exporter_json, parser, ast, exporter_plaintext]

import hmisc/other/[colorlogger, oswrap, hjson]
import hmisc/helpers
import hmisc/types/[colortext, colorstring]
import hmisc/algo/htree_mapping
import hnimast


type
  DocContext = ref object of PPassContext
    db*: DocDB
    module*: PSym
    graph*: ModuleGraph

proc toJson*(doctype: DocType): JsonNode =
  toJson(doctype[])

# proc toJson*(doctext: DocText): JsonNode =
#   toJson(SemOrg(doctext))

proc toJson*(entry: DocEntry): JsonNode =
  result = toJson(entry[], @["doctextBriefPlain"])
  result["doctextBriefPlain"] = newJString(entry.doctextBriefPlain)

proc writeJson*(db: DocDB, target: AnyFile) =
  var buf: JsonNode = newJArray()
  for entry in db.entries:
    buf.add toJson(entry)

  let res = toPretty(buf, 100)
  echo res

  target.writeFile(res)


proc toDocType*(nt: NType[PNode]): DocType

proc toDocIdents*(idents: seq[NIdentDefs[PNode]]): seq[DocIdent] =
  for group in idents:
    for ident in group.idents:
      result.add DocIdent(
        ident: $ident,
        kind: group.kind,
        vtype: toDocType(group.vtype)
      )

proc toDocType*(nt: NType[PNode]): DocType =
  result = DocType(kind: nt.kind)
  case nt.kind:
    of ntkIdent, ntkGenericSpec, ntkAnonTuple:
      result.head = $nt.head
      result.genParams = nt.genParams.mapIt(toDocType(it))

    of ntkProc, ntkNamedTuple:
      result.returnType = nt.returnType.mapSomeIt(toDocType(it))
      result.arguments = nt.arguments.toDocIdents()
      result.pragma = $nt.pragma.toNNode()

    of ntkRange:
      result.rngStart = $nt.rngStart
      result.rngEnd = $nt.rngEnd

    of ntkValue:
      result.value = $nt.value

    of ntkVarargs:
      result.vaType = toDocType(nt.vaType)
      result.vaConverter = nt.vaConverter.mapSomeIt($it)

    of ntkNone:
      discard

proc toSigText*(nt: DocType, procPrefix: string = "proc"): string

proc toSigText*(nt: DocIdent): string =
  &"{nt.ident}: {toSigText(nt.vtype)}"

proc toSigText*(nt: DocType, procPrefix: string = "proc"): string =
  case nt.kind:
    of ntkNone:
      result = ""

    of ntkValue:
      result = $nt.value

    of ntkVarargs:
      result = "varargs[" & toSigText(nt.vaType)
      if nt.vaConverter.isSome():
        result &= ", " & nt.vaConverter.get()

      result &= "]"


    of ntkIdent:
      if nt.genParams.len > 0:
        result = nt.head & "[" & nt.genParams.mapIt(
          toSigText(it)).join(", ") & "]"

      else:
        result = nt.head

    of ntkGenericSpec:
      if nt.genParams.len > 0:
        result = nt.head & ": " & nt.genParams.mapIt(
          toSigText(it)).join(" | ")

      else:
        result = nt.head

    of ntkProc:
        let pragma: string = tern(nt.pragma.len > 0, nt.pragma & " ", "")
        let args: string = nt.arguments.mapIt(toSigText(it)).join(", ")
        let rtype: string = nt.returnType.getSomeIt(toSigText(it) & ": ", "")
        result = &"{procPrefix}({args}){pragma}{rtype}"

    of ntkAnonTuple:
      result = nt.genParams.mapIt(toSigText(it)).join(", ").wrap("()")

    of ntkNamedTuple:
      let args = collect(newSeq):
        for arg in nt.arguments:
          arg.ident & ": " & toSigText(arg.vtype)

      result = args.join(", ").wrap(("tuple[", "]"))

    of ntkRange:
      result = &"range[{nt.rngStart}..{nt.rngEnd}]"

proc registerTopLevel(ctx: DocContext, n: PNode) =
  case n.kind:
    of nkProcDef:
      echo treeRepr(n)
      let parsed = parseProc(n)
      let node = parseOrg(parsed.docComment)

      echo treeRepr(node)
      var semNode = toSemOrgDocument(node)

      var admonitions: seq[(OrgBigIdentKind, SemOrg)]
      var metatags: seq[(SemMetaTag, SemOrg)]
      var doctext: seq[SemOrg]

      for elem in items(semNode[0]):
        case elem.kind:
          of onkList:
            var otherItems: seq[SemOrg]
            for item in items(elem):
              if item.itemTag.isSome():
                let itemTag = item.itemTag.get()
                case itemTag.kind:
                  of sitMeta:
                    metatags.add (itemTag.meta, onkStmtList.newSemOrg(
                      item["header"], item["body"]))

                  of sitBigIdent:
                    admonitions.add (itemTag.idKind, onkStmtList.newSemOrg(
                      item["header"], item["body"]))

                  of sitText:
                    otherItems.add item

              else:
                otherItems.add item

            if otherItems.len > 0:
              doctext.add onkList.newSemOrg(otherItems)

          else:
            doctext.add elem



      let sign = toDocType(parsed.signature)
      var decl = DocEntry(
        plainName: parsed.name,
        kind: dekProc,
        doctextBrief: tern(
          doctext.len > 0,
          onkStmtList.newSemOrg(doctext[0]),
          onkemptyNode.newSemorg()
        ),
        doctextBody: tern(
          doctext.len > 1,
          onkStmtList.newSemOrg(doctext[1..^1]),
          onkEmptyNode.newSemorg()
        ),
        admonitions: admonitions,
        prSigText: toSigText(
          sign,
          (
            case parsed.declType:
              of ptkProc: "proc"
              of ptkFunc: "func"
              of ptkIterator: "iterator"
              of ptkConverter: "converter"
              of ptkMethod: "method"
              of ptkTemplate: "template"
              of ptkMacro: "macro"

          ) & " " & parsed.name
        ),
        prSigTree: sign
      )

      exportTo(OrgPlaintextExporter(),
               decl.doctextBrief,
               decl.doctextBriefPlain)

      ctx[].db.entries.add decl



    else:
      discard

when isMainModule:
  startColorLogger()

  let file = AbsFile("/tmp/intest.nim")
  file.writeFile("""

proc hhh(arg: int) =
  ## Documentation for hhh
  ## - NOTE :: prints out "123"
  ## - @effect{IOEffect} :: Use stdout
  echo "123"

proc secondProc() =
  ## Brief documentation for proc
  echo "123"

hhh(123)

""")


  var graph = newModuleGraph(file)
  graph.registerPass(semPass)

  var db = DocDB()

  graph.registerPass(makePass(
    (
      proc(graph: ModuleGraph, module: PSym): PPassContext =
        var context = DocContext(db: db)

        context.module = module
        context.graph = graph

        return context
    ),
    (
      proc(c: PPassContext, n: PNode): PNode =
        result = n
        var ctx = DocContext(c)

        if sfMainModule in ctx.module.flags:
          registerToplevel(ctx, n)
    ),
    (
      proc(graph: ModuleGraph; p: PPassContext, n: PNode): PNode =
        discard
    )
  ))

  compileProject(graph)

  db.writeJson(RelFile("doc.json"))
