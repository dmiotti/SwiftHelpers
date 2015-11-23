//
//  SHCreditCardValidator.swift
//  SwiftHelpers
//
//  Created by David Miotti on 23/11/15.
//  Copyright © 2015 Wopata. All rights reserved.
//

import UIKit

public struct SHCreditCardValidationType: Equatable {
    
    public var name: String
    
    public var regex: String
    
    public init(dict: [String: AnyObject]) {
        if let name = dict["name"] as? String {
            self.name = name
        } else {
            self.name = ""
        }
        
        if let regex = dict["regex"] as? String {
            self.regex = regex
        } else {
            self.regex = ""
        }
    }
    
}

public func ==(lhs: SHCreditCardValidationType, rhs: SHCreditCardValidationType) -> Bool {
    return lhs.name == rhs.name
}

public class SHCreditCardValidator {
    
    public lazy var types: [SHCreditCardValidationType] = {
        var types = [SHCreditCardValidationType]()
        for object in SHCreditCardValidator.types {
            types.append(SHCreditCardValidationType(dict: object))
        }
        return types
    }()
    
    public init() { }
    
    /**
     Get card type from string
     
     - parameter string: card number string
     
     - returns: CreditCardValidationType structure
     */
    public func typeFromString(string: String) -> SHCreditCardValidationType? {
        for type in types {
            let predicate = NSPredicate(format: "SELF MATCHES %@", type.regex)
            let numbersString = self.onlyNumbersFromString(string)
            if predicate.evaluateWithObject(numbersString) {
                return type
            }
        }
        return nil
    }
    
    /**
     Validate card number
     
     - parameter string: card number string
     
     - returns: true or false
     */
    public func validateString(string: String) -> Bool {
        let numbers = self.onlyNumbersFromString(string)
        if numbers.characters.count < 9 {
            return false
        }
        
        var reversedString = ""
        let range = Range<String.Index>(start: numbers.startIndex, end: numbers.endIndex)
        
        numbers.enumerateSubstringsInRange(range, options: [NSStringEnumerationOptions.Reverse, NSStringEnumerationOptions.ByComposedCharacterSequences]) { (substring, substringRange, enclosingRange, stop) -> () in
            reversedString += substring!
        }
        
        var oddSum = 0, evenSum = 0
        let reversedArray = reversedString.characters
        var i = 0
        
        for s in reversedArray {
            
            let digit = Int(String(s))!
            
            if i++ % 2 == 0 {
                evenSum += digit
            } else {
                oddSum += digit / 5 + (2 * digit) % 10
            }
        }
        return (oddSum + evenSum) % 10 == 0
    }
    
    /**
     Validate card number string for type
     
     - parameter string: card number string
     - parameter type:   CreditCardValidationType structure
     
     - returns: true or false
     */
    public func validateString(string: String, forType type: SHCreditCardValidationType) -> Bool {
        return typeFromString(string) == type
    }
    
    public func onlyNumbersFromString(string: String) -> String {
        let set = NSCharacterSet.decimalDigitCharacterSet().invertedSet
        let numbers = string.componentsSeparatedByCharactersInSet(set)
        return numbers.joinWithSeparator("")
    }
    
    // MARK: - Loading data
    
    private static let types = [
        [
            "name": "Amex",
            "regex": "^3[47][0-9]{5,}$"
        ], [
            "name": "Visa",
            "regex": "^4[0-9]{6,}$"
        ], [
            "name": "MasterCard",
            "regex": "^5[1-5][0-9]{5,}$"
        ], [
            "name": "Maestro",
            "regex": "^(?:5[0678]\\d\\d|6304|6390|67\\d\\d)\\d{8,15}$"
        ], [
            "name": "Diners Club",
            "regex": "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
        ], [
            "name": "JCB",
            "regex": "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
        ], [
            "name": "Discover",
            "regex": "^6(?:011|5[0-9]{2})[0-9]{3,}$"
        ], [
            "name": "UnionPay",
            "regex": "^62[0-5]\\d{13,16}$"
        ]
    ]
    
}
