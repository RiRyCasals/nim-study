import
  random,
  mersenne # use `std/random` instead; mersenne is deprecated って言われた


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
echo rand(100)
echo rand(5.5)
echo rand(20..25)
echo rand(1.5..2.5)
echo rand(int8)
echo rand(uint16)
echo rand(range[10..20])

## random seed
var init = initRand(5)
echo init.rand(100)


