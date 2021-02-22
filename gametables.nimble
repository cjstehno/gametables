# Package

version       = "0.1.0"
author        = "Christopher J Stehno"
description   = "A random game dice table row selection tool and reusable library."
license       = "Apache-2.0"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["gametables"]



# Dependencies

requires "nim >= 1.2.6"
requires "polydice >= 0.2.0"
requires "docopt >= 0.6.7"