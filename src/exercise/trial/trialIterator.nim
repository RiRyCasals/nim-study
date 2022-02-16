iterator myCountup(a, b: int): int =
  var res = a
  while res <= b:
    yield res
    inc(res)

for i in myCountup(1, 10):
  echo i
