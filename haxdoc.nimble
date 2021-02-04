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
requires "https://github.com/haxscramper/haxorg.git#head"
requires "https://github.com/haxscramper/nimtrail.git#head"
requires "https://github.com/haxscramper/cxxstd.git"
requires "https://github.com/haxscramper/fusion.git#matching-fixup"
