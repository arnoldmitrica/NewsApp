import UIKit
import Foundation
//var str = "ELPPAELPPAELPPAELPPA"
//
//var word = "APPLE"
//
//var setWord = Set<Character>()
//
//var squeezedWord = word.filter{ setWord.insert($0).inserted }
//
//var duplicatesarrayWord = setWord.sorted().map { x in word.filter { $0 == x}.count }.reversed() as [Int]
//
//var setWordSorted = setWord.sorted().reversed() as [Character]
//
//var duplicatesarrayStr = setWordSorted.map { x in str.filter { $0 == x}.count }.filter { $0 != 0 } as [Int]
//
//print(zip(duplicatesarrayWord,duplicatesarrayStr).map{$1 / $0}.min() ?? "Nil unrwapped" as Any)

//
//func maximumNumberOfMoves(sampleWord wordu:String, appliedTo stru: String) -> Any {
//
//    var setWord = Set<Character>()
//
//    return zip(wordu.filter{ setWord.insert($0).inserted }.sorted().map { x in wordu.filter{ $0 == x}.count }.reversed() as [Int], (setWord.sorted().reversed() as [Character]).map { x in stru.filter { $0 == x}.count }.filter { $0 != 0 } as [Int]).map{$1/$0}.min() ?? "Nil unrwapped" as Any
//
//}
//
//print(maximumNumberOfMoves(sampleWord: "APPLE", appliedTo: "PEPELEA"))

//var m = 0
//var word = ""
//if "AAAAAPPLE".contains("APPLE") {
//    m+=1
//    print(m)
//    let y = "AAAAAPPLE".firstIndex { (x) -> Bool in
//        print("3")
//
//        if "AAAAAPPLE".contains(x){
//            print("1")
//            return true
//        }
//        print("2")
//        return false
//    }
//
//    print(y as Any)
//}

//func tell(number: Int){
//    if number == 0 {
//        return
//    }
//    print("number: \(number)")
//    tell(number: number-1)
//}
//
//tell(number: 3)

//let codes = ["APPLE"]
//let text = codes.reduce("A", -)
//print(text)


var word = "AAPPLEE"
var wordappend = ""
var worda = word.first
var s = "AAAAXAPPPPPPLEE"
let c = s.index(s.startIndex, offsetBy:8)
let p = s[c]
let r = word.startIndex

func search(wordul: String, index: String.Index, numberOfLoops:Int) -> Int{
    let n = numberOfLoops
    print("numberOfLoops \(n)")
    var wordu = wordul
    print("wordu: \(wordu)")
    print("Letter to search in s: \(word[index])")

    //let i = wordu.firstIndex(of: word[index])
    //print(i)
    //let position = wordu.firstIndex(of: word[index])
    if wordu.contains(word[index]) == false {
        return n
    }
    guard let position = wordu.firstIndex(of: word[index]) else { return n }
    
//    if wordu.firstIndex(of: word[index]) == nil {
//        return n
//    }

    //print("p \(position)")
    wordappend.append(wordul[position])
    print("Cuvantul format: \(wordappend)")
    if wordappend == word{
        wordappend = ""
        search(wordul: wordu, index: word.startIndex, numberOfLoops: n+1)
        return n+1
    }
    wordu.remove(at: position)
    if let ind = wordu.index(index, offsetBy: 1,limitedBy: s.endIndex) {
        //print("Pozitia lui \(word[index]) in s este \(i)")
        print("string s: \(wordu)")
        search(wordul: wordu, index: ind, numberOfLoops: n)
    }
    return numberOfLoops
}
print(search(wordul: s, index: word.startIndex, numberOfLoops: 0))

//let h = "APPLE"
//print(h.firstIndex(of: "X"))
