var x = 0
for _ in 1..10_000:
  dec x
  for _ in 1..10_000:
    inc x

echo $x
