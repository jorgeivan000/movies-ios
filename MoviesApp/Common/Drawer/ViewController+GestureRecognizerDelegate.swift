//
//  ViewController+GestureRecognizerDelegate.swift
//  MoviesApp
//
//  Created by jorgehc on 06/08/18.
//  Copyright © 2018 Pablo Marrufo. All rights reserved.
//

import UIKit

extension UIViewController: UIGestureRecognizerDelegate {
    /// Function used to interactively toggle the drawerTableView scroll and let the drawer listen to the panGesture correctly.
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let gesture = gestureRecognizer as? UIPanGestureRecognizer,
              let drawerController = self as? DrawerViewControllerProtocol else {
                return false
        }
        
        let isCollapsed = drawerController.state == .collapsed
        let tableViewHasNoContentOffset = drawerController.drawerTableView?.contentOffset.y == 0
        let direction = gesture.velocity(in: view).y
        let scrollDirectionIsPositve = direction > 0
        
        let scrollDisabled = isCollapsed || (tableViewHasNoContentOffset && scrollDirectionIsPositve)
        
        drawerController.drawerTableView?.isScrollEnabled = !scrollDisabled
        
        return false
    }
}
