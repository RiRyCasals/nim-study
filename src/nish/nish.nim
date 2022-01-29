import
  rdstdin,
  strutils,
  terminal,
  posix

proc nishReadLine(): string =
  result = readLineFromStdin(">>>").strip()

const NishTokSeps: set[char] = {' ', '\t', '\r', '\n', '\a'}
proc nishSplitLine(line: string): seq[string] =
  result = line.split(NishTokSeps)

proc nishCd(args: seq[string]): int =
  if args.len == 1:
    stderr.write("nish: expected argument to 'cd'.\n")
  else:
    if chdir(args[1]) != 0:
      stderr.write("nish: argument is invalid.\n")

proc nishExit(args: seq[string]): int =
  echo "Good bey master"
  return -1

type BuiltInCommand = object
  name: string
  function: proc(args:seq[string]): int

var
  builtInCommands: seq[BuiltInCommand] = @[
    BuiltInCommand(name: "cd", function: nishCd),
    BuiltInCommand(name: "exit", function: nishExit),
  ]

proc nishLaunch(args: seq[string]): int = 
  var status: cint
  var pid = fork()
  if pid == 0:
    if execvp(args[0], args.allocCStringArray()) == -1:
      stderr.write("command execute error.\n")
    quit(0)
  elif pid < 0:
    stderr.write("fork error.\n")
  else:
    let wpid = waitpid(pid, status, WUNTRACED)
    if WIFEXITED(status):
      return 0
  return 0

proc nishExecute(args: seq[string]): int =
  if args.len == 1:
    if isNilOrEmpty(args[0]):
      return 0
  for cmd in builtInCommands:
    if args[0] == cmd.name:
      return cmd.function(args)
  return nishLaunch(args)

proc nishRun() =
  var line: string
  var args: seq[string]
  var status: int
  while status == 0:
    line = nishReadLine()
    args = nishSplitLine(line)
    status = nishExecute(args)

proc nishInit() =
  echo "Welcom to nish!"

proc main() =
  nishInit()
  nishRun()

when isMainModule:
  import cligen
  dispatch(main, help={})
