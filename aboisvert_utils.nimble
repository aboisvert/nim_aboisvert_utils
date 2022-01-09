# Package

version       = "0.0.1"
author        = "Alex Boisvert"
description   = "A library set of common utilities for Nim"
license       = "Apache Software License v2"
srcDir        = "src"

# Dependencies
requires "nim >= 1.4.0"

# Tasks
import os, strutils

proc general_tests() =
  for dtest in listFiles("tests/"):
    if dtest.startsWith("t") and dtest.endsWith(".nim"):
      echo("Testing: " & $dtest)
      exec "nimble c -r $1" % [dtest]

task test, "Runs the test suite":
  general_tests()
