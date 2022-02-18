import
  random
  # mersenne # use `std/random` instead; mersenne is deprecated って言われた


# random
#[
  rand(max: int): int
    0..max の範囲の整数を返す

  rand(max: float): float
    0..max の範囲の浮動小数点数を返す

  rand[T: Ordinal or SomeFloat](x: HSlice[T, T]): T
    範囲を表す引数 x を受け取り，その範囲の値を返す

  rand[T: SomeInteger](t: typedesc[T]): T
    typedesc型 を受け取り，その型がと言える範囲の値を返す
]#

## デフォルトの乱数器は安全でない -> 何度実行しても同じ結果が得られる
echo "======= default ======="
echo rand(100)
echo rand(5.5)
echo rand(20..25)
echo rand(1.5..2.5)
echo rand(int8)
echo rand(uint16)
echo rand(range[10..20])

## シード値の設定
echo "======= set seed ======="
var init = initRand(5)
echo init.rand(100)
echo init.next() #uint64が返る

## 乱数期の初期化
echo "======= randomized ======="
randomize()
echo rand(100)
echo rand(5.5)
echo rand(20..25)
echo rand(1.5..2.5)
echo rand(int8)
echo rand(uint16)
echo rand(range[10..20])

## ランダムに抽出
const
  mySet = {1, 3, 5, 7, 9}
  myArray = [0, 2, 4, 6, 8]
echo "======= sample ======="
echo mySet.sample #randomize後なので変化する
echo init.sample(myArray) #seedで固定してるので変化しない

## シャッフル
var myArray2 = [10, 20, 30, 40, 50]
echo "======= shuffle ======="
init.shuffle(myArray2)
echo myArray2
shuffle(myArray2)
echo myArray2
