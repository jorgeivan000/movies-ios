//
//  NavigatorBridge.swift
//  MoviesApp
//
//  Created by jorgehc on 1/31/18.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//

import UIKit

typealias Transition = (controller: Controller, storyboard: Storyboard)

protocol TransitionAccessor {
    func getTransition() -> Transition?
}

public enum Flows: TransitionAccessor {
    
    case welcome
    case home

    func getTransition() -> Transition? {
        //Here you add the Transition combinations on your app
        switch self {
        case .welcome:
            return (.welcome, .welcome)
        case .home:
            return (.home, .home)
        }
        
    }
}

extension Navigator {
    func setMainFlow(to flow: Flows) {
        if let transition = flow.getTransition() {
            let controller = Navigator.get(
                controller: transition.controller,
                from: transition.storyboard,
                embedInNavigation: self.shouldEmbedInNavigation(for: flow)
            )            
            Navigator.set(root: controller)
        }
    }
    
    private func shouldEmbedInNavigation(for flow: Flows) -> Bool {
        let filterCases = Navigator.embedCases.filter({ current in
            return current == flow
        })
        return filterCases.count > 0
    }
}
