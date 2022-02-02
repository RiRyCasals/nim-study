import lenientops  # int と float 間での演算を行えるようにする
import std/sums


# 2.3.1 単純なパーセプトロンの実装
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


# 2.3.3 配列による重みとバイアスの導入
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

proc perceptronNand(x1, x2: int): int =
  let
    x: array[2, float] = [float(x1), float(x2)]
    w: array[2, float] = [-0.5, -0.5]
    b: float = 0.7
  let y = sumKbn(vectorProduct(x, w)) + b
  if y <= 0:
    return 0
  else:
    return 1

proc perceptronOr(x1, x2: int): int =
  let
    x: array[2, float] = [float(x1), float(x2)]
    w: array[2, float] = [0.5, 0.5]
    b: float = -0.2
  let y = sumKbn(vectorProduct(x, w)) + b
  if y <= 0:
    return 0
  else:
    return 1

# 2.5.2 XORゲートの実装
proc perceptronXor(x1, x2: int): int =
  let y = perceptronAnd(perceptronNand(x1, x2), perceptronOr(x1, x2))
  return y

when isMainModule:
  echo "0 AND 0: ", perceptronAnd(0, 0)
  echo "0 AND 1: ", perceptronAnd(0, 1)
  echo "1 AND 0: ", perceptronAnd(1, 0)
  echo "1 AND 1: ", perceptronAnd(1, 1)
  echo "0 NAND 0: ", perceptronNand(0, 0)
  echo "0 NAND 1: ", perceptronNand(0, 1)
  echo "1 NAND 0: ", perceptronNand(1, 0)
  echo "1 NAND 1: ", perceptronNand(1, 1)
  echo "0 OR 0: ", perceptronOr(0, 0)
  echo "0 OR 1: ", perceptronOr(0, 1)
  echo "1 OR 0: ", perceptronOr(1, 0)
  echo "1 OR 1: ", perceptronOr(1, 1)
  echo "0 XOR 0: ", perceptronXor(0, 0)
  echo "0 XOR 1: ", perceptronXor(0, 1)
  echo "1 XOR 0: ", perceptronXor(1, 0)
  echo "1 XOR 1: ", perceptronXor(1, 1)
