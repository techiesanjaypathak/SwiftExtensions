import Foundation

extension Character {
    func isConsonent() -> Bool {
        let consonents:[Character] = ["j", "t", "z", "g", "v", "b", "r", "k", "n", "s", "w", "T", "q", "h", "d", "c", "y", "l", "m", "f", "p", "x","D", "F", "N", "M", "P", "R", "T", "H", "W", "J", "L", "K", "B", "Z", "C", "Y", "G", "X", "V", "S", "Q"]
        for ch in consonents {
            if ch == self {
                return true
            }
        }
        return false
    }
    func isVowel() -> Bool {
        let vowels:[Character] = ["a","e","i","o","u","A","E","I","O","U"]
        for ch in vowels {
            if ch == self {
                return true
            }
        }
        return false
    }
}

extension String {
    func isAllCharactersUnique() -> Bool {
        return Set(self).count == self.count
    }
    func isPalindrome() -> Bool {
        return self.reversed() == Array(self)
    }
    func isContainingSameCharacters(withString str:String) -> Bool {
        let array1 = Array(self)
        let array2 = Array(str)
        return array1.count == array2.count && array1.sorted() == array2.sorted()
    }
    func isContaining(searchString str:String) -> Bool {
        return range(of: str, options: .caseInsensitive) != nil
    }
    func numberOfOccurences(ofString countString:String) -> Int {
        return self.count - self.replacingOccurrences(of: countString, with: "").count
    }
    func stringRemovingDuplicateCharacters() -> String {
        // Not the best
//        let uniqueChars = self.map{ String($0) }
//        let orderedSet = NSOrderedSet(array: uniqueChars)
//        let arrOfStr = Array(orderedSet) as! Array<String>
//        return arrOfStr.joined()
        
        // Not the best
//        var usedChars = [Character:Bool]()
//        return self.filter({ (ch) -> Bool in
//            return usedChars.updateValue(true, forKey: ch) == nil
//        })
        var usedChars = [Character]()
        for ch in self {
            if !usedChars.contains(ch) {
                usedChars.append(ch)
            }
        }
        return String(usedChars)
    }
    func condensingWhiteSpace() -> String {
        var chars = [Character]()
        var isPreviousSpace = false
        for ch in self {
            if ch == " " {
                if isPreviousSpace {
                   continue
                }
                isPreviousSpace = true
            } else {
                isPreviousSpace = false
            }
            chars.append(ch)
        }
        return String(chars)
        // Regular Expression is easy to write but performance is not great
//        return self.replacingOccurrences(of: " +", with: " ", options: .regularExpression, range: nil)
    }
    func isStringRotated(withString str:String) -> Bool {
//        if str == self {
//            return true
//        }
//        if str.count != self.count {
//            return false
//        }
//        if Set(str) != Set(self) {
//            return false
//        }
//        if str.count == 0 {
//            return true
//        }
//        for i in 1..<self.count {
//            let splitStartIndex = str.index(str.startIndex, offsetBy: i)
//            let endStr = self[splitStartIndex..<self.endIndex]
//            let startStr = self[self.startIndex..<splitStartIndex]
//            let newStr = "\(endStr)\(startStr)"
//            if newStr == str {
//                return true
//            }
//        }
        guard self.count == str.count else { return false }
        let combinedStr = self + self
        return combinedStr.contains(str)
    }
    func isPangram() -> Bool {
        let allLetters = Set(self.lowercased())
        let filteredLetters = allLetters.filter{ $0 >= "a" && $0 <= "z"}
        return filteredLetters.count == 26
    }
    typealias VowelCount = Int
    typealias ConsonentCount = Int
    func getVowelConsonentCount() -> (VowelCount,ConsonentCount){
        let vowelCount = self.filter { (ch) -> Bool in
            ch.isVowel()
        }.count
        let consonentCount = self.filter { (ch) -> Bool in
            ch.isConsonent()
        }.count
        return (vowelCount, consonentCount)
    }
    func isContainingDifferentCharatersLessThan(numberOfDifferentCharactersAllowed count:Int, inString str:String) -> Bool {
        var diffCount = 0
        let arr1 = Array(self)
        let arr2 = Array(str)
        for (index,element) in arr1.enumerated() {
            if arr2[index] != element {
                diffCount += 1
            }
            if diffCount > count {
                return false
            }
        }
        return true
    }
    func getLongestPrefix() -> String {
        let strArr = self.components(separatedBy: " ")
        if strArr.count == 0 { return "" }
        guard strArr.count > 1 else { return strArr[0] }
        var prefix = strArr[0]
        for shortestStr in strArr {
            if shortestStr.count < prefix.count {
                prefix = shortestStr
            }
        }
        for str in strArr {
            while(!str.hasPrefix(prefix)){
                prefix.removeLast()
            }
        }
        return prefix
    }
    func getRunLengthEncodedString() -> String {
        guard !self.isEmpty else { return self }
        var newStr = ""
        var count = 0
        newStr.append(self.first!)
        for ch in self {
            if newStr.last == ch {
                count += 1
            } else {
                newStr.append("\(count)\(ch)")
                count = 1
            }
        }
        if count != 0 {
            newStr.append("\(count)")
        }
        return newStr
    }
    func getAllPermutations(current: String = "") -> [String] {
        var arr = [String]()
        let length = self.count
        let strArray = Array(self)
        if (length == 0) {
            // there's nothing left to re-arrange; print the result
            arr.append(current)
        } else {
            // loop through every character
            for i in 0 ..< length {
                // get the letters before me
                let left = String(strArray[0 ..< i])
                // get the letters after me
                let right = String(strArray[i+1 ..< length])
                // put those two together and carry on
                let combined = left + right
                arr += combined.getAllPermutations(current: current + String(strArray[i]))
            }
        }
        return arr
    }
    func stringByReversingAllWords() -> String {
        let arr = components(separatedBy: " ") as! Array<String>
        let reversedWordsArr = arr.map { (str) -> String in
            String(str.reversed())
        }
        return reversedWordsArr.joined(separator: " ")
    }
}

func main(){
    "Hello World".isAllCharactersUnique()
    "rats live on no evil star".isPalindrome()
    "Hello World".isContainingSameCharacters(withString: "World")
    "Hello World".isContaining(searchString: "Wor")
    "Hello World".numberOfOccurences(ofString: "l")
    "Hello World".stringRemovingDuplicateCharacters()
    "San   jay     Path  ak".condensingWhiteSpace()
    "abcde".isStringRotated(withString: "cdeab")
    "The quick brown fox jumps over the lazy dog".isPangram()
    "Aeiouppppppprprprp".getVowelConsonentCount()
    "Clamp".isContainingDifferentCharatersLessThan(numberOfDifferentCharactersAllowed: 3, inString: "Grams")
    "swift switch swill swim".getLongestPrefix()
    "flip flap flop".getLongestPrefix()
    "aAAAAAabaa".getRunLengthEncodedString()
    "abc".getAllPermutations()
    "The quick brown fox".stringByReversingAllWords()
}

main()
