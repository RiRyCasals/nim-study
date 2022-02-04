import os
import strutils
import parseopt


# ディレクトリ内のファイル，ディレクトリを取得 
proc getPaths(targetPath: string): seq[string] =
  for name in walkDir(targetPath):
    if name.kind == pcFile or name.kind == pcDir:
      result.add(name.path)

# ディレクトリ内のファイル，ディレクトリを再帰的に取得
proc getPathsRec(targetPath: string): seq[string] =
  for name in walkDirRec(targetPath):
      result.add(name)

# walkDir()は tuple[PathComponent, string] で返ってくる
# walkDirRec()は stringで返ってくる
proc getPathsTest(targetPath: string): int =
  echo walkDir(targetPath).type
  echo walkDirRec(targetPath).type
  return 0

proc getArguments(): tuple =
  var arguments = (path: "./", All: false, recurse: false)
  var option = initOptParser(commandLineParams().join(" "))
  for kind, key, val in option.getopt():
    case kind:
      of cmdArgument:
        if fileExists(key) or dirExists(key):
          arguments.path = key
        else:
            quit("nimls: '" & $key & "' file or directly is not found", QuitFailure)
      of cmdLongOption, cmdShortOption:
        case key:
          of "All", "A":
            arguments.All = true
          of "recurse", "R":
            arguments.recurse = true
          else:
            quit("nimls: Unknown option '" & $key & "'", QuitFailure)
      of cmdEnd:
        discard
  return arguments

when isMainModule:
  #[
    1.パスを取得
    2.パスが存在するか確認 : os.fileExists("path"), os.dirExists("path")
      a.しない : exit
      b.する : pass
    3.オプションが有るか確認
      a.ない :
        ファイル，ディレクトリを取得
      b.ある :
        # -a --all : 隠しファイル，ディレクトリを取得
        -A --All : . .. を除くファイル，ディレクトリを取得
        # -l --long: ファイル，ディレクトリの詳細を取得
        -R --recurse: ファイル，ディレクトリを再帰的に取得
    4.取得したファイル，ディレクトリを表示
  ]#

#[
  var nimlsOptions = (path: "./", All: false, recurse: false)
  var option = initOptParser(commandLineParams().join(" "))
  for kind, key, val in option.getopt():
    case kind:
      of cmdArgument:
        if fileExists(key) or dirExists(key):
          nimlsOptions.path = key
        else:
            quit("nimls: '" & $key & "' file or directly is not found", QuitFailure)
      of cmdLongOption, cmdShortOption:
        case key:
          of "All", "A":
            nimlsOptions.All = true
          of "recurse", "R":
            nimlsOptions.recurse = true
          else:
            quit("nimls: Unknown option '" & $key & "'", QuitFailure)
      of cmdEnd:
        discard
]#
  let nimlsOptions = getArguments()
  echo nimlsOptions.type
  echo nimlsOptions
