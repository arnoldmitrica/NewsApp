import UIKit
import Foundation

var word = "MAX"
var wordappend = ""
//var s = "AAAAXAPPPPPPLLEEEE"
var s = "MAXIMILIAN"

func search(wordul: String, index: String.Index, numberOfLoops:Int) -> Int{
    print("\n Start \n")
    var wordu = wordul  // just a copy of the word so I could have a better debugging
    guard let position = wordu.firstIndex(of: word[index]) else { return numberOfLoops }
    print(position)

    if wordu.contains(word[index]) == false {
        return numberOfLoops
    }

    wordappend.append(wordul[position])

    wordu.remove(at: position)
    print("wordu[position] = \(wordu[position])")
    print("wordu before wordappend \(wordu)")
    if wordappend == word{
        wordappend = ""  // This is the word that we try to fullfill with the word named "word", after a completion, it resets.
        return search(wordul: wordu, index: word.startIndex, numberOfLoops: numberOfLoops+1)
    }
    
    if let ind = word.index(index, offsetBy: 1,limitedBy: word.endIndex) {
        //print("Position of \(word[index]) in s este \(i)")
        print("string s sau wordu: \(wordu)")  //After character removal, what is left out of it.
        //let c = wordu.index
        let d = word[ind]
        print("word[index] \(word[index])")
        let de = word[index]
        print("word[ind] \(word[ind])")
        print(wordappend)

        if let index = wordu.range(of: String(word[ind]))?.upperBound {
            //print("Index's word[index] \(word[index])")
            print("wordu at first index check \(wordu)")
            //let substring = word[..<index]                 // "ora"
            //let d = word.suffix(from: index)
            let substring = wordu.suffix(from: index) //
            var stringfromit = String(substring)
            print("stringfromit before : \(stringfromit)")
            
            let i = String.Index(utf16Offset: 0, in: stringfromit)
            stringfromit.insert(d, at: i)
            print("substring: \(stringfromit)")
            if let index = wordu.range(of: String(word[ind]))?.lowerBound {
                let substringup = wordu.prefix(upTo: index)
                var stringfromitup = String(substringup)
               // let iup = String.Index(utf16Offset: 0, in: stringfromitup)
                //stringfromitup.insert(contentsOf: substringup, at: iup)
                print("stringfromitup \(stringfromitup)")
                if stringfromitup.isEmpty {
                    wordu = stringfromit
                }
                else{
                    if stringfromitup.contains(d){
                        print("d == \(d)")
                        wordu = stringfromit
                    }
                    else{
                        wordu = stringfromitup + stringfromit
                    }
                }
            }
//            // (see picture below) Using the prefix(upTo:) method is equivalent to using a partial half-open range as the collection’s subscript.
//            // The subscript notation is preferred over prefix(upTo:).
//
//            let string = String(substring)
            //wordu = stringfromit // "ora"
            
            
        }
        print("wordu after removing substring: \(wordu) cu wordappend \(wordappend)")
        return search(wordul: wordu, index: ind, numberOfLoops: numberOfLoops)
    }

    return numberOfLoops
}

//search iterates recursively over the string word in an order manner, until string s does not contain the character from the respectively index(word[index] is the iterated character) from the string word
print(search(wordul: s, index: word.startIndex, numberOfLoops: 0))

var plm = "AAPPLLLLEE"
//if let index = plm.range(of: String("E"))?.upperBound {
//    let substring = word.suffix(from: index)
//
//}

//if let range = plm.range(of: "E"){
//    print(plm.substring(to: range.upperBound))
//    plm.spl
//}



