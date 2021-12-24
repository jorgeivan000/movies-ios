//
//  UIFont+Ext.swift
//  MoviesApp
//
//  Created by jorgehc on 8/1/18.
//  Copyright 2018 jorgehc.com. All rights reserved.
//

import UIKit

enum Fonts: String {
    case circularStdBold = "CircularStd-Bold"
    case circularStdBook = "CircularStd-Book"
    case circularStdMedium = "CircularStd-Medium"
}

extension UIFont {
    class var circularStdBold: UIFont {
        return UIFont.custom(named: .circularStdBold)
    }
    
    class var circularStdBook: UIFont {
        return UIFont.custom(named: .circularStdBook)
    }
    
    class var circularStdMedium: UIFont {
        return UIFont.custom(named: .circularStdMedium)
    }
    
    class func custom(named font: Fonts) -> UIFont {
        let fontName = font.rawValue
        guard let customFont = UIFont(name: fontName, size: UIFont.labelFontSize) else {
            fatalError(
                """
                Failed to load the \(fontName) font.
                Make sure the font file is included in the project and
                the font name is spelled correctly.
                """
            )
        }
        
        return customFont
    }
}

extension UILabel {
    func assignFont(ofType: Fonts) {
        font = UIFontMetrics.default.scaledFont(for: UIFont.custom(named: ofType))
        adjustsFontForContentSizeCategory = true
    }
}

