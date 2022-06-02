//
//  TabBarViewController.swift
//  Navigation
//
//  Created by Shom on 02.06.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    private let feedViewController = MyFactory(navigationController: UINavigationController(), state: .feed)
    
    private let profileViewController = MyFactory(navigationController: UINavigationController(), state: .profile)

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = UIColor.systemGray5
        setControllers()
    }
    
    private func setControllers() {
        viewControllers = [
            feedViewController.navigationController,
            profileViewController.navigationController
        ]
    }

}
