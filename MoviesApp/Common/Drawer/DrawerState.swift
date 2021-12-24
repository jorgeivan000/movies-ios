//
//  DrawerState.swift
//  MoviesApp
//
//  Created by jorgehc on 06/08/18.
//  Copyright © 2018 Pablo Marrufo. All rights reserved.
//

import UIKit

/// Options for representing the current drawer state: open or collapsed.
enum DrawerState {
    case collapsed
    case open
    
    /// Returns the multipler for adjusting the total height of the drawer depending on its DraggablePosition state.
    internal var heightMultiplier: CGFloat {
        switch self {
        case .collapsed: return 0.15
        case .open: return 0.83
        }
    }
    
    /// Y Boundary for opening or closing the drawer. The default is 20% less than the current state height.
    internal var yBoundary: CGFloat {
        let incrementDecrement = CGFloat(0.2)
        switch self {
        case .collapsed: return (1 - (heightMultiplier + incrementDecrement)) * ScreenSize.height
        case .open: return (1 - (heightMultiplier - incrementDecrement)) * ScreenSize.height
        }
    }
    
    /// The Y value of the current state
    var y: CGFloat { return ScreenSize.height * (1 - heightMultiplier) }
    
    /// Height of the drawer of the current state
    var height: CGFloat { return ScreenSize.height * heightMultiplier }
    
    /// Returns the next state of the drawer for the position the user dragged the drawer.
    func nextState(for currentY: CGFloat) -> DrawerState {
        
        // If currentY is above yBoundary when the drawer is closed,
        // user initiated the opening of the drawer
        if currentY < yBoundary && self == .collapsed {
            return .open
        }
        
        // If currentY is below yBoundary when the drawer is open,
        // user initiated the closing of the drawer
        if currentY > yBoundary && self == .open {
            return .collapsed
        }
        
        // The user didn't initiated a change of state for the drawer
        return self
    }
}
