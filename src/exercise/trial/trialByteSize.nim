#==== underflow, overflow ====
let a: int = 0
echo sizeof(a)

var b: uint64
echo sizeof(b)

dec(b)
echo b

inc(b)
echo b


#==== size of object type ====

type
  Thing = object
    a: uint32
    b: uint8
    c: uint16

var t: Thing
echo "-- size --"
echo "size of t   : ", sizeof(t)
echo "size of t.a : ", sizeof(t.a)
echo "size of t.b : ", sizeof(t.b)
echo "size of t.c : ", sizeof(t.c)

echo "-- addr --"
echo "addr of t   : ", repr(t.addr)
echo "addr of t.a : ", repr(t.a.addr)
echo "addr of t.b : ", repr(t.b.addr)
echo "addr of t.c : ", repr(t.c.addr)
