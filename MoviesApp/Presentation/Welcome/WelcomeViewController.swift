//
//  WelcomeViewController.swift
//  MoviesApp
//
//  Created by jorgehc.
//  Copyright © 2021 jorgehc.com. All rights reserved.
//

import UIKit

class WelcomeViewController: BaseViewController {
    //MARK: - Outlets
    @IBOutlet weak var loginButton: UIButton!
    //MARK: - Variables
    var currentViewControllerIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func didTapRetry(_ sender: Any) {
        guard let homeViewController = Navigator.get(controller: .home, from: .home) as? TabbedHomeViewController else { return }
            self.navigationController?.pushViewController(homeViewController, animated: true)
    }
}
//MARK: - View
extension WelcomeViewController: WelcomeView {}
