//
//   ButtonWithDisableStyle.swift
//  MoviesApp
//
//  Created by jorgehc on 8/30/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import UIKit

extension UIButton {
    func setEnabledStyle(_ isEnabled: Bool) {
        self.alpha = isEnabled ? 1 : 0.5
    }
}
