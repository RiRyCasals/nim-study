import strutils
import sequtils

let N = stdin.readLine.parseInt
var Coordinates = mapIt(0..<N, stdin.readLine.split.map parseInt)

var isPossible = true
var coordinate = [0, 0, 0]

for i in 0..<N:
  coordinate = [abs(Coordinates[i][0]-coordinate[0]), abs(Coordinates[i][1]-coordinate[1]), abs(Coordinates[i][2]-coordinate[2])]
  let distance = coordinate[1] + coordinate[2]
  if coordinate[0] < distance:
    isPossible = false
    break
  if coordinate[0] mod 2 == 0:
    if distance mod 2 != 0:
      isPossible = false
      break
  else:
    if distance mod 2 != 1:
      isPossible = false
      break

if isPossible:
  echo "Yes"
else:
  echo "No"
