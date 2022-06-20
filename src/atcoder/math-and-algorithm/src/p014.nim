import strutils

var n = stdin.readLine.parseInt

var p = 2
var pList: seq[int] = @[]

while p <= n:
  if n mod p == 0:
    pList.add(p)
    n = n.div(p)
  else:
    p += 1

echo pList.join(" ")
