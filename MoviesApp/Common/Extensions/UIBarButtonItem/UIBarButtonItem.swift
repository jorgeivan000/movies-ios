//
//  UIItemButton.swift
//  MoviesApp
//
//  Created by Jorge Herrera on 5/29/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    func style(tint color: UIColor, font f: UIFont? = nil) {
        let font = f ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        tintColor = color
        let atts = [
            NSAttributedString.Key.font : font,
            NSAttributedString.Key.foregroundColor : color
        ]
        setTitleTextAttributes(atts, for: .normal)
    }
}
