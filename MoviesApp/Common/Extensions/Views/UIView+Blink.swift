//
//  UIView+Blink.swift
//  MoviesApp
//
//  Created by jorgehc on 12/29/17.
//  Copyright © 2017 jorgehc.com. All rights reserved.
//

import UIKit

extension UIView {
    func blink() {
        self.alpha = 0.2;
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: [.curveEaseInOut, .autoreverse, .repeat],
            animations: { [weak self] in self?.alpha = 1.0 },
            completion: { [weak self] _ in self?.alpha = 0.0 }
        )
    }
}
