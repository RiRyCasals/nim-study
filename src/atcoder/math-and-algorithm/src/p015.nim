import sequtils
import strutils


var dividend, divisor: int
(divisor, dividend) = stdin.readLine.split.map(parseInt)


while true:
  let remainder: int = dividend mod divisor
  if remainder == 0:
    echo divisor
    break
  dividend = divisor
  divisor = remainder
