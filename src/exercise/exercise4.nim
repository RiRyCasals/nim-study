echo "==== Q1 ===="

proc greeting(name: string): string =
  return "Hello " & name

let names: array[3, string] = ["RaRy", "ReRy", "RiRy"]
for i, name in names:
  if i == 2:
    echo name.greeting()
  else:
    echo greeting(name)


echo "==== Q2 ===="

proc findMax3(numbers: array[3, int]): int =
  for number in numbers:
    if number > result:
      result = number

let numbers: array[3, int] = [1, 2, 3]
echo findMax3(numbers)
echo numbers.findMax3()


echo "==== Q3 ===="

proc pointAdd(points: tuple[x, y: float]): tuple =
  let newTuple = (x: points.x + points.y, y: points.x + points.y)
  return newTuple

var points = (x: 1.25, y: 2.15)
echo points.pointAdd()
echo pointAdd(points)


echo "==== Q4 ===="

const stoper: int = 20
var counter: int = 1

proc tock()

proc tick() =
  if counter > stoper:
    return
  inc counter
  echo "tick"
  tock()

proc tock() =
  if counter > stoper:
    return
  inc counter
  echo "tock"
  tick()

tick()
