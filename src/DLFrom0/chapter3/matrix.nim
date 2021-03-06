import lenientops
import math


# 3.3.1 多次元配列
type
  Matrix2d*[m, n: static[int], T] =
    array[m, array[n, T]]

# 3.3.2 行列積
proc dot[I, J, K, T](matrixA: Matrix2d[I, J, T], matrixB: Matrix2d[J, K, T]): Matrix2d[I, K, T] =
  var matrixC: Matrix2d[I, K, T]
  for i in 0..<I:
    for j in 0..<J:
      for k in 0..<K:
        matrixC[i][k] += matrixA[i][j] * matrixB[j][k]
  return matrixC

proc row[M, N, T](matrix: Matrix2d[M, N, T]): int =
  return M

proc column[M, N, T](matrix: Matrix2d[M, N, T]): int =
  return N

proc shape[M, N, T](matrix: Matrix2d[M, N, T]): tuple =
  return (M, N)

proc add[M, N, T](matrixA, matrixB: Matrix2d[M, N, T]): Matrix2d[M, N, T] =
  var matrixC: Matrix2d[M, N, T]
  for m in 0..<M:
    for n in 0..<N:
      matrixC[m][n] = matrixA[m][n] + matrixB[m][n]
  return matrixC

proc sigmoid[M, N, T](matrix: Matrix2d[M, N, T]): Matrix2d[M, N, T] =
  var matrixB: Matrix2d[M, N, T]
  for m in 0..<M:
    for n in 0..<N:
      matrixB[m][n] = pow(1 + exp(T(-matrix[m][n])), -1)
  return matrixB

proc relu[M, N, T](matrix: Matrix2d[M, N, T]): Matrix2d[M, N, T] =
  var matrixB: Matrix2d[M, N, T]
  for m in 0..<M:
    for n in 0..<N:
      matrixB[m][n] = max(T(0), T(matrix[m][n]))
  return matrixB

# 転置行列：実装してみたかったからやった
proc transpose[I, J, T](matrix: Matrix2d[I, J, T]): Matrix2d[J, I, T] =
  var matrixT: Matrix2d[J, I, T]
  for j in 0..<J:
    for i in 0..<I:
      matrixT[j][i] = matrix[i][j]
  return matrixT


when isMainModule:
  # 3.3.3 ニューラルネットワークの行列積
  #[
  let matrixX: Matrix2d[1, 2, int] = [
    [1, 2]
  ]
  let matrixW: Matrix2d[2, 3, int] = [
    [1, 3, 5],
    [2, 4, 6],
  ]

  echo matrixX.shape
  echo matrixW.shape
  echo matrixX.dot(matrixW)
  ]#

  # 3.4.2 各層における信号伝達の実装
  const
    i: int = 1
    j: int = 2
    k: int = 3

  let matrixX: Matrix2d[i, j, float] = [
    [1.0, 0.5]
  ]
  ## 1層
  let matrixW1: Matrix2d[j, k, float] = [
    [0.1, 0.3, 0.5],
    [0.2, 0.4, 0.6],
  ]
  let matrixB1: Matrix2d[i, k, float] = [
    [0.1, 0.2, 0.3]
  ]
  
  echo "shape x: ", matrixX.shape
  echo "shape w1: ", matrixW1.shape
  echo "shape b1: ", matrixB1.shape

  let matrixA1 = matrixX.dot(matrixW1).add(matrixB1)
  echo "shape a1: ", matrixA1.shape
  echo "a1: ", matrixA1

  let matrixZ1 = sigmoid(matrixA1)
  echo "z1: ", matrixZ1

  ## 2層
  let matrixW2: Matrix2d[k, j, float] = [
    [0.1, 0.4],
    [0.2, 0.5],
    [0.3, 0.6],
  ]
  let matrixB2: Matrix2d[i, j, float] = [
    [0.1, 0.2]
  ]

  echo "shape w2: ", matrixW2.shape
  echo "shape b2: ", matrixB2.shape

  let matrixA2 = matrixZ1.dot(matrixW2).add(matrixB2)
  echo "shape a2: ", matrixA2.shape
  echo "a2: ", matrixA2

  let matrixZ2 = sigmoid(matrixA2)
  echo "z2: ", matrixZ2

  ## 3層
  let matrixW3: Matrix2d[j, j, float] = [
    [0.1, 0.3],
    [0.2, 0.4],
  ]
  let matrixB3: Matrix2d[i, j, float] = [
    [0.1, 0.2]
  ]

  echo "shape w3: ", matrixW3.shape
  echo "shape b3: ", matrixB3.shape

  let matrixA3 = matrixZ2.dot(matrixW3).add(matrixB3)
  echo "shape a3: ", matrixA3.shape
  echo "a3: ", matrixA3
