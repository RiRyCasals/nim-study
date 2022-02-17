import
  random,
  mersenne


# random
## デフォルトの乱数器は安全でない -> 何度実行しても同じ結果が得られる

echo rand(100)
echo rand(5.5)
echo rand(20..25)
echo rand(1.5..2.5)
echo rand(int8)
echo rand(uint16)
echo rand(range[10..20])
