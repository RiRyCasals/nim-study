#[
  templateは抽象構文木を置換する仕組み
  templateの引数には通常の型に加えて, meta types (untyped, typed, typedesc) が使える
    untyped:  template引数の型解決をtemplate呼び出し時に行わないようにさせる
    typed:    template引数の型解決をtemplate呼び出し時に行うようにさせる
    typedesc: 型名をtemplate引数にさせる
  template呼び出し時に，呼び出し式の最後に : と続けてブロック文を記述するとtemplate引数の最後にブロック文を渡せる
]#

# どういうときに使えばいいんだろう？？？

template echoBlock(blockName, x: untyped): untyped =
  echo "===== ", astToStr(blockName), " ====="
  echo astToStr(x)
  echo "\n================"
  x

echoBlock(test):
  var x: int
  x = 10
  echo x
