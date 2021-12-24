//
//  NotifiableBaseViewController.swift
//  MoviesApp
//
//  Created by jorgehc on 8/9/18.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//

import UIKit

//MARK: - Responder

/**
 Use on concrete views that should respond to keyboard notifications
 */
@objc protocol NotifiableKeyboardResponder {
    @objc optional func willShow(keyboardNotification: NSNotification)
    @objc optional func willHide(keyboardNotification: NSNotification)
    @objc optional func willChangeFrame(keyboardNotification: NSNotification)
}

class NotifiableBaseViewController: BaseViewController {
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initKeyboardObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Notifier.remove(observer: self)
    }
    
    private func initKeyboardObservers() {
        Notifier.keyBoardWillShow.observe(
            by: self,
            withSelector: #selector(willShow)
        )
        Notifier.keyBoardWillHide.observe(
            by: self,
            withSelector: #selector(willHide)
        )
        Notifier.keyBoardWillChangeFrame.observe(
            by: self,
            withSelector: #selector(willChangeFrame)
        )
    }
}

extension NotifiableBaseViewController: NotifiableKeyboardResponder {
    func willShow(keyboardNotification: NSNotification) {
        if let responderView = self as? ActionsContainerAwareView,
           let keyboardHeight = keyboardNotification.getKeyboardHeight() {
            
            if responderView.actionsView.y == responderView.initialContainerPosition {
                responderView.actionsView.y -= keyboardHeight
            }
        }
        
        if let responderView = self as? TextFieldContainerAwareView,
            let keyboardHeight = keyboardNotification.getKeyboardHeight() {
            var safeAreaBottomInset : CGFloat = 0
            
            if #available(iOS 11.0, *) {
                safeAreaBottomInset = view.safeAreaInsets.bottom
            }
            responderView.scrollToBottom()
            bottomConstraint.constant = -(keyboardHeight - safeAreaBottomInset)
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func willHide(keyboardNotification: NSNotification) {
        if let responderView = self as? ActionsContainerAwareView {
            if responderView.actionsView.y != responderView.initialContainerPosition {
                responderView.actionsView.y = responderView.initialContainerPosition
            }
        }
        
        if let _ = self as? TextFieldContainerAwareView {
            bottomConstraint.constant = 0
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func willChangeFrame(keyboardNotification: NSNotification) {
        if let _ = (keyboardNotification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if let responderView = self as? ActionsContainerAwareView,
                let keyboardHeight = keyboardNotification.getKeyboardHeight() {
                if responderView.actionsView.y != responderView.initialContainerPosition {
                    responderView.actionsView.y = responderView.initialContainerPosition - keyboardHeight
                }
            }
        }
    }
}

//MARK: - ActionsContainer

protocol ActionsContainerAwareView {
    var initialContainerPosition: CGFloat! { get set }
    var actionsView: UIView { get }
}

protocol TextFieldContainerAwareView {
    var initialContainerPosition: CGFloat! { get set }
    var textFieldView: UIView { get }
    func scrollToBottom()
}

extension ActionsContainerAwareView where Self: UIViewController {
    /**
     TODO: Add proper docs.
     */
    func adjustActionContainerHeight() {
        if(DeviceType.IS_IPHONE_5) {
            let viewHeight = ScreenSize.height
            let containerHeight = viewHeight * 0.20
            actionsView.frame = CGRect(
                x: actionsView.frame.origin.x,
                y: viewHeight - containerHeight,
                width: actionsView.frame.width,
                height: containerHeight
            )
        }
    }
}

//MARK: - Helper
extension NSNotification {
    /// Handy method to retrieve current keyboard height.
    func getKeyboardHeight() -> CGFloat? {
        guard
            let userInfo = userInfo,
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
            return nil
        }
        return frame.cgRectValue.height
    }
}
