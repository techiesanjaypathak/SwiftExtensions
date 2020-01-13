import Foundation

/* SWAP
  a = a + b
  b = a - b
  a = a - b
  OR
  a = a ^ b
  b = a ^ b
  a = a ^ b
  OR
  swap(&a, &b)
  OR
  (a,b) = (b,a)
*/

func generateRandomNumber(betweenMinValue minVal:Int, andMaxVal maxVal:Int) -> Int {
    //return Int.random(in: ClosedRange(uncheckedBounds: (lower: minVal, upper: maxVal)))
    return Int(arc4random_uniform(UInt32(maxVal - minVal + 1))) + minVal
}

func myPow(_ x: Int, _ y: Int) -> Int {
    return Int(pow(Double(x), Double(y)))
}

func reverseEightBit(_ num:Int) -> Int? {
    let bin = String(num, radix: 2)
    let padding = String(repeating: "0", count: 8 - bin.count)
    let paddedStr = padding + bin
    let reversed = String(paddedStr.reversed())
    return Int(reversed, radix: 2)
}

func isFrom0To9(_ str: String) -> Bool {
    let filteredString = str.filter{$0>="0" && $0<="9"}
    return filteredString.count == str.count
}

func sumOfAllNumbers(inString str:String) -> Int {
    return str.filter{$0>="0"&&$0<="9"}.reduce(0 , { (res, ch) -> Int in
        res + (Int(String(ch)) ?? 0)
    })
}

func findSqrt(forInteger num: Int) -> Int {
    var min = 1
    var max = num
    var mid = 1
    while(min <= max){
        mid = (min + max) / 2
        let midSquare = mid * mid
        if midSquare == num {
            return mid
        } else if midSquare > num {
            max = mid - 1
        } else {
            min = mid + 1
        }
    }
    return mid
}

// The lowest negative number starts with a one and followed by all zeros
/*  0    = 00000000
    -128 = 10000000
    -127 = 10000001
    -64  = 11000000
    -1   = 11111111
 */

func subtractWithoutMinusSign(_ num1: Int,_ num2: Int ) -> Int{
    return num1 + (~num2 + 1)
}

func main(){
    generateRandomNumber(betweenMinValue: 8, andMaxVal: 10)
    myPow(2, 4)
    reverseEightBit(148)
    isFrom0To9("1.01")
    sumOfAllNumbers(inString: "aht356bynrebynr46")
    findSqrt(forInteger: 9)
    subtractWithoutMinusSign(8,3)
}

main()
