import macros

macro mymacro(): untyped =
  return nnkCommand.newTree(newIdentNode("echo"), newLit("hello"))

mymacro()
