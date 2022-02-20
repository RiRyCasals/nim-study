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
    a. マーカー識別子 FF があることを確認
    b. 続く1バイトが DA であることを確認
    c. 続く2バイトで セグメント長（頭2バイトを除く） を取得する
    d. 続く1バイトで 構成要素数 を取得
      * SOFn の構成要素数（手順g）と同じ
    e. 続く1バイトで 構成要素識別子 を取得
      * 1: Yのデータ
      * 2: Cbのデータ
      * 3: Crのデータ
    f. 続く1バイトで DC/AC構成要素のDHT識別子 を取得
      * 上位4ビット: DC成分用
      * 下位4ビット: AC成分用
      * 量子化テーブルと同じ数並ぶ
    g. 続く1バイトで 00（スペクトル選択の開始） を取得
      -> jpeg拡張用（通常使用しない）
    h. 続く1バイトで 3f（スペクトル選択の開始） を取得
      -> jpeg拡張用（通常使用しない）
    i. 続く1バイトで 00（スペクトル選択の上位4ビット,下位４ビット） を取得
      -> jpeg拡張用（通常使用しない）
    j. 残りに ハフマン符号化されたイメージデータが存在
      * データ中にマーカー識別子（FF）と同じ値がある場合,FFの直後に00が入る
  7. EOI: End of image segment
    a. マーカー識別子 FF があることを確認
    b. 続く1バイトが D9 であることを確認
]#

proc identification(buffer: uint8) =
  if buffer == 0xFF:
    echo "マーカー識別子"
  elif buffer == 0xD8:
    echo "SOI"
  elif 0xE0 <= buffer and buffer <= 0xEF:
    echo "APPn"
  elif buffer == 0xDB:
    echo "DQT"
  elif buffer == 0xC0:
    echo "SOF"
  elif buffer == 0xC4:
    echo "DHT"
  elif buffer == 0xDA:
    echo "SOS"
  elif buffer == 0xD9:
    echo "EOI"
  elif buffer == 0x00:
    echo "ただのデータ"
  else:
    echo  "マーカー識別子ではない"

#proc loadImage(path: string): openArray[int] =
proc loadImage(path: string) =
  block:
    let file: File = open(path, fmRead)

    defer:
      file.close()

    echo file.getFileSize

    var buffer: uint8

    for i in 0..4:
      discard file.readBuffer(buffer.addr, 1) #先頭から順にpopしてく感じ（readByte,readCharなども同じ挙動）
      # 一つ前が0xFFであるかとか知れるようにしたい
      buffer.identification

if fileExists(filePath):
  loadImage(filePath)
