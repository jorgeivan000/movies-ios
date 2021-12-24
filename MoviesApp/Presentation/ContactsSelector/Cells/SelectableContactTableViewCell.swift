//
//  ContactTableViewCell.swift
//  MoviesApp
//
//  Created by jorgehc on 5/29/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import UIKit

class SelectableContactTableViewCell: UITableViewCell {
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var adminLabel: UILabel!
    @IBOutlet weak var ensoContactBadge: UIImageView!
    
    var contact: ContactStruct!
    var member: MembershipStruct!
    var group: GroupStruct?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePicture.applyBorderAndCornerRadius(.white, borderWidth: 0.0)
        initialsLabel.applyBorderAndCornerRadius(#colorLiteral(red: 0.1026879176, green: 0.07519275695, blue: 0.270131737, alpha: 1), borderWidth: 1.0)
        self.isUserInteractionEnabled = true
    }
    
    func renderContact() {
        initialsLabel.text = contact.initials
        let contactNameInsensitive = contact.name.diacriticInsensitive()
        let contactName = contactNameInsensitive == .empty ? contact.phone : contact.name.capitalized
        nameLabel.text = contactName
        let contactPhone = contact.phone.toInternationalPhoneNumber()
        phoneLabel.text = contactPhone
        checkButton.isSelected = contact.isChecked
        setProfilePictureIfAvailable(profilePictureURL: contact.profilePicture)
        setEnsoContactStyle(forContactStatus: contact.status)
    }
    
    private func applyBorderAndCornerRadius(to view:UIView, withColor color: UIColor) {
        view.roundCorners()
        view.border(with: 1.0, borderColor: color.cgColor)
    }
    
    func renderMember() {
        nameLabel.text = member.localName
        initialsLabel.text = member.localName.initials()
        let contactPhone = member.phone?.toInternationalPhoneNumber()
        phoneLabel.text = contactPhone
        setProfilePictureIfAvailable(profilePictureURL: member.profilePictureURL)
        guard let group = group, let admin = group.getAdmin() else { return }
        adminLabel.isHidden =  !(member.contactId == admin.contactId)
        setEnsoContactStyle(forContactStatus: member.ensoContactStatus)
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
    
    private func setEnsoContactStyle(forContactStatus status: ContactStatus) {
        if status != ContactStatus.external {
            self.applyBorderAndCornerRadius(to: self.initialsLabel, withColor: .persimon)
            initialsLabel.textColor = .persimon
            ensoContactBadge.isHidden = false
        } else {
            self.applyBorderAndCornerRadius(to: self.initialsLabel, withColor: #colorLiteral(red: 0.1026879176, green: 0.07519275695, blue: 0.270131737, alpha: 1))
            initialsLabel.textColor = UIColor.haiti
            ensoContactBadge.isHidden = true
        }
    }
}
