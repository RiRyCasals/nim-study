import sequtils

let
  width = 10
  height = 5

var seq2d = newSeqWith(height, newSeq[uint8](width))

echo seq2d.type
echo $seq2d
