//
//  UILabel+AttributedText.swift
//  MoviesApp
//
//  Created by jorgehc on 10/10/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setAttributedRangedText(textToInsert text: String, staticText: String) {
        let formattedStaticText = text == .zero ? String(staticText.dropFirst()) : staticText
        let endIndex = text == .zero ? String.noLimit.count + 1 : text.count + 1
        let textToInsert: String =  text == .zero ? .noLimit : text
        let joinedString = String(format: formattedStaticText, textToInsert)
        let attributedText = NSMutableAttributedString(string: joinedString)
        attributedText.addAttribute(.font, value: UIFont.circularStdBold, range: NSRange(location: 0, length: endIndex))
        self.attributedText = attributedText
    }
    
    func setAttributedRangedTextForLevelTwoPayments(_ firstAmount: String, _ secondAmount: String , staticText: String) {
        let firstText = firstAmount == .zero ? String.noLimit : "$\(firstAmount)"
        let secondText = secondAmount == .zero ? String.noLimit : "$\(secondAmount)"
        let finalString = String(format: staticText, firstText, secondText)
        let attributedText = NSMutableAttributedString(string: finalString)
        attributedText.addAttribute(.font, value: UIFont.circularStdBold, range: NSRange(location: 0, length: firstText.count))
        let secondLabelLocation = firstText.count + 19
        attributedText.addAttribute(.font, value: UIFont.circularStdBold, range: NSRange(location: secondLabelLocation, length: secondText.count))
        self.attributedText = attributedText
    }
    
    func setRangedTextColor(_ color: UIColor, with range: NSRange) {
        let attText = NSMutableAttributedString(string: self.text!)
        attText.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        attributedText = attText
    }
    
    func addCharactersSpacing(_ value: CGFloat = 1.15) {
        if let textString = text {
            let attrs: [NSAttributedString.Key : Any] = [.kern: value]
            attributedText = NSAttributedString(string: textString, attributes: attrs)
        }
    }
}
