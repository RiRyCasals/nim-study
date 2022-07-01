import sequtils
import strutils

var N, K: int
(N, K) = stdin.readLine.split.map parseInt
let A = stdin.readLine.split.map parseInt

proc binarySearch(array: openArray[int], target: int): int =
  var
    l: int = 0
    r: int = array.len - 1
    m: int
  while l < r:
    m = (l+r).div(2)
    if array[m] >= target:
      r = m
    else:
      l = m + 1
  if r == array.len-1 and array[r] < K:
    result = -1
    return
  return l

echo A.binarySearch(K)
