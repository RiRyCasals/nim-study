import os

echo "======= text file ======="
var filePath = "trial/testFile.txt"

if fileExists(filePath):
  for line in lines(filePath):
    echo line
else:
  echo filePath, " is not found."
  echo "Try execute in the exercise directory."


echo "======= jpg file ======="
filePath = "trial/nimPython.jpg"

if fileExists(filePath):
  let file = readFile(filePath)
  echo file.type
  #echo file[0..31] #-> binaryを文字列にしたものが入ってる
else:
  echo filePath, " is not found."
  echo "Try execute in the exercise directory."


echo "======= jpg file 2 ======="
#proc loadImage(path: string): openArray[int] =
proc loadImage(path: string) =
  let file: File = open(path, fmRead)
  echo file.type
  echo file.getFileSize
  echo file.getFilePos
  setFilePos(file, 10)
  echo file.getFilePos
  file.close()

if fileExists(filePath):
  loadImage(filePath)
