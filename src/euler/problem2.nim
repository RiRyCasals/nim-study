import deques

proc fibonacci(n: int): int =
  var term = [1, 2].toDeque()
  while term[1] <= n:
    if term[1] mod 2 == 0:
      result += term[1]
    term.addLast(term[0] + term[1])
    discard term.popFirst()

when isMainModule:
  echo fibonacci(4_000_000)
