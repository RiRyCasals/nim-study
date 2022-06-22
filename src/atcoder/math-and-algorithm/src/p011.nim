import sequtils
import strutils
import math
import lenientops

proc getIndex(a: openArray[bool]): seq[int] = 
  for i, isTrue in a:
    if isTrue:
      result.add(i)

let N: int = stdin.readLine.parseInt

var p = 2
var isPrime = true.repeat(N+1)
isPrime[0] = false
isPrime[1] = false

while p < N.toFloat.sqrt:
  if isPrime[p]:
    var i = 2
    while i*p <= N:
      isPrime[i*p] = false
      i.inc
  p.inc

echo isPrime.getIndex.join(" ")
