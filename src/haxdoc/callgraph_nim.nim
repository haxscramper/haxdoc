proc createCallgraph(infile: AbsFile, stdpath: AbsDir, outfile: AbsFile) =
  debug "Creating callgrahp"
  var graph {.global.}: ModuleGraph
  graph = newModuleGraph(infile, stdpath,
    proc(config: ConfigRef; info: TLineInfo; msg: string; level: Severity) =
      err msg
      err info, config.getFilePath(info)
  )
  graph.registerPass(semPass)

  var dotGraph {.global.}: DotGraph
  var knownSyms {.global.}: HashSet[Hash]
  var knownPairs {.global.}: HashSet[(Hash, Hash)]

  dotGraph.styleNode = makeRectConsolasNode()
  dotGraph.rankdir = grdLeftRight

  proc registerSym(sym: PSym): Hash {.nimcall.} =
    result = hash(sigHash(sym).MD5Digest)
    if result notin knownSyms:
      knownSyms.incl result

      let procDecl = parseProc(sym.ast)
      let sigText = toDocType(procDecl.signature).toSigText(procDecl.name)
      dotGraph.addNode makeDotNode(result, sigText)

  proc registerCalls(topId: Hash, node: PNode) {.nimcall.} =
    case node.kind:
      of nkProcDeclKinds:
        registerCalls(topId, node[6])

      of nkSym:
        if notNil(node.sym.ast) and
           node.sym.ast.kind in nkProcDeclKinds:
          let toHash = registerSym(node.sym)

          if (topId, toHash) notin knownPairs:
            dotGraph.addEdge makeDotEdge(topId, toHash)
            knownPairs.incl (topId, toHash)

      of nkTokenKinds - {nkSym}:
        discard

      else:
        for subnode in items(node):
          registerCalls(topId, subnode)

  graph.registerPass(makePass(
    (
      proc(graph: ModuleGraph, module: PSym): PPassContext {.nimcall.} =
        return PPassContext()
    ),
    (
      proc(c: PPassContext, n: PNode): PNode {.nimcall.} =
        result = n
        if n.kind in nkProcDeclKinds:
          registerCalls(registerSym(n[0].sym), n)
    ),
    (
      proc(graph: ModuleGraph; p: PPassContext, n: PNode): PNode {.nimcall.} =
        discard
    )
  ))

  compileProject(graph)
  info "Callgraph compilation ok"

  let target = outfile.withExt("xdot")
  dotGraph.toXDot(target)
  info "Graphviz compilation ok"
  debug "Image saved to", target
