# Nim の基本

## 使い方メモ
Nimを利用しててわかったことを書く


### 配列
array[size, T]で定義できるが，sizeの保持の仕方が想定と異なった．
array[5, int]で定義した配列は，sizeを 5 で保持するのではなく，**0..4** で保持する．
`low(array)`と`high(array)`で開始と終了のインデックスを取得できる．
```nim
let a: array[5, int]

for i in low(a)..high(a):
  echo i # 0 1 2 3 4
```
また，配列をfor文で回すときは`0..<len(array)`で回すより，`low(array)..high(array)`で回すほうが安全である．
Nimの配列では`let a: array[1..10, int]`のように利用できるインデックスを指定することができ，このときインデックスの指定を`a[0]`にするとエラーになる．

二次元配列を利用するために `static[int]` を利用することがあった．（ジェネリクスを参照）
この場合，size が 0..size ではなく，size で保持されていた．
コンパイル言語の仕様（Nim固有かもしれないが）に慣れていないので，ドキュメントを読み返したりする必要がある．


### ジェネリクス
同じような挙動を複数の方で利用できるようにする仕組み．
コンパイル言語を普段使わないので知識上でしかなかった．

#### 今まで見てきた光景
これだと戻り値がfloat型固定になって扱いづらい．（ジェネリクス本来の強みが活かせていない）
```nim
proc product[T](a, b: openArray[T]): seq[float] =
  var c: seq[float] = @[]
  for i in 0..<a.len:
    c.add(float(a[i] * b[i]))
  return c
```

#### 新しく見た光景
ジェネリクスのときに出てくる T は型が収まる変数とみなせるので，proc内部でも利用できる．
```nim
proc product[T](a, b: openArray[T]): array[T] =
  var c: array[a.len, T]
  for i in 0..<a.len:
    array[i] = a[i] * b[i]
  return c
```
T は型が収まる変数とみなせるので，必ずしも T でなくともよい．
```nim
proc product[ThisIsT](a, b: openArray[ThisIsT]): array[ThisIsT] =
  var c: array[a.len, ThisIsT]
  for i in 0..<a.len:
    array[i] = a[i] * b[i]
  return c
```
型によっては複数のものを定義できる．
```nim
type
  Matrix[T; M, N: static[int]] =
    array[M, array[N, T]]

proc product[T, I, K, J](a: Matrix[T, I, K], b: Matrix[T, K, J]): Matrix[T, I, J] =
  var c: Matrix[T, I, J]
  for i in 0..<I:
    for j in 0..<J:
      for k in 0..<K:
        c[i][j] += a[i][k] * b[k][j]
  result = c
```
