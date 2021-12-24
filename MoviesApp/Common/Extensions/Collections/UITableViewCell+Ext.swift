//
//  UITableViewCell+Ext.swift
//  MoviesApp
//
//  Created by jorgehc on 3/20/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Helpers
extension UITableViewCell {
    func setSelectedColor(color: UIColor) {
        let view = UIView()
        view.backgroundColor = color
        self.selectedBackgroundView = view
    }
}
