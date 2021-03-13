import UIKit

var dict:[String: Int] = ["one":1, "two": 2, "three" : 3, "four" : 4, "five" : 5, "six" : 6, "seven" : 7, "eight" : 8, "nine" : 9]
func multiply(n:Int, s: String) -> Int{
    if let num = dict[s]{
        return num * n
    }
    else{
        if let num = Int(s){
            return n * num
        }
    }
    return 0
}
//print(multiply(n: 3, s: "3"))

//extension Int conforms Sequence{
//
//}
func ascii(n:Int){
    for i in 0..<(n-1){
        var s=[String]()
//        s.append("U")
        for j in 0..<(n-2){
            if j==0{
                s.append("U")
            }
            if j==n-3{
                s.append("U")
            }
            else{
                s.append(" ")
            }
            if (j == n - 2) && (i == n - 2) {
                s.append("U")
            }
//            if j>0 && j<n-2{
//                s.append("U")
//            }
//            else{
//                if (j==n-2){
//                    if i<n-1{
//                        s.append("U")
//                    }
//                    else{
//                        s.append(" ")
//                    }
//                }
//
//            }
        }
        print(s)
    }
}
ascii(n: 4)

