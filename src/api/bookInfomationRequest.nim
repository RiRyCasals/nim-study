#[ nim c -d:ssl
  https://api.openbd.jp/v1/get?isbn=xxx-x-xxxx-xxxx-x&pretty
  ISBNコードをapiに投げつける
  書籍データのjsonを受け取る
  受け取ったjsonを解析して必要な書籍情報を抽出
]#

import
  os,
  json,
  httpclient

const Url = "https://api.openbd.jp/v1/get?isbn="

proc request(isbn: string) =
  let
    client = newHttpClient()
    response = client.request(url=Url&isbn)
    body = response.body
    jsonBody = body.parseJson
  echo $jsonBody

when isMainModule:
  if paramCount() == 0:
    quit("bookInfoRequest need one or more ISBN number", QuitFailure)
  for param in commandLineParams():
    if param.len != 13:
      echo "This param length is not 13: ", $param
      continue
    param.request
