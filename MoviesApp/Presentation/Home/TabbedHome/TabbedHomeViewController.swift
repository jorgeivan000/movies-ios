//
//  TabbedHomeViewController.swift
//  MoviesApp
//
//  Created by Jorge Herrera on 5/7/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation
import RealmSwift

enum TabbedViews: Int {
    case latest = 0
    case popular = 1
    case upcoming = 2
}

class TabbedHomeViewController: UITabBarController {
    //MARK: - Variables
    var presenter: TabbedHomeViewPresenter!
    var balance: Double = 0.0
    let reachability = try!  Reachability()
    var hasDebitAccount = false
    var debitCardOnReplacement = false
    var defaultTabSelected: Int = TabbedViews.popular.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TabbedHomePresenter(view: self,  movieService: MoviesAPI())
        refreshTabbedConfiguration()
        setupReachabilityConection()
        setupTabbedBarTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshTabbedConfiguration()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self)
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == tabBar.items?[TabbedViews.latest.rawValue] {
            defaultTabSelected = TabbedViews.latest.rawValue
        } else if item == tabBar.items?[TabbedViews.popular.rawValue] {
            defaultTabSelected = TabbedViews.popular.rawValue
        } else if item == tabBar.items?[TabbedViews.upcoming.rawValue] {
            defaultTabSelected = TabbedViews.upcoming.rawValue
        }
        viewDidLayoutSubviews()
    }
    
    func setupTabbedBarTheme() {
        if #available(iOS 13, *) {
            let appearance = UITabBarAppearance()
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.coral]
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.haiti50]
            tabBar.standardAppearance = appearance
        } else {
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.coral], for: .selected)
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.haiti50], for: .normal)
        }
    }
    
    func refreshTabbedConfiguration() {
        guard let latestTabViewController = Navigator.get(controller: .latestMoviesTab, from: .latestMoviesTab) as? LatestMoviesViewController else { return }
        latestTabViewController.tabBarItem = UITabBarItem(title: TabTitles.latest.rawValue, image: UIImage(named: "movieGray")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "movieOrange")?.withRenderingMode(.alwaysOriginal))
        
        guard let popularTabViewController = Navigator.get(controller: .popularMoviesTab, from: .popularMoviesTab) as? PopularMoviesViewController else { return }
        popularTabViewController.tabBarItem = UITabBarItem(title: TabTitles.popular.rawValue, image: UIImage(named: "movieGray")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "movieOrange")?.withRenderingMode(.alwaysOriginal))
        
        guard let upcomingTabViewController = Navigator.get(controller: .upcomingMoviesTab, from: .upcomingMoviesTab) as? UpcomingMoviesViewController else { return }
        upcomingTabViewController.tabBarItem = UITabBarItem(title: TabTitles.upcoming.rawValue, image: UIImage(named: "movieGray")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "movieOrange")?.withRenderingMode(.alwaysOriginal))
        
        
        let tabBarList = [latestTabViewController, popularTabViewController, upcomingTabViewController]
        viewControllers = tabBarList
        selectedIndex = defaultTabSelected
    }
    
    func getCurrentCardViewController() -> UIViewController {
        var controller: UIViewController?
        return controller!
    }

    func sendToHome() {
        Navigator().setMainFlow(to: .home)
    }

    private func customizedTabBarLayout() {
        tabBar.items?[TabbedViews.latest.rawValue].image = UIImage(named: "movieGray")?.withRenderingMode(.alwaysOriginal)
        tabBar.items?[TabbedViews.popular.rawValue].selectedImage = UIImage(named: "movieOrange")?.withRenderingMode(.alwaysOriginal)
        tabBar.items?[TabbedViews.upcoming.rawValue].image = UIImage(named: "movieGray")?.withRenderingMode(.alwaysOriginal)
        selectedIndex = TabbedViews.popular.rawValue
    }
}

//MARK: - TabbedHomeView
extension TabbedHomeViewController: TabbedHomeView {}
