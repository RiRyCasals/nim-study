import os

let filePath = "trial/testFile.txt"

if fileExists(filePath):
  for line in lines(filePath):
    echo line
else:
  echo filePath, " is not found."
  echo "Try execute in the exercise directory."
