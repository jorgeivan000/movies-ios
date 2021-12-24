//
//  UIViewController+Ext.swift
//  MoviesApp
//
//  Created by jorgehc on 2/1/18.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//

import UIKit

//MARK: - Navigation Bar Stylist
extension UIViewController {
    func setNavigationTopItemTitleless() {
        navigationController?.navigationBar.topItem?.title = .empty
    }
    
    func setNavigationBarTransparent() {
        navigationController?.view.backgroundColor = .clear
    }
    
    func setNavigationBarSolid() {
        navigationController?.view.backgroundColor = .white
    }
    
    func setTopControllerTitle(newTitle: String = .appName) {
        navigationController?.topViewController?.navigationItem.title = newTitle
    }
    
    func setLargeTitle(prefersLargeTitles: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
    }
    
    func setBoldNavigationTitle(_ title: String) {
        let titleView = UILabel()
        titleView.font = UIFont.circularStdBold.withSize(20)
        titleView.text = title
        titleView.textColor = .haiti
        navigationItem.titleView = titleView
    }
        
    func makeNavigationBarTransparent() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.leftItemsSupplementBackButton = false
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem?.tintColor = .darkIndigo
    }
    
    func makeBackButtonTitleEmpty() {
        navigationController?.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    func makeNavigationBarSolid() {
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.leftItemsSupplementBackButton = true
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem?.tintColor = .darkIndigo
    }
    
    
    /**
     This removes the bottom border/shadow on the navigation bar
     */
    private func removeNavigationBarBorderShadow(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}
