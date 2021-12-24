//
//  UIScrollView+TopMargin.swift
//  MoviesApp
//
//  Created by jorgehc on 23/01/20.
//  Copyright © 2020 jorgehc.com. All rights reserved.
//

import UIKit

extension UIScrollView {
    func removeTopPadding() {
        let window = UIApplication.shared.keyWindow
        guard let topPadding = window?.safeAreaInsets.top else {
            return
        }
        if #available(iOS 13.0, *) {
            self.automaticallyAdjustsScrollIndicatorInsets = true
        }
        self.contentInset = UIEdgeInsets(top: -topPadding, left: 0, bottom: 0, right: 0)
    }
}
