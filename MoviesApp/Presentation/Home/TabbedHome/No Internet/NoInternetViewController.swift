//
//  NoInternetViewController.swift
//  MoviesApp
//
//  Created by jorgehc on 8/14/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import UIKit

class NoInternetViewController: BaseViewController {
    @IBOutlet weak var topViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var retryButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: NSNotification.Name(rawValue: NotificationsID.networkIsReachable.rawValue), object: nil)
        
        if (DeviceType.IS_IPHONE_5) {
            topViewConstraint.constant = topViewConstraint.constant - 50
        }
    }
    
    @objc func internetChanged(notification: Notification) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapRetry(_ sender: Any) {
        navigationController?.popBackToViewController(positions: 2)
    }
}

