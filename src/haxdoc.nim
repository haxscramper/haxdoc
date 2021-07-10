import
  hmisc/preludes/cli_app,
  hmisc/helpers

import
  hnimast/[nimble_aux, compiler_aux]

import
  ./haxdoc/extract/from_nim_code,
  ./haxdoc/generate/sourcetrail_db,
  ./haxdoc/[docentry_io, docentry]

startHax()

proc addNimCmd(app: var CliApp) =
  var cmd = cmd("nim", "Process nim code")
  cmd.add opt(
    "define", "Define nim compilation symbol",
    alt = @["d"],
    default = toCliValue(newSeq[string]()).cliDefault(),
    check = cliCheckFor(string),
    maxRepeat = high(int)
  )

  cmd.add opt(
    "stdpath", "Location of the nim standard library",
    default = toCliValue(getStdPath(), "choosenim stdlib installation").cliDefault(),
    check = checkDirExists()
  )

  block:
    var trail = cmd("trail", "Generate sourcetrail database")
    trail.add arg("file", "Main nim file", check = checkAnd(
      checkFileReadable(),
      checkExtensions({
        "nim", "nims": "Generate database for file and it's imports",
        "nimble": "Generate database for a full project and dependencies"
      })
    ))

    trail.add flag(
      "launch", "Automatically launch `sourcetrail` when project is completed")

    trail.add opt(
      "outdir", "Directory to write sourcetrail database files.",
      default = cliDefaultFromArg(
        "file", "new '/haxdoc' directory for <file> parent dir",
        proc(val: CliValue): CliValue = toCliValue(
          val.as(FsFile).dir() / RelDir("haxdoc"))))

    cmd.add trail

  block:
    cmd.add cmd("xml", "Generate xml database", [
      arg("file", "Main nim file", check = checkFileReadable()),
      opt(
        "outdir",
        "Directory to write XML database to",
        check = checkDirCreatable(),
        default = cliDefaultFromArg(
          "file", "new '/haxdoc' directory for <file> parent dir",
          proc(val: CliValue): CliValue =
            result = toCliValue(val.as(FsFile).dir() / RelDir("haxdoc"))
            echo result.kind))])

  block:
    var project = cmd("project", "Generate documentation for a project")
    project.add arg("project", "Project directory or input file", check = checkOr(
      checkDirExists(),
      checkFileReadable()
    ))

    cmd.add project

  app.root.add cmd

proc addDiffCmd*(app: var CliApp) =
  app.add cmd("diff", "Compare two documentation databases and annotated source code", [
    arg("old-db", "Old input database", check = checkDirExists()),
    arg("new-db", "New input database", check = checkDirExists())
  ])

proc haxdocMain*(app: var CliApp, l: HLogger) =
  case app.getCmdName():
    of "nim":
      let
        nimcmd = app.getCmd()
        trail = nimcmd.getCmd()
        file = trail.getArg() as AbsFile
        define = (nimcmd.getOpt("define") as seq[string]) & @["haxdoc", "nimdoc"]
        stdpath = nimcmd.getOpt("stdpath") as AbsDir
        dryRun = app.getOpt("dry-run") as bool


      template compileDb(): untyped = 
        l.wait "Running trail compilation with file", file
        let db {.inject.} =
          if dryRun:
            DocDb()

          else:
            if file.ext() in ["nim", "nims"]:
              file.
                generateDocDb(
                  logger = l,
                  fileLib = some(file.name()),
                  defines = define,
                  stdpath = stdpath
                )

            else:
              getPackageInfo(file).
                docDbFromPackage(
                  stdpath = stdpath,
                  defines = define,
                  logger = l
                )


        l.success "Finished documentation database generation"

      case nimcmd.getCmdName():
        of "trail":
          let
            trailcmd = nimcmd.getCmd()
            outdir = trailcmd.getOpt("outdir") as AbsDir
            outfile = outdir /. file.name()
            project = outfile.withExt(sourcetrailProjectExt)

          compileDb()
          mkDir(outDir)

          l.wait "Writing sourcetrail db file"


          if not dryRun:
            db.writeSourcetrailDb(outfile)
          l.success "Wrote sourcetrail project to", project

          if trailcmd.getOpt("launch") as bool:
            l.execShell shellCmd("sourcetrail", $project)

        of "xml":
          let
            xmlCmd = nimCmd.getCmd()
            outdir = xmlCmd.getOpt("outdir") as AbsDir

          mkDir(outDir)
          compileDb()

          l.wait "Writing xml database"
          if not dryRun:
            db.writeDbXml(outdir, "haxdoc-xml")

          l.success "Wrote sourcetrail db to", outdir

    of "diff":
      let
        diffcmd = app.getCmd()
        oldDir = diffCmd.getArg("old-db") as AbsDir
        newDir = diffCmd.getArg("new-db") as AbsDir
        oldDb = oldDir.loadDbXml("haxdoc-xml", loadFiles = true)
        newDb = newDir.loadDbXml("haxdoc-xml", loadFiles = true)



proc haxdocCli*(args: seq[string], doRaise = true) =
  var
    app = newCliApp(
      "haxdoc", (0, 1, 0), "haxscramper", "documentation generator")


    logger = newTermLogger()

  app.addNimCmd()
  app.addDiffCmd()

  app.raisesAsExit(haxdocMain, {
    "OsError": (1, "zz"),
    # "ShellError": ()
  })

  if app.acceptArgs(args):
    if app.builtinActionRequested():
      app.showBuiltin(logger)

    else:
      app.runMain(haxdocMain, logger, not doRaise)

  else:
    app.showErrors(logger)
    if doRaise:
      raise app.errors[0].toRef()


when isMainModule:
  haxdocCli(paramStrs(), false)
