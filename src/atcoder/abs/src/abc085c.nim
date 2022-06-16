import strutils
import strformat
import sequtils

var n, y: int
(n, y) = stdin.readline.split.map parseInt
y = y.div(1000)

iterator combinations(n: int): array[3, int] =
  for i in 0..n:
    for j in 0..n:
      let k = n - i - j
      if k < 0:
        continue
      yield [i, j, k]

proc isFound(n, y:int): bool =
  for c in combinations(n):
    if 10*c[0] + 5*c[1] + c[2] == y:
      echo &"{c[0]} {c[1]} {c[2]}"
      return true
  return false

if not isFound(n, y):
  echo "-1 -1 -1"
