import sequtils
import strutils

var N, K: int
(N, K) = stdin.readLine.split.map parseInt
let A = stdin.readLine.split.map parseInt

proc linerSearch(array: openArray[int], target: int): int =
  for i, a in array:
    if a >= target:
      result = i
      return
  result = -1

echo A.linerSearch(K)
