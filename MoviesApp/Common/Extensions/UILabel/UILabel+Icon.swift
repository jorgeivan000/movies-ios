//
//  UILabel+Images.swift
//  MoviesApp
//
//  Created by jorgehc on 21/08/18.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//

import UIKit

extension UILabel {
    
    /**
     Add an icon image before or after the text of the label.

     - Parameter image: The image to be used as icon
     - Parameter trailingText: boolean value that indicates if the image should go before the text or after the text.
     */
    func add(image: UIImage, trailingText: Bool) {
        guard let currentText = self.text else { return }
        let attachment = NSTextAttachment()
        attachment.image = image
        let attachmentString = NSAttributedString(attachment: attachment)
        let textWithImage = NSMutableAttributedString(string: currentText)
        
        if trailingText {
            textWithImage.append(attachmentString)
            attributedText = textWithImage
        } else {
            let mutableAttachmentString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(textWithImage)
            attributedText = mutableAttachmentString
        }
    }
    
    /// Removes the image of Label text.
    func removeImage() {
        let text = self.text
        attributedText = nil
        self.text = text
    }
    
}
