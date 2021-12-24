//
//  JonContextMenu.swift
//  JonContextMenu
//
//  Created by Jonathan Martins on 10/09/2018.
//  Copyright © 2018 Surrey. All rights reserved.
//
import UIKit
import Foundation

class ContextMenuView:UIView {
    /// View identifier used as tag reference
    static let viewIdentifier = 111
    
    /// Enum to map the direction of the touch
    enum Direction {
        case left
        case right
        case middle
        case up
        case down
    }
    
    /// The background of the view
    let background: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// The view that represents the users's touch point
    var touchPointView:UIView!
    
    /// The properties configuration for the JonContextMenuView
    private var properties:ContextMenu!
    
    /// The distance between the touch point and the menu items
    private let distanceToTouchPoint:CGFloat = 50
    
    /// The coordinates the the user touched on the screen
    private var touchPoint:CGPoint!
    
    /// The X distance from the menu items to the touched point
    private var xDistanceToItem:CGFloat!
    
    /// The Y distance from the menu items to the touched point
    private var yDistanceToItem:CGFloat!
    
    /// The direction that the items are supposed to appear
    private var currentDirection: (Direction, Direction)!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(_ properties: ContextMenu, touchPoint: CGPoint) {
        super.init(frame: UIScreen.main.bounds)
        self.accessibilityViewIsModal = true
        self.properties = properties
        self.touchPoint = touchPoint
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(didTapCloseButton)
        )
        touchPointView = makeTouchPoint()
        touchPointView.addGestureRecognizer(tap)
        touchPointView.isAccessibilityElement = true
        touchPointView.accessibilityTraits = .button
        currentDirection = calculateDirections(properties.items[0].wrapper.frame.width)
        addSubviews()
        configureViews()
        displayView()
    }
    
    /// On tap, remove contex menu view
    @objc func didTapCloseButton() {
        guard let window = UIApplication.shared.keyWindow else {
            fatalError("No access to UIApplication Window")
        }
        UIView.transition(with: self.window!, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            let viewToRemove = window.viewWithTag(ContextMenuView.viewIdentifier)
            viewToRemove!.removeFromSuperview()
        }, completion: nil)
        properties.delegate?.menuClosed()
    }
    
    /// Add the background and touch point
    private func addSubviews() {
        self.addSubview(background)
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.topAnchor),
            background.bottomAnchor  .constraint(equalTo: self.bottomAnchor),
            background.leadingAnchor .constraint(equalTo: self.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        
        self.addSubview(properties.highlightedView)
        self.addSubview(touchPointView)
    }
    
    /// Configure the views to start with the properties set in the JonContextMenu class
    private func configureViews() {
        
        /// Sets the default colour of the items
        properties.items.forEach({
            $0.setItemColorTo(properties.buttonsDefaultColor, iconColor: properties.iconsDefaultColor)
        })

        /// Sets the view's background alpha
        background.alpha = properties.backgroundAlpha
        
        /// Sets the views's background colour
        background.backgroundColor = properties.backgroundColor
    }
    
    /// Shows the ContextMenu
    private func displayView() {
        calculateDistanceToItem()
        resetItemsPosition()
        anglesForDirection()
        
        for item in properties.items {
            self.addSubview(item)
            animateItem(item)
        }
    }
    
    /// Creates the touch point view
    private func makeTouchPoint()-> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 72, height: 72))
        view.center = touchPoint
        return view
    }
    
    /// Sets the menu items' position to the user's touch position
    private func resetItemsPosition() {
        properties.items.forEach({
            $0.center = touchPoint
        })
    }
    
    /// Calculates the distance from the user's touch location to the menu items
    private func calculateDistanceToItem() {
        xDistanceToItem = touchPointView.frame.width/2  + distanceToTouchPoint + CGFloat(properties.items[0].frame.width/2)
        yDistanceToItem = touchPointView.frame.height/2 + distanceToTouchPoint + CGFloat(properties.items[0].frame.height/2)
    }
    
    /// Calculates which direction the menu items shoud appear
    private func calculateDirections(_ menuItemWidth: CGFloat) -> (Direction, Direction) {
        return(.up, .middle)
    }
    
    /// Calculates which angle the menu items should appear
    private func anglesForDirection() {
        positiveQuorterAngle(startAngle: 215)
    }
    
    /// Calculates the clockwise angle that each of the menu items should appear based on the given start angle
    private func positiveQuorterAngle(startAngle: CGFloat) {
        properties.items.forEach({ item in
            let index = CGFloat(properties.items.firstIndex(of: item)!)
            item.angle = (startAngle + 55 * index)
        })
    }
    
    /// Caculates the final position of the mennu items
    private func calculatePointCoordiantes(_ angle: CGFloat) -> CGPoint {
        let x = (touchPoint.x + CGFloat(__cospi(Double(angle/180))) * xDistanceToItem)
        let y = (touchPoint.y + CGFloat(__sinpi(Double(angle/180))) * yDistanceToItem)
        return CGPoint(x: x, y: y)
    }
    
    /// Animates the menu items to appear at the calculated positions
    private func animateItem(_ item: ContextMenuItem) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: [], animations: {
            item.center = self.calculatePointCoordiantes(item.angle)
        }, completion: nil)
    }
    
    /// Activates the selected menu item
    func activate(_ item: ContextMenuItem) {
        item.isActive = true
        item.setItemColorTo(properties.buttonsActiveColor, iconColor: properties.iconsActiveColor)
        
        let newX = (item.wrapper.center.x + CGFloat(__cospi(Double(item.angle/180))) * 25)
        let newY = (item.wrapper.center.y + CGFloat(__sinpi(Double(item.angle/180))) * 25)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: [], animations: {
            item.wrapper.center    = CGPoint(x: newX, y: newY)
            item.wrapper.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: nil)
    }
    
    /// Deactivate the  item
    func deactivate(_ item: ContextMenuItem) {
        
        item.isActive = false
        item.setItemColorTo(properties.buttonsDefaultColor, iconColor: properties.iconsDefaultColor)
        
        let newX = (item.wrapper.center.x + CGFloat(__cospi(Double(item.angle/180))) * -25)
        let newY = (item.wrapper.center.y + CGFloat(__sinpi(Double(item.angle/180))) * -25)
        
        UIView.animate(withDuration: 0.2, animations: {
            item.wrapper.center    = CGPoint(x: newX, y: newY)
            item.wrapper.transform = CGAffineTransform.identity
        })
    }
}
