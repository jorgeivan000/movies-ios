//
//  UIViewController+Styles.swift
//  MoviesApp
//
//  Created by jorgehc on 12/15/17.
//  Copyright © 2017 jorgehc.com. All rights reserved.
//

import UIKit

//MARK: Style Helper
extension UIViewController {
    func setStyle(_ style: Style, for views: UIView...) {
        views.forEach { view in
            view.setStyle(style)
        }
    }
    
    func setDelegate(_ delegate: UITextFieldDelegate, for fields: UITextField...) {
        fields.forEach { field in
            field.delegate = delegate
        }
    }
}
