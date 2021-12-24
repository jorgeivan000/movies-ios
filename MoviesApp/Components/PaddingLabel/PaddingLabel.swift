//
//  PaddingLabel.swift
//  MoviesApp
//
//  Created by jorgehc on 08/08/18.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {
    
    var topInset: CGFloat = 5.0
    var bottomInset: CGFloat = 5.0
    var leftInset: CGFloat = 7.0
    var rightInset: CGFloat = 7.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let widthAwareOfInsets = size.width + leftInset + rightInset
        let heightAwareOfInsets = size.height + topInset + bottomInset
        
        return CGSize(width: widthAwareOfInsets, height: heightAwareOfInsets)
    }
    
    func set(insets: UIEdgeInsets) {
        topInset = insets.top
        bottomInset = insets.bottom
        leftInset = insets.left
        rightInset = insets.right
    }
    
}
