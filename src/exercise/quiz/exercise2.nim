# Q1

echo "==== Q1 ===="

var n: int = 50
echo "n = ", n

while n != 1:
  if n mod 2 == 0:
    n = n div 2
  else:
    n = n + 1
  echo "n = ", n


echo "==== Q2 ===="

let fullName = "RiRyCasals"

for letter in fullName:
  case letter:
    of 'a', 'e', 'i', 'o', 'u':
      echo letter
    else:
      discard


echo "==== Q3 ===="

for n in 1..30:
  if n mod 15 == 0:
    echo "fizzbuzz"
  elif n mod 3 == 0:
    echo "fizz"
  elif n mod 5 == 0:
    echo "buzz"
  else:
    echo n


echo "==== Q4 ===="

const InchToCm = 2.54

echo "in\t|\tcm"
echo "-------------------"
for n in countup(1, 19, 3):
  echo n, "\t|\t", float(n) * InchToCm
