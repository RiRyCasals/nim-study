import os
import strutils
import parseopt


proc nimlsDocument(): string =
  return """
  What is nimls :
      nimls implementation of the ls command in the Nim programming language.
      You can get files and directories name.

  Useage :
      nimls [option] [path]
  
  Default command:
      nimls ./

  Meta options :
      -?, --help      Show nimls document.

  Display options :
      -r, --recurse   Recursively get files and directories name.

  Filtering options :
      -a, --all       Get hidden files and directories name.
      -d, --dir       Get directories name.
      -f, --file      Get files name.
  """

proc getArguments(): tuple =
  var arguments = (path: "./", isAll: false, isRecurse: false, isFileOnly: false, isDirectoryOnly: false)
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
          of "all", "a":
            arguments.isAll = true
          of "dir", "d":
            arguments.isDirectoryOnly = true
          of "file", "f":
            arguments.isFileOnly = true
          of "recurse", "r":
            arguments.isRecurse = true
          of "help", "?":
            quit(nimlsDocument(), QuitSuccess)
          else:
            quit("nimls: Unknown option '" & $key & "'", QuitFailure)
      else:
        discard
  return arguments

proc getPaths(targetPath: string, isRecurse: bool): seq[tuple[kind: PathComponent, path: string]] =
  var pathList: seq[tuple[kind: PathComponent, path: string]] = @[]
  for kindAndPath in walkDir(targetPath):
    pathList.add(kindAndPath)
    # 再帰する場合 : walkDirRec(path)はkindを返さない（ファイルのパスだけになる）のでwalkDir(path)で再帰する
    if isRecurse and (kindAndPath.kind == pcDir):
      pathList &= getPaths(kindAndPath.path, isRecurse)
  return pathList

proc excludeHiddenFileOrDirectory(pathList: seq[tuple[kind: PathComponent, path: string]]): seq[tuple[kind: PathComponent, path: string]] =
  var excludedPathList: seq[tuple[kind: PathComponent, path: string]] = @[]
  for kindAndPath in pathList:
    if kindAndPath.path.contains("/."):
        continue
    else:
      excludedPathList.add(kindAndPath)
  return excludedPathList
   
proc exclude(pathList: seq[tuple[kind: PathComponent, path: string]], kind: PathComponent): seq[tuple[kind: PathComponent, path: string]] =
  var excludedPathList: seq[tuple[kind: PathComponent, path: string]] = @[]
  for kindAndPath in pathList:
    if kindAndPath.kind == kind:
        continue
    else:
      excludedPathList.add(kindAndPath)
  return excludedPathList
 
proc getPathList(arguments: tuple): seq[tuple[kind: PathComponent, path: string]] =
  var pathList: seq[tuple[kind: PathComponent, path: string]] = getPaths(arguments.path, arguments.isRecurse)
  if not arguments.isAll:
    pathList = excludeHiddenFileOrDirectory(pathList)
  if arguments.isFileOnly:
    pathList = pathList.exclude(pcDir)
  if arguments.isDirectoryOnly:
    pathList = pathList.exclude(pcFile)
  return pathList

proc nimlsCommand(arguments: tuple): bool =
  let pathList = getPathList(arguments)
  for kindAndPath in pathList:
    if kindAndPath.kind == pcDir:
      if kindAndPath.path.startsWith("./"):
        echo "d : ", kindAndPath.path[2..kindAndPath.path.len-1]
      else:
        echo "d : ", kindAndPath.path
    elif kindAndPath.kind == pcFile:
      if kindAndPath.path.startsWith("./"):
        echo "f : ", kindAndPath.path[2..kindAndPath.path.len-1]
      else:
        echo "f : ", kindAndPath.path


when isMainModule:
  let nimlsArguments = getArguments()
  discard nimlsCommand(nimlsArguments)
