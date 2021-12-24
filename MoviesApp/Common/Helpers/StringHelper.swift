//
//  StringHelper.swift
//  MoviesApp
//
//  Created by jorgehc on 12/27/17.
//  Copyright © 2017 jorgehc.com. All rights reserved.
//

import Foundation

class StringHelper {
    static func buildCombinatedContent(_ parts: NSMutableAttributedString...) -> NSMutableAttributedString {
        let combination = NSMutableAttributedString()
        parts.forEach { part in combination.append(part) }
        return combination
    }
}
