import Foundation

public extension Int {
    
    var roman: String? {
        
        var resultString: String = ""
        
        if self > 0 {
        
            let decimals = [1000, 900,  500, 400,  100, 90,   50,  40,   10,  9,    5,   4,    1]
            let roman =    ["M",  "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
            
            var enteredValue = self
            
            while enteredValue != 0 {
                for (index, value) in decimals.enumerated() {
                    if enteredValue - value >= 0 {
                        resultString += roman[index]
                        enteredValue -= value
                        break
                    }
                    
                }
                    
            }
        }
        else { return nil }
        
        return resultString
    }
}
