import strutils

let a: int = stdin.readLine.parseint
let b: int = stdin.readLine.parseint
let c: int = stdin.readLine.parseint
let x: int = stdin.readLine.parseint

proc counter(a, b, c, x: int): int =
  for ai in 0..a:
    for bi in 0..b:
      for ci in 0..c:
        if 500*ai + 100*bi + 50*ci == x:
          result += 1

echo counter(a, b,c, x)
