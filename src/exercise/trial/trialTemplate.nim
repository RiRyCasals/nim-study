template echoBlock(blockName, x: untyped): untyped =
  echo "===== ", astToStr(blockName), " ====="
  echo astToStr(x)
  echo "\n================"
  x

echoBlock(test):
  var x: int
  x = 10
  echo x
