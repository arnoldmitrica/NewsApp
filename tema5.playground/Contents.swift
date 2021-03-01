import UIKit
import Foundation

var word = "MAX"
var wordappend = ""
//var s = "AAAAXAPPPPPPLLEEEE"
var s = "XXXAAAMMM"

func search(wordul: String, index: String.Index, numberOfLoops:Int) -> Int{
    print("\n Start \n")
    var wordu = wordul  // just a copy of the word so I could have a better debugging
    print("word[index] \(word[index])")
    guard var position = wordu.firstIndex(of: word[index]) else { return numberOfLoops }
    print("numberofLoops \(numberOfLoops)")
    print("position:\(position)")
    print("wordu:\(wordu)")
    print("wordu[position]: \(wordu[position])")
    var lastWorduPosition = wordu[position]
    print("word before \(word) cu word.first \(String(describing: word.first))")
    if (wordu[position] == word.first && wordu.first != word.first){
        print("wordtoremove")
        let wordtoremove = String(wordu[String.Index(utf16Offset: 0, in: wordu)..<position])
        print("wordtoremove2")

        wordu.removeFirst(wordtoremove.count)
        position = String.Index(utf16Offset: 0, in: wordu)
        print("wordu after remove \(wordu)")
    }
    else{
        if(word[index] == wordu.last && wordu.first == wordu.last){   // Last letter check
            if let w = wordu.last {
                if let endi = wordu.lastIndex(of: w){
                    if position == endi{  //check if it is the last index or not
                        if wordu[position] == wordu[endi] {
                            return numberOfLoops+1  //if it is the same letter , then ++ to the number of loops
                        }
                        return numberOfLoops  // it is the last position so it must return something
                    }
                }
            }
        }
        var endind:String.Index?
        if let w = word.last {
            if let endi = word.lastIndex(of: w){
                endind = endi
            }
        }
        if let end = endind{
            if let last = word.index(index, offsetBy: 1, limitedBy: end) {
                lastWorduPosition = word[last]
            }
        }
    }
    print("lastWorduPosition \(lastWorduPosition)")
    print("beforeLast letter")
    let lastLetter = wordu[position]
    
    if wordu.contains(word[index]) == false {
        return numberOfLoops
    }
    print("wordappend before \(wordappend)")
    wordappend.append(wordu[position])
    print("wordappend after \(wordappend)")

    if wordappend == word{
        print("wordappend released \(wordappend), with numberofloops \(numberOfLoops)")
        wordappend = ""  // This is the word that we try to fullfill with the word named "word", after a completion, it resets.
        return search(wordul: wordu, index: word.startIndex, numberOfLoops: numberOfLoops+1)
    }
    
    wordu.remove(at: position)
    
    print("wordu after remove \(wordu)")
    
    var wordendind2:String.Index?
    if let w = word.last {
        if let endi = word.lastIndex(of: w){
            wordendind2 = endi
        }
    }
    //print("word[nextwordind] \(word[nextwordind])")
    if let wordendind = wordendind2 {
        print("wordedind: \(wordendind)")
        if let nextwordind = word.index(index, offsetBy: 1,limitedBy: wordendind) {
            print("nextwordind \(nextwordind)")
            print("wordu.last \(String(describing: wordu.last))")
            //print("word[nextwordind] \(word[nextwordind])")
            var endind:String.Index?
            if let w = wordu.last {
                if let endi = wordu.lastIndex(of: w){
                    endind = endi
                }
            }
            if let endcharindex = endind{
                print("wordu[wordu.endIndex] \(wordu[endcharindex])")
                print("wordu in endcharindex \(wordu)")
//
                print("wordu[position]: \(wordu[position])")
                var w = wordu[wordu.startIndex...endcharindex]
                print("w: \(w)")
                print("word[nextwordind] \(word[nextwordind])")
                if let nextworduindex = w.firstIndex(of: word[nextwordind]) {
                    print("nextworduindex \(nextworduindex)")
                    print("nextwordind \(nextwordind)")
                    //print("wordu[nextworduindex] \(wordu[nextworduindex])")
                    //print("word[nextwordind] \(word[nextwordind])")
                    print("wordu[position]: \(wordu[position])")
                    var wordnow = ""
                    if position > nextworduindex{
                        print("position <= nextworduindex")
                        wordnow = String(wordu[nextworduindex...position])
                        //wordnow.remove(at: String.Index(utf16Offset: 0, in: wordnow))
                        //wordnow.append(wordu[position])
                    }
                    else {
                        print("position <= nextworduindex")
                        print("wordu \(wordu)")
                        print("wordu[nextworduindex]: \(wordu[nextworduindex])")
                        print("wordu[position]: \(wordu[position])")
                        print("wordu position: \(position)")
                        print("wordu nextworduindex: \(nextworduindex)")
                        wordnow = String(wordu[wordu.startIndex..<nextworduindex])
                        print("wordnow \(wordnow) and w -- now \(w)")
                        w.removeFirst(wordnow.count)
                        print(" 'w' --now: \(w)")
                        print("wordappend now \(wordappend)")
                        var cpywordnow = wordnow
                        print("lastLetter:\(lastLetter)")
                        cpywordnow.removeAll(where: { !wordappend.contains($0) })  //!($0 == lastLetter
                        print("cpywordnow \(cpywordnow)")
                        w = cpywordnow + w
                        print("w then: \(w)")
                    }
                    print("wordnow: \(wordnow)")
                    return search(wordul: String(w), index: nextwordind, numberOfLoops: numberOfLoops)
                }
                
            }
            //        let w = wordu[position...endind]
            //        print("w:\(w)")
            print("wordu before wordappend \(wordu)")
        }
        return numberOfLoops
    }
    return numberOfLoops
}

print(search(wordul: s, index: word.startIndex, numberOfLoops: 0))


