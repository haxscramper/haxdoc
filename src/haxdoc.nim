import
  hmisc/preludes/cli_app

import
  ./haxdoc/extract/from_nim_code,
  ./haxdoc/generate/sourcetrail_db,
  ./haxdoc/docentry_io

proc addNimCmd(app: var CliApp) =
  var cmd = cmd("nim", "Process nim code")

  block:
    var trail = cmd("trail", "Generate sourcetrail database")
    trail.add arg("file", "Main nim file", check = checkFileReadable())

    trail.add opt("outfile", "", default = cliDefaultFromArg(
      "file",
      proc(val: CliValue): CliValue =
        echo "outfile"
        val.as(FsFile).withExt(sourcetrailDbExt).toCliValue()))

    cmd.add trail

  block:
    var xml = cmd("trail", "Generate xml database")
    xml.add arg("file", "Main nim file", check = checkFileReadable())

    cmd.add xml

  block:
    var project = cmd("project", "Generate documentation for a project")
    project.add arg("project", "Project directory or input file", check = checkOr(
      checkDirExists(),
      checkFileReadable()
    ))

    cmd.add project

  app.root.add cmd

proc haxdocMain*(app: var CliApp, l: HLogger) =
  case app.getCmdName():
    of "nim":
      let
        nimcmd = app.getCmd()
        trail = nimcmd.getCmd()
        file = trail.getArg() as AbsFile

      l.wait "Running trail compilation with file", file

      let db = generateDocDb(
        file,
        logger = l,
        fileLib = some(file.name()))

      l.success "Finished documentation database generation"

      case nimcmd.getCmdName():
        of "trail":
          let outfile = nimcmd.getCmd().getOpt("outfile") as AbsFile
          l.wait "Writing sourcetrail db file"
          db.writeSourcetrailDb(outfile)
          l.success "Wrote sourcetrail db to", outfile

        of "xml":
          l.wait "Writing xml database"
          let outdir = file.dir()
          db.writeDbXml(outdir, "haxdoc-xml")
          l.success "Wrote sourcetrail db to", outdir


proc haxdocCli*(args: seq[string]) =
  var
    app = newCliApp(
      "haxdoc", (0, 1, 0), "haxscramper", "documentation generator")


    logger = newTermLogger()

  app.addNimCmd()

  app.raisesAsExit(haxdocMain, {
    "OsError": (1, "zz"),
    # "ShellError": ()
  })

  if app.acceptArgs(args):
    if app.builtinActionRequested():
      app.showBuiltin(logger)

    else:
      app.runMain(haxdocMain, logger, true)

  else:
    app.showErrors(logger)


when isMainModule:
  haxdocCli(paramStrs())
