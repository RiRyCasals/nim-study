import strutils, math

echo "==== Q1 ===="

echo "Enter your height(cm) ..."
let height = readLine(stdin).parseFloat()

echo "Enter your weight(kg) ..."
let weight = readLine(stdin).parseFloat()

let bmi = weight / (height / 100)^2
echo "Your BMI = ", bmi


echo "==== Q2 ===="

echo "Enter the number of Collatz conjecture ..."
var n: int = readLine(stdin).parseInt()
var collatz: seq[int] = @[n]

while n != 1:
  if n mod 2 == 0:
    n = n div 2
  else:
    inc n
  collatz.add(n)

echo collatz


echo "==== Q2 ===="

echo "Enter the string you want to invert"
let preString: string = readLine(stdin).strip()
var invertString: string = ""

for i in countdown(preString.len - 1, 0, 1):
  invertString.add(preString[i])

echo invertString
