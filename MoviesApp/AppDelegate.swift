//
//  AppDelegate.swift
//  MoviesApp
//
//  Created by jorgehc on 7/19/18.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//

import UIKit
import UserNotifications
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Setting tint color to persimon
        if let windowInstance = self.window {
            windowInstance.tintColor = UIColor.persimon
        }

        //Define Name View as embed in navigation

        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        UINavigationBar.appearance().tintColor = UIColor.darkIndigo
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().shadowImage = UIImage()
        let attributes: [NSAttributedString.Key: AnyObject] = [
            NSAttributedString.Key.font: UIFont.circularStdMedium,
            NSAttributedString.Key.foregroundColor: UIColor.darkIndigo
        ]

        UINavigationBar.appearance().titleTextAttributes = attributes

        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
        UIImageView.appearance(whenContainedInInstancesOf: [UITableView.self]).tintColor = UIColor.warmGrey
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000.0, vertical: 0.0), for: .default)
        let pageControl = UIPageControl.appearance()
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        return true
    }

    func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
        return extensionPointIdentifier == .keyboard ?  false : true
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        return true
    }
}

extension AppDelegate {
    func sendToViewController<T: UIViewController> (_ controller: Controller, from storyboardName: Storyboard, viewController: T.Type, presentMode: Bool = false) {
        guard let lockController = Navigator.get(controller: controller, from: storyboardName) as? T else { return }
        if let childControllers = self.window?.rootViewController?.children {
            if !childControllers.contains(where: {
                return $0 is T
            }){
                childControllers.last?.navigationController?.push(viewController: lockController)
                /*if presentMode {
                    //lockController.modalPresentationStyle = .overFullScreen
                    childControllers.last?.navigationController?.push(lockController, animated: true, completion: nil)
                } else {
                    childControllers.last?.navigationController?.push(viewController: lockController)
                }*/
            }
        }
    }

    func checkForNetworkStatus () {
        let reachability = try! Reachability()
        reachability.whenReachable = {_ in
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationsID.networkIsReachable.rawValue), object: nil)
            }
        }
        reachability.whenUnreachable = {_ in
            DispatchQueue.main.async {
              NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationsID.networkIsUnreachable.rawValue), object: nil)
            }
        }
    }
}
