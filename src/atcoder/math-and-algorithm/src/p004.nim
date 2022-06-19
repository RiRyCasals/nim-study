import sequtils
import strutils

let A = stdin.readline.split.map parseInt
echo A[0] * A[1] * A[2]
