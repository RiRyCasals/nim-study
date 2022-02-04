var x = 1
for i in 1..100_000:
  dec x
  for i in 1..100_000:
    inc x

echo $x
