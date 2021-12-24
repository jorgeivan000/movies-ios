//
//  SelectorFormTile.swift
//  MoviesApp
//
//  Created by jorgehc on 4/14/20.
//  Copyright © 2020 jorgehc.com. All rights reserved.
//

import Foundation

enum ServiceSelectorType: String {
    case categories
    case products
}

@IBDesignable public class SelectorFormTile: CustomFormTile {
    var topView : UIView?
    var selectorType: ServiceSelectorType = ServiceSelectorType.products
    var serviceName: String?
    var serviceType: ServiceType?
    var selectedServiceProduct: ServiceProduct?
    var currentViewController: UIViewController?
    
    func setupSelector(iconName: String) {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: iconName), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.isEnabled = false
        button.frame = CGRect(x: CGFloat(customFormTextField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        customFormTextField.rightView = button
        customFormTextField.rightViewMode = .always
        customFormTextField.delegate = self
        topView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-32, height: customFormTextField.height))
        if let currentTopView = topView {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSelectorField))
            currentTopView.addGestureRecognizer(tapGesture)
            customFormTextField.addSubview(currentTopView)
        }
        updateSelectorText()
    }
    
    func updateSelectorText() {
        customFormTextField.font = UIFont.custom(named: .circularStdBook).withSize(16)
        if selectedServiceProduct == nil {
            customFormTextField.text = .chooseServiceOption
            customFormTextField.textColor = .haiti50
        } else {
            customFormTextField.text = (selectedServiceProduct?.name ?? .empty) + " ($" +  (selectedServiceProduct?.price ?? .empty) + ")"
            customFormTextField.textColor = .haiti
        }
    }
    
    @objc func didTapSelectorField() {
        if selectorType == ServiceSelectorType.categories {
            let categorySelectorController = (Navigator.get(controller: .serviceCategorySelector, from: .serviceCategorySelector) as? ServiceCategorySelectorViewController)!
            categorySelectorController.parentPassedDelegate = self.delegate as? ServiceSelectorDelegate
            categorySelectorController.serviceName = serviceName
            categorySelectorController.selectorType = selectorType
            categorySelectorController.serviceType = serviceType
            currentViewController?.navigationController?.pushViewController(categorySelectorController, animated: true)
        } else {
            let productsSelectorController = (Navigator.get(controller: .serviceProductSelector, from: .serviceProductSelector) as? ServiceProductSelectorViewController)!
            productsSelectorController.customDelegate = self.delegate as? ServiceSelectorDelegate
            productsSelectorController.serviceName = serviceName
            productsSelectorController.selectorType = selectorType
            productsSelectorController.categoryIdentifier = serviceType?.rawValue
            currentViewController?.navigationController?.pushViewController(productsSelectorController, animated: true)
        }
    }
}
