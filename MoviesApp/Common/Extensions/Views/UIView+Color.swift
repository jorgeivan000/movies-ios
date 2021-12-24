//
//  UIView+Color.swift
//  MoviesApp
//
//  Created by jorgehc on 08/08/18.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//

import UIKit

extension UIView {
    
    /**
     Applies a gradient to the given view. There can be two or more colors. The coordinate system of the gradient is as the following figure illustrates.
     
                            (0,0)____(1,0)
                                |    |
                                |    |
                            (1,0)----(1,1)
     
     - Parameter colors: Array containing all the colors the gradient will have. Default: two tones of grey
     - Parameter locations: Array containing the percentage of view the color will have. Default: nil.
     - Parameter startPoint: CGPoint of the start point of the gradient. The minimun value is (x = 0, y = 0) whereas the maximun value (x = 1, y = 1) and the default value (x = 0, y = 0)
     - Parameter endPoint: CGPoint of the end point of the gradient. The minimun value is (x = 0, y = 0) whereas the maximun value (x = 1, y = 1) and the default value (x = 1, y = 1)
    */
    func applyGradient(colors: [UIColor] = [#colorLiteral(red: 0.3568627451, green: 0.3568627451, blue: 0.3568627451, alpha: 1),#colorLiteral(red: 0.5647058824, green: 0.5647058824, blue: 0.5647058824, alpha: 1)], locations: [NSNumber]? = nil,startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint : CGPoint = CGPoint(x: 1, y: 1)) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        layer.insertSublayer(gradient, at: 0)
    }

    /**
     Applies a shadow to the given UIView instance.
     - Parameter width: The shadow offset width. Default value is 1.
     - Parameter height: The shadow offset height. Default value is 1.
     - Parameter radius: The shadow radius. Default value is 6.
     - Parameter color: The color of the shadow. Default value is .lightGray
     */
    func applyShadow(width: Int = 1, height: Int = 1, radius: CGFloat = 6.0, and color: UIColor = .lightGray) {
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = 1
        layer.masksToBounds = false
        layer.shouldRasterize = false
    }

}
