//
//  Double+Ext.swift
//

import Foundation
import UIKit

extension Double {
    func moneyStringWith(numberOfDigits: Int) -> String {
        return "$\(self.stringWith(numberOfDigits: numberOfDigits))"
    }
    
    func twoDigitsString() -> String {        
        return self.stringWith(numberOfDigits: 2)
    }
    
    func stringWith(numberOfDigits: Int) -> String {
        return String(format:"%.\(numberOfDigits)f", self)
    }
    
    func toCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = .empty
        formatter.currencyCode = .empty
        guard let formattedAmount = formatter.string(from: self as NSNumber) else { return "0.0" }
        return formattedAmount.filter("0123456789.-,".contains)
    }
    
    func toInt() -> Int {
        return Int(exactly: self) ?? 0
    }
    
    func toIntegerString() -> String {
        return String(describing: self.toInt())
    }
}

extension CGFloat {
    func asPercentage(_ percetage: Int) -> CGFloat {
        return self * CGFloat(percetage)
    }
}
