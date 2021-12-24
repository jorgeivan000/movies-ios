//
//  UINavigationController+Transition.swift
//  MoviesApp
//
//  Created by jorgehc on 1/2/18.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//

import UIKit

//MARK: - Animation Types
public enum TransitionAnimationType {
    case none
    case push
}

//MARK: - Extras
protocol ControllerWithExtras: class {
    var extras: [ExtraKeys : Any]? { set get }
}

public enum ExtraKeys {
    case searchQuery
    case currentTravel
}

//MARK: - Methods
public extension UINavigationController {
    
    /**
     Retrieves a controller instance from a storyboard adding the extras defined
     */
    private func getController(with extras:[ExtraKeys : Any]? = nil, transitionFor flow: Flows) -> UIViewController {
        let transition = flow.getTransition()
        let controller = Navigator.get(controller: transition!.controller, from: transition!.storyboard)!
        (controller as? ControllerWithExtras)?.extras = extras
        return controller
    }
    
    /**
     Executes a defined push/pop transition using the controller defined on a particular flow (Flows)
     */
    internal func execute<T: UIViewController>(
        transitionFor flow: Flows,
        castingTo type: T.Type,
        extras: [ExtraKeys : Any]? = nil,
        animation: TransitionAnimationType = .none) {
        
        let controller = getController(with: extras, transitionFor: flow)
        switch animation {
        case .push:
            push(viewController: controller)
            break
        default:
            pushViewController(controller as! T, animated: true)
            break
        }
    }        
    
    /**
     Pop current view controller to previous view controller.
     
     - Parameter type:     transition animation type.
     - Parameter duration: transition animation duration.
     */
    func pop(transitionType type: String = convertFromCATransitionType(CATransitionType.fade), duration: CFTimeInterval = 0.5) {
        self.addTransition(type, duration: duration)
        self.popViewController(animated: false)
    }
    
    /**
     Push a new view controller on the view controllers's stack.
     
     - Parameter controller: view controller to push.
     - Parameter type: transition animation type.
     - Parameter duration: transition animation duration.
     */
    func push(viewController controller: UIViewController, type: String = convertFromCATransitionType(CATransitionType.fade), duration: CFTimeInterval = 0.5) {
        self.addTransition( type, duration: duration)        
        self.pushViewController(controller, animated: false)
    }
    
    /**
     Adds a layer with the transition type defined
     */
    private func addTransition(_ type: String = convertFromCATransitionType(CATransitionType.fade), duration: CFTimeInterval = 0.5) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = convertToCATransitionType(type)
        self.view.layer.add(transition, forKey: nil)
    }    
}

//MARK: - BackNavigation
extension UINavigationController {
    func popToViewController(expectedClassForCoder: AnyClass) {
        if let viewController = viewControllers.filter({ $0.classForCoder == expectedClassForCoder }).first {
            popToViewController(viewController, animated: true)
        }
    }
    
    func popBackToViewController(positions: Int) {
        let viewControllers: [UIViewController] = self.viewControllers as [UIViewController]
        if positions <= viewControllers.count {
             self.popToViewController(viewControllers[viewControllers.count - positions - 1], animated: true)
        }
    }

    func getStackedViewController(expectedClassForCoder: AnyClass) -> UIViewController? {
        if let viewController = viewControllers.filter({ $0.classForCoder == expectedClassForCoder }).first {
            return viewController
        }
        return nil
    }
    
    func popToStackedViewController(stackedViewController: UIViewController) {
        popToViewController(stackedViewController, animated: true)
    }
}

// Helper function inserted by Swift 4.2 migrator.
public func convertFromCATransitionType(_ input: CATransitionType) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToCATransitionType(_ input: String) -> CATransitionType {
	return CATransitionType(rawValue: input)
}
