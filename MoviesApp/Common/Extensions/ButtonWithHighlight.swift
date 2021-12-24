//
//  ButtonWithHighlight.swift
//  MoviesApp
//
//  Created by jorgehc on 5/14/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation
import UIKit

class ButtonWithHighlight: UIButton {
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
            } else {
                backgroundColor = UIColor.translucentWhite
            }
            super.isHighlighted = newValue
        }
    }
}
