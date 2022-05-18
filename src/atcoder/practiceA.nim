import sequtils
import strutils
import strformat

let a = stdin.readLine.parseInt

var b, c: int
(b, c) = stdin.readLine.split.map parseInt

let s = stdin.readLine

echo &"{a + b + c} {s}"
