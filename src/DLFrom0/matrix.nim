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
#[
proc transpose[I, J, T](matrix: Matrix2d[I, J, T]): Matrix2d[J, I, T] =
  var matrixT: Matrix2d[J, I, T]
  for j in 0..<J:
    for i in 0..<I:
      matrixT[j][i] = matrix[i][j]
  return matrixT
]#


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
  let matrixW: Matrix2d[j, k, float] = [
    [0.1, 0.3, 0.5],
    [0.2, 0.4, 0.6],
  ]
  let matrixB: Matrix2d[i, k, float] = [
    [0.1, 0.2, 0.3]
  ]
  
  echo matrixX.shape
  echo matrixW.shape
  echo matrixB.shape
  echo matrixX.dot(matrixW)
  echo matrixX.dot(matrixW).add(matrixB)
  echo matrixX.dot(matrixW).add(matrixB).sigmoid()
