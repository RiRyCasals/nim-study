import sequtils
import strutils

let n: int = stdin.readLine.parseInt
var a = stdin.readLine.split.map parseInt

proc operationCounter(n: int, a: var openArray[int]): int =
  while true:
    for i, v in a:
      if v mod 2 == 1:
        return result
      a[i] = a[i].div(2)
    result += 1

echo operationCounter(n, a)
