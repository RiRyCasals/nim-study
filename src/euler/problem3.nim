import math, sequtils

proc maxPrimeFactor(n: var int): int =
  var primeFactors: seq[int] = @[]
  for i in 2..<n:
    while n mod i == 0:
      if n == 0:
        break
      n = n div i
      if primeFactors.count(i) == 0:
        primeFactors.add(i)
  return primeFactors.popLast()

when isMainModule:
  let n = 600_851_445_143;
  let sqrtN = sqrt(n)       # sqrt(float32) である必要．n^(1/2) は 1/2 のところで怒られる
  echo maxPrimeFactor(round(sqrtN))
  echo sqrtN
