//
//  ViewController+Visibility.swift
//  MoviesApp
//
//  Created by jorgehc on 8/15/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import UIKit

extension UIViewController {
    func isVisible() -> Bool {
        return isViewLoaded && view?.window != nil
    }
}
