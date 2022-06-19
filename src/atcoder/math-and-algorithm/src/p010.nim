import strutils

let N = stdin.readLine.parseInt

proc factorial(n: int): int = 
  result = 1
  for i in 2..N:
    result *= i

echo factorial(N)
