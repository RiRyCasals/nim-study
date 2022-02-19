proc printf(formatstr: cstring){.header: "<stdio.h>", importc: "printf", varargs.}

let
  str1 = "Hello"
  str2 = "world"
  num1 = 12345

printf("%s, %s!\nYour id: %d\n", str1, str2, num1)
