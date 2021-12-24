//
//  TabbedHomeViewController+Reachability.swift
//  MoviesApp
//
//  Created by jorgehc on 8/27/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation

extension TabbedHomeViewController {
    func setupReachabilityConection() {
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: .reachabilityChanged, object: reachability)
        NotificationCenter.default.addObserver(self, selector: #selector(presentNoInternetView), name: NSNotification.Name(rawValue: NotificationsID.networkIsUnreachable.rawValue), object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            debugPrint("Coudn't start notifier")
        }
    }
    
    @objc func internetChanged(notification: Notification) {
        let reachability = notification.object as! Reachability
        if reachability.connection == .cellular || reachability.connection == .wifi {
            DispatchQueue.main.async {
                self.postNetworkChangeNotification()
            }
        } else {
            DispatchQueue.main.async {
                self.presentNoInternetView()
            }
        }
    }
    
    @objc func presentNoInternetView () {
        let noInternetViewController = Navigator.get(controller: .noInternet, from: .noInternet) as! NoInternetViewController
        if !noInternetViewController.isVisible() {
            noInternetViewController.modalPresentationStyle = .overFullScreen
            navigationController?.pushViewController(noInternetViewController, animated: true)
        }
    }
    
    func postNetworkChangeNotification() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationsID.networkIsReachable.rawValue), object: nil)
    }
}
