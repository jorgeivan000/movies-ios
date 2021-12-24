//
//  ViewController+PanGesture.swift
//  MoviesApp
//
//  Created by jorgehc on 06/08/18.
//  Copyright © 2018 Pablo Marrufo. All rights reserved.
//

import UIKit

class DrawerGestureRecognizer: UIPanGestureRecognizer {
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
    
    public var initialTouchLocation: CGPoint?
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        initialTouchLocation = touches.first!.location(in: view)
    }
}

extension UIViewController {
    
    /// Function for adding the PanGesture Recognizer needed for the drawer
    func addDrawerPanGesture() {
        let gesture = DrawerGestureRecognizer.init(target: self, action: #selector(drawerPanGestureCallback))
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
    }
    
    /**
     Callback for a the drawer PanGesture. If the ViewController implements the
     DrawerViewControllerProtocol performs all the logic for performing the drawer
     state change if needed.
     */
    @objc func drawerPanGestureCallback(_ recognizer: DrawerGestureRecognizer) {
        guard let drawerController = self as? DrawerViewControllerProtocol else { return }
        if recognizer.initialTouchLocation!.y <=  DrawerState.open.y {
            let translation = recognizer.translation(in: view)
            let velocity = recognizer.velocity(in: view)
            let yTouch = view.frame.minY + translation.y
            let localTouchPoint = CGPoint(x: 0, y: yTouch)
            let globalY = view.superview?.convert(localTouchPoint, to: nil).y ?? yTouch
            let touchLocationValid = globalY >= DrawerState.open.y && globalY <= DrawerState.collapsed.y
            if touchLocationValid {
                view.y = yTouch
                recognizer.setTranslation(CGPoint.zero, in: view)
            if recognizer.state == .ended {
                let nextDrawerState = drawerController.state.nextState(for: globalY)
                let distanceBetweenNextState = nextDrawerState.y - globalY
                let totalDistance = DrawerState.collapsed.y - DrawerState.open.y
                let duration = Double(distanceBetweenNextState / totalDistance).magnitude * 0.5
                drawerController.toggleDrawer(to: nextDrawerState, with: duration, completion: { [weak self] _ in
                    guard let strongDrawerController = self as? DrawerViewControllerProtocol else { return }
                    if ( velocity.y < 0 ) {
                        strongDrawerController.drawerTableView?.isScrollEnabled = true
                    }
                })
            }
            }
        }
    }
}
