import std/unittest
import aboisvert_utils/filebuffer

{.used.}

suite "FileBuffer":

  template checkReadLine(buf: FileBuffer, expected: string, includeEol = false) =
    var (line, eof) = buf.readLine(includeEol)
    check:
      eof == false
      line == expected

  template checkEOF(buf: FileBuffer) =
    var (line, eof) = buf.readLine()
    check:
      eof == true
      line == ""

  test "readLine (without includeEol)":
    var buf = initFileBuffer(open("tests/sample.txt"))
    defer: buf.close()
    buf.checkReadLine "line1"
    buf.checkReadLine "line2"
    buf.checkReadLine "line3"
    buf.checkEOF

  test "readLine (with includeEol)":
    var buf = initFileBuffer(open("tests/sample.txt"))
    buf.checkReadLine "line1\n", includeEol = true
    buf.checkReadLine "line2\n", includeEol = true
    buf.checkReadLine "line3", includeEol = true
    buf.checkEOF
