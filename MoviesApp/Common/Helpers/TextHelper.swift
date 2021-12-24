//
//  TextHelper.swift
//  MoviesApp
//
//  Created by jorgehc on 12/27/17.
//  Copyright © 2017 jorgehc.com. All rights reserved.
//

import UIKit

struct TextChunkDecorable {
    let content: String
    let textColor: UIColor
    let fontSize: CGFloat
    let isBold: Bool
    
    func toMutableAttrString() -> NSMutableAttributedString {
        let font = isBold ? UIFont.systemFont(ofSize: fontSize) : UIFont.boldSystemFont(ofSize: fontSize)
        return NSMutableAttributedString(
            string: content,
            attributes: [
                NSAttributedString.Key.font : font,
                NSAttributedString.Key.foregroundColor : textColor
            ]
        )
    }
}

class TextHelper {
    static func makeText(
        for body: TextChunkDecorable, withPrefix: TextChunkDecorable? = nil, withSufix: TextChunkDecorable? = nil
        ) -> NSMutableAttributedString {
        
        var textMutable = body.toMutableAttrString()
        
        if let prefix = withPrefix {
            textMutable = StringHelper.buildCombinatedContent(prefix.toMutableAttrString(), textMutable)
        }
        
        if let sufix = withSufix {
            textMutable = StringHelper.buildCombinatedContent(textMutable, sufix.toMutableAttrString())
        }
        
        return textMutable
    }
}
