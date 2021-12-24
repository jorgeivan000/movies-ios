//
//  UIViewController+Subviews.swift
//  MoviesApp
//
//  Created by jorgehc on 06/08/18.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
     Adds a Child ViewController to the given view of a ViewController.
     - Parameter child: Child ViewController to be added.
     - Parameter containerView: The view where the Child ViewController will be added. Default value is nil
     */
    func add(_ child: UIViewController, to containerView: UIView? = nil) {
        addChild(child)
        let containerView = containerView ?? view!
        child.view.frame = containerView.bounds
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    
    /// Remove the current ViewController from its parent, if it has one.
    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
