echo "==== Q1 ===="

const YearToDay: int = 365
let age: int = 21

echo age * YearToDay


echo "==== Q2 ===="

echo age mod 3


echo "==== Q3 ===="

const CmInInch: float = 2.54
let height: int = 184

echo float(height) / CmInInch


echo "==== Q4 ===="

let diameter: float = 3 / 8

echo diameter * CmInInch


echo "==== Q5 ===="

let firstName: string = "RiRy"
let lastName: string = "Casals"

echo firstName & " " & lastName


echo "==== Q6 ===="

const DeadLine: int = 30

let aliceInterval: int = 15
let aliceEarn: float = 400 * float(DeadLine / aliceInterval)

let bobInterval: int = 8
let bobEarn: float = 3.14 * float(bobInterval * DeadLine)

echo aliceEarn > bobEarn
