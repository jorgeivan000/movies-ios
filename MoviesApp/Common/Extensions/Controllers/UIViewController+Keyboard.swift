//
//  UIViewController+Ext.swift
//  MoviesApp
//
//  Created by jorgehc on 11/12/17.
//  Copyright © 2017 jorgehc.com All rights reserved.
//

import UIKit

//MARK: - Keyboard
extension UIViewController {
    @objc func dismissKeyboard(_ tap: UITapGestureRecognizer) {
        var touchNotInFirstResponder = true
        
        if let firstResponder = view.firstResponder {
            if firstResponder.frame.contains(tap.location(in: view)) {
                touchNotInFirstResponder = false
            }
        }
        
        if touchNotInFirstResponder {
            view.endEditing(true)
        }
    }
    
    func addDismissGestureRecognizer() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(UIViewController.dismissKeyboard(_:))
        )
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
