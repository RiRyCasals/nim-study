proc test(a: varargs[string]) =
  for i, s in a:
    echo $i, ": ", s

test("a", "i", "u")
test(["a", "i", "u"])

proc test2[T](a: varargs[T]) =
  for i, s in a:
    echo $i, ": ", repr(s)

test2("a", "i", "u")
test2(["a", "i", "u"])
test2([["a", "i", "u"]])
