import UIKit
import Foundation

var word = "AAPPLEE"
var wordappend = ""
//var s = "AAAAXAPPPPPPLLEEEE"
var s = "AAPPLLLLEE"

func search(wordul: String, index: String.Index, numberOfLoops:Int) -> Int{
    var wordu = wordul  // just a copy of the word so I could have a better debugging
    guard let position = wordu.firstIndex(of: word[index]) else { return numberOfLoops }

    if wordu.contains(word[index]) == false {
        return numberOfLoops
    }

    wordappend.append(wordul[position])
    
    wordu.remove(at: position)
    if wordappend == word{
        wordappend = ""  // This is the word that we try to fullfill with the word named "word", after a completion, it resets.
        return search(wordul: wordu, index: word.startIndex, numberOfLoops: numberOfLoops+1)
    }
    
    if let ind = word.index(index, offsetBy: 1,limitedBy: word.endIndex) {
        //print("Position of \(word[index]) in s este \(i)")
        print("string s sau wordu: \(wordu)")  //After character removal, what is left out of it.
        return search(wordul: wordu, index: ind, numberOfLoops: numberOfLoops)
    }

    return numberOfLoops
}

//search iterates recursively over the string word in an order manner, until string s does not contain the character from the respectively index(word[index] is the iterated character) from the string word
print(search(wordul: s, index: word.startIndex, numberOfLoops: 0))

