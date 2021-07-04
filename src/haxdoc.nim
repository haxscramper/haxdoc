import
  hmisc/preludes/cli_app

proc addNimCmd(app: var CliApp) =
  var cmd = cmd("nim", "Process nim code")

  block:
    var trail = cmd("trail", "Generate sourcetrail database")
    trail.add arg("file", "Main nim file", check = checkFileReadable())

    cmd.add trail

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
      let nimcmd = app.getCmd()
      case nimcmd.getCmdName():
        of "trail":
          let trail = nimcmd.getCmd()
          l.info "Running trail compilation with file", trail.getArg()

proc haxdocCli*(args: seq[string]) =
  var
    app = newCliApp(
      "haxdoc", (0, 1, 0), "haxscramper", "documentation generator")


    logger = newTermLogger()

  app.addNimCmd()

  app.raisesAsExit(haxdocMain, {
    "OsError": (1, "zz")
  })

  if app.acceptArgs(args):
    if app.builtinActionRequested():
      app.showBuiltin(logger)

    else:
      app.runMain(haxdocMain, logger, true)

  else:
    app.showErrors(logger)

when isMainModule:
  # haxdocCli(@["--help"])
  let file = getAppTempFile("intrail.nim")
  file.writeFile("echo 12")
  haxdocCli(@["nim", "trail", $file])
