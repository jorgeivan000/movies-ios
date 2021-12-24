//
//  UIView+Responder.swift
//  MoviesApp
//
//  Created by jorgehc on 29/08/18.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//

import UIKit

extension UIView {
    /// Returns the current first responder for the View
    var firstResponder: UIView? {
        guard !isFirstResponder else { return self }
        
        for subview in subviews {
            if let firstResponder = subview.firstResponder {
                return firstResponder
            }
        }
        return nil
    }
}
