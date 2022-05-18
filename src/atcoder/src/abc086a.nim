import sequtils
import strutils

var a, b: int
(a, b) = stdin.readLine.split.map parseInt

if a mod 2 == 0 or b mod 2 == 0:
  echo "Even"
else:
  echo "Odd"
