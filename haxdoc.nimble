version       = "0.1.0"
author        = "haxscramper"
description   = "Nim documentation generator"
license       = "Apache-2.0"
srcDir        = "src"

bin           = @["haxdoc"]
installExt    = @["nim"]
binDir        = "bin"
backend       = "cpp"

requires "nim >= 1.4.0"
requires "hmisc >= 0.9.0"
requires "hpprint >= 0.2.12"
requires "https://github.com/haxscramper/haxorg.git#head"
requires "https://github.com/haxscramper/nimtrail.git#head"
requires "https://github.com/haxscramper/cxxstd.git"
requires "https://github.com/haxscramper/fusion.git#matching-fixup"


task dockertest, "Run test in docker container":
  exec("""
hmisc-putils \
  dockertest \
  --projectDir:$(pwd) \
  -lcligen \
  -lhmisc \
  -lhasts \
  -lhdrawing \
  -lhdrawing \
  -lregex \
  -lhnimast \
  -lnimtraits \
  -lhpprint \
  -lunicodeplus \
  -lhcparse \
  --preTestCmds='nimble build' \
  --preTestCmds='echo "echo 1" > file.nim' \
  --preTestCmds='./bin/haxdoc trail file.nim'
""")
