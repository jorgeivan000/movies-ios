//
//  JonContextMenuView.swift
//  JonContextMenu
//
//  Created by Jonathan Martins on 10/09/2018.
//  Copyright © 2018 Surrey. All rights reserved.
//
import UIKit
import Foundation
import UIKit.UIGestureRecognizerSubclass

@objc public protocol ContextMenuDelegate{
    func menuOpened()
    func menuClosed()
    func menuItemWasSelected(item: ContextMenuItem)
    func menuItemWasActivated(item: ContextMenuItem)
    func menuItemWasDeactivated(item: ContextMenuItem)
}

@objc open class ContextMenu:NSObject{
    
    /// The items to be displayed
    var items: [ContextMenuItem] = []
    
    /// The delegate to notify the JonContextMenu host when an item is selected
    var delegate: ContextMenuDelegate?
    
    /// The Background's alpha of the view
    var backgroundAlpha:CGFloat = 0.9
    
    /// The Background's colour of the view
    var backgroundColor:UIColor = .whiteTree
    
    /// The items' buttons default colour
    var buttonsDefaultColor:UIColor = .persimon
    
    /// The items' buttons active colour
    var buttonsActiveColor:UIColor = .persimon
    
    /// The items' icons default colour
    var iconsDefaultColor:UIColor = .white
    
    /// The items' icons active colour
    var iconsActiveColor:UIColor? = .white
    
    /// The size of the title of the menu items
    var itemsTitleSize:CGFloat = 35
    
    /// The colour of the title of the menu items
    var itemsTitleColor:UIColor = .haiti

    /// The view selected by the user
    var highlightedView:UIView!
    
    override public init(){
        super.init()
    }

    /// Sets the items for the JonContextMenu
    @objc open func setItems(_ items: [ContextMenuItem])-> ContextMenu {
        self.items = items
        for item in items {
            item.menu = self
        }
        return self
    }
    
    /// Sets the delegate for the JonContextMenu
    @objc open func setDelegate(_ delegate: ContextMenuDelegate?)-> ContextMenu {
        self.delegate = delegate
        return self
    }
    
    /// Sets the background of the JonContextMenu
    @objc open func setBackgroundColorTo(_ backgroundColor: UIColor, withAlpha alpha:CGFloat = 0.9)-> ContextMenu {
        self.backgroundAlpha = alpha
        self.backgroundColor = backgroundColor
        return self
    }
    
    /// Sets the colour of the buttons for when there is no interaction
    @objc open func setItemsDefaultColorTo(_ colour: UIColor)-> ContextMenu {
        self.buttonsDefaultColor = colour
        return self
    }
    
    /// Sets the colour of the buttons for when there is interaction
    @objc open func setItemsActiveColorTo(_ colour: UIColor)-> ContextMenu {
        self.buttonsActiveColor = colour
        return self
    }
    
    /// Sets the colour of the icons for when there is no interaction
    @objc open func setIconsDefaultColorTo(_ colour: UIColor?)-> ContextMenu {
        self.iconsDefaultColor = colour ?? iconsDefaultColor
        return self
    }
    
    /// Sets the colour of the icons for when there is interaction
    @objc open func setIconsActiveColorTo(_ colour: UIColor?)-> ContextMenu {
        self.iconsActiveColor = colour ?? iconsActiveColor
        return self
    }
    
    /// Sets the colour of the JonContextMenu items title
    @objc open func setItemsTitleColorTo(_ color: UIColor)-> ContextMenu {
        self.itemsTitleColor = color
        return self
    }
    
    /// Sets the size of the JonContextMenu items title
    @objc open func setItemsTitleSizeTo(_ size: CGFloat)-> ContextMenu {
        self.itemsTitleSize = size
        return self
    }
    
    /// Builds the JonContextMenu
    @objc open func build()-> Builder {
        return Builder(self)
    }
    
    @objc open class Builder: UITapGestureRecognizer {
        
        /// The wrapper for the JonContextMenu
        var window: UIWindow!
        
        var highlightedCopyView : UIView!
        
        /// The selected menu item
        private var currentItem: ContextMenuItem?
        
        /// The JonContextMenu view
        var contextMenuView: ContextMenuView!
        
        /// The properties configuration to add to the JonContextMenu view
        var properties: ContextMenu!
        
        /// Indicates if there is a menu item active
        private var isItemActive = false
        
        @objc init(_ properties: ContextMenu) {
            super.init(target: nil, action: nil)
            guard let window = UIApplication.shared.keyWindow else {
                fatalError("No access to UIApplication Window")
            }
            self.window = window
            self.properties = properties
            addTarget(self, action: #selector(setupTouchAction))
        }
        
        /// Set up opened main button view state to add to the Window
        private func setOpenedButtonViewState() {
            let highlightedView   = UIImageView.init(image: UIImage(named: "superbutton"))
            highlightedView.addDropShadow()
            var viewFrame = self.view!.frame
            viewFrame.origin.y = viewFrame.origin.y + 10
            
            highlightedView.frame = self.view!.superview!.convert(viewFrame, to: nil)

            highlightedCopyView = highlightedView
            properties.highlightedView = highlightedView
        }

        /// Handle the touch events on the view
        @objc private func setupTouchAction() {
            let location = self.location(in: window)
            setOpenedButtonViewState()
            UISelectionFeedbackGenerator().selectionChanged()
            showMenu(on: location)
        }
        
        /// Creates the JonContextMenu view and adds to the Window always centered
        private func showMenu(on location:CGPoint) {
            properties.delegate?.menuOpened()
            currentItem = nil
            contextMenuView = ContextMenuView(properties, touchPoint: properties.highlightedView.center)
            contextMenuView.tag = ContextMenuView.viewIdentifier
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                UIView.transition(with: self.window, duration: 0.25, options: [.transitionCrossDissolve], animations: {
                    self.window.addSubview(self.contextMenuView)
                }, completion: nil)
            }
        }
    }
}
