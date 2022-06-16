import strutils
import sequtils
import algorithm

let n = stdin.readLine.parseInt
let d = newSeqWith(n, stdin.readLine.parseInt)

echo deduplicate(d.sorted, true).len
