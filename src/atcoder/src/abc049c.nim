import strutils

let s = stdin.readLine

var dreamN = s.count("dream")
var dreamerN = s.count("dreamer")
var eraseN = s.count("erase")
var eraserN = s.count("eraser")
var dreameraseN = s.count("dreamerase")

dreamN -= dreamerN
eraseN -= eraserN

if (5*dreamN + 7*dreamerN + 5*eraseN + 6*eraserN - 2*dreameraseN) == s.len:
  echo "YES"
else:
  echo "NO"
