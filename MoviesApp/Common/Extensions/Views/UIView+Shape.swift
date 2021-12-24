//
//  UIView+Ext.swift
//

import UIKit

//MARK: - Shapes
public extension UIView {
    func cutRounded(){
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }
    
    func cutCircular(){
        self.layer.cornerRadius = self.frame.size.width / 2;
        self.clipsToBounds = true;
    }
    
    /**
     Round all the corners of the view to the given radius.
     - Parameter radius: The corner radius of the view, if nil the applied radius is height/2. The default value is nil.
     */
    func roundCorners(with radius: CGFloat? = nil) {
        let radius = radius ?? frame.size.height/2.0
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    /**
     Apply border to all corners with provided  color.
     */
    func border(with width: CGFloat, borderColor: CGColor) {
        layer.borderWidth = width
        layer.borderColor = borderColor
    }
    
    /**
     Round the given view with a circular mask and a border.
     - Parameter color: The color of the border to be added. Default value is .white
     - Parameter radius: The corner radius of the view, if nil the applied radius is height/2. The default value is nil.
     - Parameter width: The border width. Default value is 1.5.
     */
    func roundWithBorder(of color: UIColor = .white, radius: CGFloat? = nil, and width: CGFloat = 1.5) {
        layer.cornerRadius = radius ?? frame.size.height / 2.0
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.masksToBounds = true
    }
    
    /**
     Round the given corners of a view to the given radius.
     - Parameter corners: The corners to be rounded
     - Parameter radius: The corner radius of the view.
     */
    func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    var fullCircle: Bool {
        get{
            return layer.cornerRadius == 0 ? false:true
        }
        set {
            if newValue {
                layer.cornerRadius = bounds.size.width/2
            } else {
                layer.cornerRadius = 0
            }
        }
    }
    
    func addDropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

//MARK: - Border
public enum StrokeType: CGFloat {
    case medium = 3.5
    case thin = 1.5
}

public extension UIView {
    func addBorder(_ borderColor: CGColor, strokeWidth: StrokeType = .medium) {
        self.layer.borderColor = borderColor
        self.layer.borderWidth = strokeWidth.rawValue
    }
    
    //MARK: - Custom
    
    func addWhiteBorder(){
        self.addBorder(UIColor.white.cgColor)
    }
}

//MARK: - Frame

extension UIView {
    /// Exposes the x property of the frame
    var x: CGFloat {
        get { return frame.origin.x }
        set { frame.origin.x = newValue }
    }
    
    /// Exposes the y property of the frame
    var y: CGFloat {
        get { return frame.origin.y }
        set { frame.origin.y = newValue }
    }
    
    
    /// Exposes the width property of the frame
    var width: CGFloat {
        get { return frame.size.width }
        set { frame.size.width = newValue }
    }
    
    /// Exposes the width property of the frame
    var height: CGFloat {
        get { return frame.size.height }
        set { frame.size.height = newValue }
    }
}
