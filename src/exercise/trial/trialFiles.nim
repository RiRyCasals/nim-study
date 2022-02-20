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

#[ 画像を配列として読み込む手順（予定）http://www.snap-tck.com/room03/c02/cg/cg06_04.html
  1. SOI: Start of image segment
    a. マーカー識別子 FF があることを確認
    b. 続く1バイトが D8 であることを確認
  2. APPn: Application type n segment
    a. マーカー識別子 FF があることを確認
    b. 続く1バイトが E0~EF のいずれかであることを確認
    c. 続く2バイトで セグメント長（頭2バイトを除く） を取得する
      * 最低値: 16 (手順c~j)
    d. 続く5バイトで JFIF識別子？ を確認する
      * APP0~APP15 によって値が変わるか調査中
        -> APP0: JFIF, APP1: Exif は確認
        -> ヌルバイト（00）で終了っぽい？
        -> 極端に言うとローダーにここの情報は必要ない
    e. 続く2バイトで バージョン番号 を取得
    f. 続く1バイトで ピクセル濃度の単位 を取得
      * 0: 不定（処理側に任せる）
      * 1: inch
      * 2: cm
    g. 続く2バイトで 横のピクセル濃度 を取得
    h. 続く2バイトで 縦のピクセル濃度 を取得
    i. 続く1バイトで サムネイルイメージの幅 を取得
    j. 続く1バイトで サムネイルイメージの高さ を取得
    k. 残りのバイトで サムネイルイメージ を取得
      * ビットマップで 24ビット の RGB
      * サムネの幅*サムネの高さ=N とすると，サムネイメージは 3Nバイト
  3. DQT; Define quantization table segment
    a. マーカー識別子 FF があることを確認
    b. 続く1バイトが DB であることを確認
    c. 続く2バイトで セグメント長（頭2バイトを除く） を取得する
    d. 続く1バイトで 精度とテーブル識別子 を取得
      * 上位4ビット: 量子化因子の精度コード（手順eに影響）
        -> 0: 8ビット
        -> 1: 16ビット
      * 下位4ビット: テーブル識別子
        -> 0, 1, 2, 3
    e. 続く1or2バイト（手順dで変動）で 量子化因子（最低 8*8=64個で1組 が存在） を取得
  4. SOFn: start of frame type n segment
    a. マーカー識別子 FF があることを確認
    b. 続く1バイトが C0~CF のいずれかであることを確認 -> C0 で確定っぽい？
    c. 続く2バイトで セグメント長（頭2バイトを除く） を取得する
    d. 続く1バイトで サンプルの精度 を取得する
      * 8 or 12
    e. 続く2バイトで イメージの行数 を取得
    f. 続く2バイトで イメージの列数 を取得
    g. 続く1バイトで 構成要素数 を取得
    h. 続く1バイトで 構成要素識別子 を取得
      * 1: Yのデータ
      * 2: Cbのデータ
      * 3: Crのデータ
    i. 続く1バイトで サンプル化要因 を取得
      * 上位4ビット: 水平方向の比率
      * 下位4ビット: 垂直方向の比率
    j. 続く1バイトで 量子化テーブルの識別子 を取得
  5. DHT: Define huffman table segment
    a. マーカー識別子 FF があることを確認
    b. 続く1バイトが C4 であることを確認
    c. 続く2バイトで セグメント長（頭2バイトを除く） を取得する
    d. 続く1バイトで DHTのクラスと識別子 を取得
      * 上位4ビット: クラス
        -> 0: DC成分用
        -> 1: AC成分用
      * 下位4ビット: 識別子
        -> 1: Yのデータ
        -> 2: Cbのデータ
        -> 3: Crのデータ
  6. SOS: Start of scan segment
  7. EOI: End of image segment
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
