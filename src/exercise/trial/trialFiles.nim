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
filePath = "trial/sample.jpeg"

if fileExists(filePath):
  let file = readFile(filePath)
  echo file.type
  #echo file[0..31] #-> binaryを文字列にしたものが入ってる
else:
  echo filePath, " is not found."
  echo "Try execute in the exercise directory."


echo "======= jpg file 2 ======="

#[ 画像を配列として読み込む手順（予定）
  1. ヘッダ情報を読む（SOI~SOSまで）
  2. 画像を読む（SOS以降）
]#

#proc loadImage(path: string): openArray[int] =
proc loadImage(path: string) =
  block:
    let file: File = open(path, fmRead)
    defer:
      file.close()
    echo file.type
    echo file.getFileSize
    echo file.getFilePos
    var SOI: array[2, uint8]
    echo file.readBytes(SOI, 0, 2)
    echo SOI
    if SOI[0] == 0xFF:
      echo "マーカー識別子"
      if SOI[1] == 0xD8:
        echo "SOIマーカー"

if fileExists(filePath):
  loadImage(filePath)
