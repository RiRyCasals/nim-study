import base64

# base64 encode
let encoded = encode("Hello, Nim!")
echo encoded.type
echo $encoded

# base64 decode
let decoded = decode(encoded)
echo decoded

#-----------------------------------

let encodedInts = encode([1, 2, 3])
echo $encodedInts

let decodedInts = decode(encodedInts)
echo decodedInts .type
echo $decodedInts 
