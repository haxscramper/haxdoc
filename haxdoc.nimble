version       = "0.1.2"
author        = "haxscramper"
description   = "Nim documentation generator"
license       = "Apache-2.0"
srcDir        = "src"

installExt    = @["nim"]
backend       = "cpp"

requires "hnimast#head"
requires "haxorg"
requires "nimtrail >= 0.1.1"
requires "nim >= 1.4.0"
requires "hmisc#head"
requires "hpprint >= 0.2.12"
requires "hcparse#head"
requires "fusion"
requires "cxxstd"
requires "nimtraits#head"

before install:
  # Whatever, I'm too tired of fighting nimble over my local installation
  # 'local dependencies' will be added 'stometimes later', so for now I
  # just have this hack. Don't care, works for me.
  exec("nimble -y install 'https://github.com/haxscramper/nimspell.git'")
  exec("nimble -y install 'https://github.com/haxscramper/cxxstd.git'")
  exec("nimble -y install 'https://github.com/haxscramper/nimtrail.git'")
  exec("nimble -y install 'https://github.com/haxscramper/haxorg.git'")

task dockertest, "Run test in docker container":
  exec("""
hmisc-putils \
  dockertest \
  --projectDir:$(pwd) \
  -lfusion \
  -lbenchy \
  -lcligen \
  -lcompiler \
  -lhmisc \
  -lhasts \
  -lhdrawing \
  -lregex \
  -lnimble \
  -lhnimast \
  -lhpprint \
  -lnimtraits \
  -lunicodeplus \
  -lhcparse \
  -lnimspell \
  -lcxxstd \
  -lhaxorg \
  -lnimtrail
""")

task docgen, "Generate documentation":
  exec("hmisc-putils docgen")
