import strutils

var a: int = stdin.readLine.parseInt

proc counter(n: var int): int =
  while n > 0:
    result += n mod 10
    n = n.div(10)

echo counter(a)
