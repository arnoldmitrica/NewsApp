import UIKit

let basket = ["string", "carrots", "egg","fox","sugar", "apple", "butter", "egg"]
var needs = ["sugar", "flour", "apple", "butter", "egg"]
let even = needs.filter { basket.contains($0) }
if needs == even {
    print("Basket contains all the needs")
}
else{
    print("Basket does not have all you need")
}
