import strutils

let s = stdin.readLine

var dreamN = s.count("dream");
var dreamerN = s.count("dreamer");
var eraseN= s.count("erase");
var eraserN= s.count("eraser");
var dreameraserN= s.count("dreamerase");


if dreamN >= dreamerN:
  dreamN -= dreamerN
  dreamerN *= -1
if eraseN >= eraserN:
  eraseN -= eraserN
  eraserN *= -1

if (5*dreamN - 7*dreamerN + 5*eraseN - 6*eraserN - 2*dreameraserN) == s.len:
  echo "YES"
else:
  echo "NO"
