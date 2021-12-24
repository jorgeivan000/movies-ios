//
//  DrawerViewControllerProtocol.swift
//  MoviesApp
//
//  Created by jorgehc on 06/08/18.
//  Copyright © 2018 Pablo Marrufo. All rights reserved.
//

import UIKit

/**
 Protocol for making a ViewController a drawer of another ViewController.
 # To implement it:
 ## Presenting ViewController
 - Add as a subview the `view` of the DrawerViewController.
 ## Drawer ViewController
 - Conform to the Protocol "DrawerViewControllerProtocol".
 - Implement the **state** property and set its initial state.
 - Add a **pan** GestureRecognizer with callback function named **drawerPanGestureCallback**.
   This can be done with the function **addDrawerPanGesture**
 - **Optional** provide a drawerTableView for interactively collapse the drawer.
 */
protocol DrawerViewControllerProtocol: class {
    /// The drawer current state.
    var state: DrawerState { get set }
    /// Optional TableView that can close the drawer when scroll downwards.
    var drawerTableView: UITableView? { get }
    
    /**
     Function for changing and animating a change of state in the drawer.
     - Parameter state: the new state of the drawer.
     - Parameter duration: State change duration in seconds. Default is 0.
     - Parameter completion: Completion closure that will be called at the end of the animation. Default is nil.
     */
    func toggleDrawer(to state: DrawerState, with duration: TimeInterval, completion: ((Bool) -> Void)?)
}

extension DrawerViewControllerProtocol where Self: UIViewController {
    
    var drawerTableView: UITableView? { return nil }
    
    func toggleDrawer(to state: DrawerState, with duration: TimeInterval = 0, completion: ((Bool) -> Void)? = nil) {
        self.state = state
        UIView.animate(
            withDuration: duration,
            delay: 0.0,
            options: [.allowUserInteraction],
            animations: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.view.y = state.y
            },
            completion: completion
        )
    }
}
