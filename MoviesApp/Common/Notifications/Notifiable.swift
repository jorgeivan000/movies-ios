//
//  Notifiable.swift
//  MoviesApp
//
//  Created by jorgehc on 8/9/18.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//

import Foundation
import UIKit
/**
 Encapsulates keyboard notifications posibilites for the observer to susbcribe.
 */
enum Notifier: Notifiable {
    case keyBoardWillHide, keyBoardWillShow, keyBoardWillChangeFrame
    
    var name: Notification.Name {
        switch self {
        case .keyBoardWillHide:
            return UIResponder.keyboardWillHideNotification
        case .keyBoardWillShow:
            return UIResponder.keyboardWillShowNotification
        case .keyBoardWillChangeFrame:
            return UIResponder.keyboardWillChangeFrameNotification
        }
    }
}

/**
 Defines behavior for the observer to respond. Wrapper for NotificationCenter class.
 */
protocol Notifiable {
    var name: Notification.Name { get }
    
    func observe(by observer: Any, withSelector selector: Selector, object: Any?)
    
    static func remove(observer: Any)
}

//MARK: - Notifiable Default
extension Notifiable {
    func observe(by observer: Any, withSelector selector: Selector, object: Any? = nil) {
        NotificationCenter.default.addObserver(
            observer,
            selector: selector,
            name: name,
            object: object
        )
    }

    static func remove(observer: Any) {
        NotificationCenter.default.removeObserver(observer)
    }
}
