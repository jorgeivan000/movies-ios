//
//  UIViewController+Alerts.swift
//  MoviesApp
//
//  Created by jorgehc on 9/26/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func displayAlert(withMessage message: String) {
        let alert = UIAlertController(style: .alert, title: .error, message: message)
        alert.addAction(title: .understood, style: .default) { action in
            self.dismiss(animated: true)
        }
        alert.show()
    }
    
    func displayAlertWithTitle(withMessage message: String, title: String) {
        let alert = UIAlertController(style: .alert, title: title, message: message)
        alert.addAction(title: .understood, style: .default) { action in
            self.dismiss(animated: true)
        }
        alert.show()
    }
}
