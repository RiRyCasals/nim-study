import sequtils
import strutils

var N, S: int
(N, S) = stdin.readline.split.map parseInt

#2重は解消する
proc counter(n, s: int): int =
  for i in 1..N:
    for j in 1..N:
      if i + j <= S:
        result += 1
      else:
        continue

echo N.counter(S)
