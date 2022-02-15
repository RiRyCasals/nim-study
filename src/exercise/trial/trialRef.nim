var x: ref int  # 宣言時に参照型として定義

assert x == nil # 0初期化されてない

x = int.new     # T.newでオブジェクトを作成 -> ここで0初期化が起こる
echo x[]

x[] = 10        # 参照型の値をいじるときは []演算子 を利用 -> c の & と同じ感じかな？
echo x[]

var x2 = x      # x2はxと参照先が同じ
x2[] = 20       # x2の参照先を変更する = xの参照先が変更される

assert x[] == 20

# 引数として参照を受け取る -> 値ではない
proc test(a: ref int) =
  echo a[]

test(x)


type
  MyObject = object
    x: int
    y: ref int

  MyObject2 = ref object
    x: int
    y: ref int

var myObject: MyObject
myObject.x = 10
myObject.y = int.new
myObject.y[] = 20
echo myObject.x
echo myObject.y[]

var myObject2 =  MyObject2.new
myObject2.x = 10
myObject2.y = int.new
myObject2.y[] = 20
echo myObject2.x
echo myObject2.y[]
