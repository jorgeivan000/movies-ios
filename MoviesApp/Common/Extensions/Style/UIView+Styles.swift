//
//  UIView+Styles.swift
//  MoviesApp
//
//  Created by jorgehc on 12/5/17.
//  Copyright © 2017 jorgehc.com. All rights reserved.
//

import UIKit

enum Style {
    // HERE: Define all your Styles
    case gunMetalTextButton
    case titleHeaderLabel
    case messageLabel(textColor: UIColor, textAlignment: NSTextAlignment)
    case contactsSectionHeader
    case contactsSelectorSectionHeader
    case noInternetBanner
    case primaryActionButton
    case neutralActionButton
    case darkNeutralActionButton
    case simpleNeutralActionButton
    case headerLevelButton
    case positiveBalanceLabel
    case negativeBalanceLabel
    case newUserLabel
    case cardDetailLabel
}

extension UIView {
    func setStyle(_ style: Style) {
        switch style {
        case .gunMetalTextButton:
            if let button = self as? UIButton {
                button.tintColor = .darkIndigo
                button.setTitleColor(.darkIndigo, for: .normal)
                button.titleLabel?.font = UIFont.custom(named: .circularStdMedium).withSize(14)
                button.backgroundColor = .white
                button.roundWithBorder(of: .darkIndigo, radius: 20)
            }
        case .titleHeaderLabel:
            if let label = self as? UILabel {
                label.font = UIFont.custom(named: .circularStdBold).withSize(35)
                label.adjustsFontSizeToFitWidth = true
                label.minimumScaleFactor = 0.5
                label.textColor = .haiti
                label.textAlignment = .left
                if let paddingLabel = label as? PaddingLabel {
                    paddingLabel.leftInset = 17
                    paddingLabel.setNeedsLayout()
                    paddingLabel.layoutIfNeeded()
                }
            }
        case .messageLabel(let textColor, let textAlignment):
            if let label = self as? UILabel {
                label.font = UIFont.custom(named: .circularStdMedium).withSize(12)
                label.textColor = textColor
                label.textAlignment = textAlignment
                if let paddingLabel = label as? PaddingLabel {
                    paddingLabel.leftInset = 17
                    paddingLabel.setNeedsLayout()
                    paddingLabel.layoutIfNeeded()
                }
            }
        case .contactsSectionHeader:
            if let label = self as? UILabel {
                label.font = UIFont.custom(named: .circularStdBook).withSize(16)
                label.textColor = .gunmetal
                label.textAlignment = .left
                if let paddingLabel = label as? PaddingLabel {
                    paddingLabel.leftInset = 20
                    paddingLabel.setNeedsLayout()
                    paddingLabel.layoutIfNeeded()
                }
            }
        case .contactsSelectorSectionHeader:
            if let label = self as? UILabel {
                label.font = UIFont.custom(named: .circularStdBook).withSize(16)
                label.textColor = .haiti50
                label.textAlignment = .left
                if let paddingLabel = label as? PaddingLabel {
                    paddingLabel.leftInset = 20
                    paddingLabel.setNeedsLayout()
                    paddingLabel.layoutIfNeeded()
                }
            }
        case .noInternetBanner:
            if let label = self as? UILabel {
                label.font = UIFont.custom(named: .circularStdMedium).withSize(12)
                label.textColor = .white
                label.textAlignment = .center
            }
        case .primaryActionButton:
            if let button = self as? UIButton {
                button.backgroundColor = .persimon
                button.setTitleColor(.white, for: .normal)
                button.tintColor = .white
                button.borderColor = .persimon
                button.layer.borderWidth = 1
            }
        case .neutralActionButton:
            if let button = self as? UIButton {
                button.backgroundColor = UIColor.clear
                button.tintColor = .persimon
                button.borderColor = .persimon
                button.layer.borderWidth = 1
            }
        case .darkNeutralActionButton:
            if let button = self as? UIButton {
                button.backgroundColor = UIColor.clear
                button.setTitleColor(.darkIndigo, for: .normal)
                button.tintColor = .darkIndigo
                button.borderColor = .darkIndigo
                button.layer.borderWidth = 1
            }
        case .simpleNeutralActionButton:
            if let button = self as? UIButton {
                button.backgroundColor = UIColor.clear
                button.setTitleColor(.haitiGray, for: .normal)
                button.tintColor = .haitiGray
                button.borderColor = UIColor.clear
                button.layer.borderWidth = 1
            }
        case .headerLevelButton:
            if let button = self as? UIButton {
                button.tintColor = .white
                button.titleLabel?.font = UIFont.custom(named: .circularStdBold).withSize(13)
                button.backgroundColor = .coral
                button.roundWithBorder(of: .coral, radius: 10)
            }
        case .positiveBalanceLabel:
            if let label = self as? UILabel {
                label.backgroundColor = .seaweed
            }
        case .negativeBalanceLabel:
            if let label = self as? UILabel {
                label.backgroundColor = .coral
            }
        case .newUserLabel:
            if let label = self as? UILabel {
                label.backgroundColor = .cornflowerBlue
            }
        case .cardDetailLabel:
            if let button = self as? UIButton, let buttonTitle = button.currentAttributedTitle {
                let cardDigitsCount = 7
                let trimmedStringIndex: Int = (buttonTitle.string.count) - cardDigitsCount
                let attributedString: NSMutableAttributedString = buttonTitle as! NSMutableAttributedString
                attributedString.addAttribute(
                    .font,
                    value: UIFont.custom(named: .circularStdMedium).withSize(14.0),
                    range: NSRange(location: trimmedStringIndex, length: cardDigitsCount))
                button.setAttributedTitle(attributedString, for: .normal)
            }
        }
    }
}
