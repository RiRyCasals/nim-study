import sequtils
import strutils

let n: int = stdin.readLine.parseInt
var a = stdin.readLine.split.map parseInt

var alice, bob: int

# atcoder の Nim のバージョンが 1.0.6 なので maxIndex が実装されていなかった
proc maxIndex[T](a: openArray[T], n: T): int =
  for i, v in a:
    if v == n:
      return i

for i in 0..<n:
  if i mod 2 == 0:
    let mi = a.maxIndex(a.max)
    alice += a[mi]
    a.delete(mi)
  else:
    let mi = a.maxIndex(a.max)
    bob += a[mi]
    a.delete(mi)

echo alice - bob
