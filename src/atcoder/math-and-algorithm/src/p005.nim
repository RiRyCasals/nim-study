import sequtils
import strutils

discard stdin.readline.parseInt
let A = stdin.readline.split.map parseInt

proc sum(array: openArray[int]): int =
  for v in array:
    result += v

echo A.sum mod 100
