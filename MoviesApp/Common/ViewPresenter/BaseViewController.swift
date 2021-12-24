//
//  BaseViewController.swift
//  MoviesApp
//
//  Created by jorgehc on 11/16/17.
//  Copyright © 2017 jorgehc.com. All rights reserved.
//

import UIKit

protocol IndicatorDecorator {
    var indicatorColor: UIColor { get set }
}

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addDismissGestureRecognizer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dismissAnyAlertControllerIfPresent()
    }
    
    private func dismissAnyAlertControllerIfPresent() {
        guard let window :UIWindow = UIApplication.shared.keyWindow , var topVC = window.rootViewController?.presentedViewController else {return}
        while topVC.presentedViewController != nil  {
            topVC = topVC.presentedViewController!
        }
        if topVC.isKind(of: UIAlertController.self) {
            topVC.dismiss(animated: false, completion: nil)
        }
    }
}

extension BaseView {
    func setProgress(to isLoading: Bool, with alpha: CGFloat? = nil, overlay: UIColor? = nil) {
        setProgress(to: isLoading, with: alpha, overlay: overlay)
    }
}

extension BaseView where Self: UIViewController {
    func setProgress(to isLoading: Bool, with alpha: CGFloat?, overlay: UIColor?) {
        if isLoading {
            let color = (self as? IndicatorDecorator)?.indicatorColor ?? .persimon
            self.showIndicator(on: view, options: BaseViewIndicatorOptions(
                indicatorColor: color, alpha: alpha ?? 0.6, overlayColor: overlay ?? .white
            ))
        } else {
            DispatchQueue.main.async {
                self.hideActivityIndicator(on: self.view)
            }
        }
    }
    func displayWithTitle(_ title: String?, message: String?) {
        guard let message = message else { return }
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: String.okUppercased, style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.show()
    }
    
    func display(_ message: String?) {
        guard let message = message else { return }
        let alert = UIAlertController.init(title: String.appName, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: String.cancel, style: .cancel, handler: nil)
        let acceptAction = UIAlertAction.init(title: String.understood, style: .default, handler: nil)

        alert.addAction(acceptAction)
        alert.addAction(cancelAction)
        alert.show()
    }
}
