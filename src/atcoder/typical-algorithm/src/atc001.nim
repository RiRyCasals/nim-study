#[ 実装予定のアルゴリズム
   0. mazeSeq = stdin
   1. serchedSeq = makeSeq(mazeSeq.shape) (default: false)
   2. index = getIndex(searchedSeq[j, k]=='s')
   3. stack.push(index)
   4. serchedSeq[index] = true
   5. isGoal = checkGoal(mazeSeq[(1, 0)+index]=='g') or checkGoal(mazeSeq[(0, 1)+index]=='g') or\
               checkGoal(mazeSeq[(-1, 0)+index]=='g') or checkGoal(mazeSeq[(0, -1)+index]=='g')
   6. if isGoal: return Yes
   7. nextIndex = getIndex(mazeSeq[(1, 0)+index]=='.' and searchedSeq[(1, 0)+index]==false) or\
                  getIndex(mazeSeq[(0, 1)+index]=='.' and searchedSeq[(0, 1)+index]==false) or\
                  getIndex(mazeSeq[(-1, 0)+index]=='.' and searchedSeq[(-1, 0)+index]==false) or\
                  getIndex(mazeSeq[(0, -1)+index]=='.' and searchedSeq[(0, -1)+index]==false)
   8. if nextIndex == none: index = stack.pop
   9. if stack.len <= 0 or index == none: return false
  10. else: stack.push(nextIndex), searchedSeq[nextIndex] = true
  11. repeat 5..9
#]#

import sequtils
import strutils

type
  Coordinate = ref object
    x, y: int
  MazeSize = ref object
    width, height: int
  Maze = ref object
    size: MazeSize
    mazeMap: seq[string]
    searchedMap: seq[seq[bool]] #変更可能？
 

let # 移動する方向を示す
  UP: Coordinate = Coordinate(x: 0, y: -1)
  LEFT: Coordinate = Coordinate(x: -1, y: 0)
  DOWN: Coordinate =  Coordinate(x: 0, y: 1)
  RIGHT: Coordinate = Coordinate(x: 1, y: 0)
  Operattion: array[4, Coordinate] = [UP, LEFT, DOWN, RIGHT]

proc getStartIndex(mazeMap: seq[string]): Coordinate = 
  for y in 0..<mazeMap.len:
    let x = mazeMap[y].find('s')
    if x != -1:
      return Coordinate(x: x, y: y)
  return nil

proc getNextIndexOnStreet(maze: Maze, index, operation: Coordinate): Coordinate =
  result = Coordinate(x: index.x + operation.x, y: index.y + operation.y)
  if result.x < 0 or result.x >= maze.size.width or result.y < 0 or result.y >= maze.size.height:
    return nil
  if maze.mazeMap[result.y][result.x] == '.' and not maze.searchedMap[result.y][result.x]:
    return 
  return nil

proc checkGoalAround(maze: Maze, index, operation: Coordinate): bool =
  let aroundIndex = Coordinate(x: index.x + operation.x, y: index.y + operation.y)
  if aroundIndex.x < 0 or aroundIndex.x >= maze.size.width or aroundIndex.y < 0 or aroundIndex.y >= maze.size.height:
    return
  if maze.mazeMap[aroundIndex.y][aroundIndex.x] == 'g':
    return true
  

#debug
proc showSearchedMap(searchedMap: seq[seq[bool]]) =
  for row in searchedMap:
    echo row

when isMainModule:
  var mazeSize: MazeSize = MazeSize()
  (mazeSize.height, mazeSize.width) = stdin.readLine.split.map(parseInt)
  let mazeSeq = newSeqWith(mazeSize.height, stdin.readLine)
  var searchedSeq = newSeqWith(mazeSize.height, newSeq[bool](mazeSize.width))

  var maze: Maze = Maze(size: mazeSize, mazeMap: mazeSeq, searchedMap: searchedSeq)

  var index = maze.mazeMap.getStartIndex
  if index.isNil: #問題としてありえないとは思うが
    echo "No"
    quit(QuitSuccess)

  var stack: seq[Coordinate]
  stack.add(index)
  maze.searchedMap[index.y][index.x] = true

  while stack.len >= 0:
    #showSearchedMap(maze.searchedMap)
    #echo " now index : ", index.x, ", ", index.y
    var nextIndex: Coordinate
    for operation in Operattion:
      if maze.checkGoalAround(index, operation):
        echo "Yes"
        quit(QUITSUCCESS)
    for operation in Operattion:
      nextIndex = maze.getNextIndexOnStreet(index, operation)
      if not nextIndex.isNil:
        stack.add(nextIndex)
        maze.searchedMap[nextIndex.y][nextIndex.x] = true
        index = nextIndex
        #echo "next index : ", nextIndex.x, ", ", nextIndex.y
        break
    # ここもっときれいにしたい
    if nextIndex.isNil:
      try:
        nextIndex = stack.pop
      except IndexDefect:
        echo "No"
        quit(QuitSuccess)
      if index == nextIndex:
        try:
          index = stack.pop
        except IndexDefect:
          echo "No"
          quit(QuitSuccess)
      else:
        index = nextIndex
      #echo "back index : ", nextIndex.x, ", ", nextIndex.y
