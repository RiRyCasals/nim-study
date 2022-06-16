import sequtils
import strutils

var n, a, b: int
(n, a, b) = stdin.readLine.split.map parseInt

proc sumOfDigits(value: int): int =
  var a: int = value
  while a > 0:
    result += a mod 10
    a = a.div(10)

proc someSums(n, a, b: int): int =
  for v in 1..n:
    let sumValue = sumOfDigits(v)
    if sumValue >= a and sumValue <= b:
      result += v

echo $someSums(n, a, b)
