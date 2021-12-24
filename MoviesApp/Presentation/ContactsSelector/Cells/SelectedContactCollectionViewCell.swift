//
//  SelectedContactCollectionViewCell.swift
//  MoviesApp
//
//  Created by jorgehc on 5/29/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import UIKit
import SDWebImage

class SelectedContactCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var closeButtonView: UIImageView!
    var contact: ContactStruct!
    
    func setup() {
        profilePicture.applyBorderAndCornerRadius(.white, borderWidth: 0.0)
        initialsLabel.applyBorderAndCornerRadius(#colorLiteral(red: 0.1026879176, green: 0.07519275695, blue: 0.270131737, alpha: 1), borderWidth: 1.0)
        closeButtonView.applyBorderAndCornerRadius(.white, borderWidth: 2)
    }
    
    func renderContact() {
        initialsLabel.text = contact.initials
        nameLabel.text = contact.name
        setProfilePictureIfAvailable(profilePictureURL: contact.profilePicture)
    }
    
    private func setProfilePictureIfAvailable(profilePictureURL: String?) {
        if let profilePictureURL = profilePictureURL {
            profilePicture.isHidden = false
            initialsLabel.isHidden = true
            initialsLabel.applyBorderAndCornerRadius(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), borderWidth: 1.0)
            let imageURL: URL? = URL(string: profilePictureURL)
            profilePicture.sd_setShowActivityIndicatorView(true)
            profilePicture.sd_setIndicatorStyle(.gray)
            profilePicture.sd_setImage(with: imageURL!, completed: { (image, error, cacheType, imageURL) in
                self.profilePicture.cutCircular()
            })
        } else {
            initialsLabel.isHidden = false
            profilePicture.isHidden = true
            initialsLabel.applyBorderAndCornerRadius(#colorLiteral(red: 0.1026879176, green: 0.07519275695, blue: 0.270131737, alpha: 1), borderWidth: 1.0)
        }
    }
}
