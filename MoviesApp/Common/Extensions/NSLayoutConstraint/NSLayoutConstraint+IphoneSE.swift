//
//  NSLayoutConstraint+IphoneSE.swift
//  MoviesApp
//
//  Created by jorgehc on 08/04/20.
//  Copyright © 2020 jorgehc.com. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    @IBInspectable var iPhoneSEConstant: CGFloat {
        get {
            return constant
        }
        set {
            if DeviceType.IS_IPHONE_5 {
                constant = newValue
            }
        }
    }
}
