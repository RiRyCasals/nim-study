import lenientops
import math

# 3.2.1 Sigmoid関数の実装
proc sigmoid[T](x: openArray[T]): seq[float] =
  var y: seq[float] = @[]
  for i in 0..<x.len:
    y.add(pow(1 + exp(float(-x[i])), -1))
  return y

# 3.2.2 Step関数の実装
proc step[T](x: openArray[T]): seq[float] =
  var y: seq[float] = @[]
  for i in 0..<x.len:
    if x[i] > 0:
      y.add(1.0)
    else:
      y.add(0.0)
  return y

# 3.2.7 ReLU関数の実装
proc relu[T](x: openArray[T]): seq[float] =
  var y: seq[float] = @[]
  for i in 0..<x.len:
    y.add(max(0.0, float(x[i])))
  return y


when isMainModule:
  let x1: array[4, int] = [-6, -2, 2, 6]
  let x2: array[7, float] = [-4.5, -3.0, -1.5, 0.0, 1.5, 3.0, 4.5]
  echo "sigmoid: ", sigmoid(x1)
  echo "sigmoid: ", sigmoid(x2)
  echo "step: ", step(x1)
  echo "step: ", step(x2)
  echo "ReLU: ", relu(x1)
  echo "ReLU: ", relu(x2)
