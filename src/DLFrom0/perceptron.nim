import lenientops  # int と float 間での演算を行えるようにする
import std/sums


# 単純なパーセプトロンの実装
#[
proc perceptronAnd(x1, x2: int): int =
  let
    w1: float = 0.5
    w2: float = 0.5
    theta: float = 0.7
  let y = (x1 * w1) + (x2 * w2)
  if y <= theta:
    return 0
  else:
    return 1
]#


# 配列による重みとバイアスの導入
proc vectorProduct[T](x, w: openArray[T]): seq[T] =
  if x.len != w.len:
    raise 
  # var y: openArray[T]
  var y: seq[T] = @[]
  for i in 0..<w.len:
    y.add(x[i] * w[i])
  return y

proc perceptronAnd(x1, x2: int): int =
  let
    x: array[2, float] = [float(x1), float(x2)]
    w: array[2, float] = [0.5, 0.5]
    b: float = -0.7
  let y = sumKbn(vectorProduct(x, w)) + b
  if y <= 0:
    return 0
  else:
    return 1


when isMainModule:
  echo perceptronAnd(0, 0)
  echo perceptronAnd(0, 1)
  echo perceptronAnd(1, 0)
  echo perceptronAnd(1, 1)
