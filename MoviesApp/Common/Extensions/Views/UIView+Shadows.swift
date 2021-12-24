//
//  UIView+Shadows.swift
//  MoviesApp
//
//  Created by jorgehc on 4/17/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import UIKit

extension UIView {
    func applyShadow(cornerRadius radius: CGFloat? = 10.0) {
        self.layer.cornerRadius = radius!
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.2
    }
}
