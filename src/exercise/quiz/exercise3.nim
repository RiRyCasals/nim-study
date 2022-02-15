echo "==== Q1 ===="

var numbers: array[10, int]

for i in 0 ..< 10:
  numbers[i] = (i + 1) * 10

for i in 0 ..< numbers.len:
  if i mod 2 == 1:
    echo numbers[i]

for i in 0 ..< numbers.len:
  if i mod 2 == 0:
    numbers[i] = numbers[i] * 5
echo numbers


echo "==== Q2 ===="

var collatz: seq[int] = @[27]

var i: int = 0
while true:
  if collatz[i] == 1:
      break
  elif collatz[i] mod 2 == 0:
    collatz.add(collatz[i] div 2)
  else:
    collatz.add(collatz[i] + 1)
  i = i + 1

echo "lenght = ", collatz.len
echo collatz


echo "==== Q3 ===="

var result = (longestLength: 0, startingNumber: 0)

for n in 2..100:
  var collatz: seq[int] = @[n]
  var i: int = 0
  while true:
    if collatz[i] == 1:
      break
    elif collatz[i] mod 2 == 0:
      collatz.add(collatz[i] div 2)
    else:
      collatz.add(collatz[i] + 1)
    i = i + 1
  if collatz.len > result.longestLength:
    result.longestLength = collatz.len
    result.startingNumber = n

echo "lenght = ", result.longestLength
echo "starting number = ", result.startingNumber
