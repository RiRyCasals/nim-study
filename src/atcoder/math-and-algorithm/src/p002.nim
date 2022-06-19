import sequtils
import strutils

var a1, a2, a3: int
(a1, a2, a3) = stdin.readline.split.map parseInt
echo a1 + a2 + a3
