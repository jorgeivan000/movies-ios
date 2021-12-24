//
//  UITextField+Ext.swift
//  MoviesApp
//
//  Created by jorgehc on 8/16/18.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//

import Foundation
import UIKit
private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        guard let text = textField.text else { return }
        textField.text = text.safelyLimitedTo(length: maxLength)
    }
}

extension String {
    func safelyLimitedTo(length: Int) -> String {
        if (count <= length) {
            return self
        }
        return String( Array(self)[..<length] )
    }
}
