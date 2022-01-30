proc multiples(n: int): int =
  for k in 1..<n:
    if k mod 3 == 0 or k mod 5 == 0:
      result = result + k

when isMainModule:
  echo multiples(1000)
