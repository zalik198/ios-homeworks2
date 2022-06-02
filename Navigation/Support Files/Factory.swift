//
//  Factory.swift
//  Navigation
//
//  Created by Shom on 28.04.2022.
//

import Foundation
import UIKit

protocol LoginFactory {
    func myFactory() -> LoginInspector
}

class Factory: LoginFactory {    
    static let shared = Factory()
    
    func myFactory() -> LoginInspector {
        let inspector = LoginInspector()
        return inspector
    }
    
}

final class MyFactory {
    
    enum State {
        case feed
        case profile
    }
    
    let navigationController: UINavigationController
    let state: State
    
    
    init(
        navigationController: UINavigationController,
        state: State
    ) {
        self.navigationController = navigationController
        self.state = state
        startModule()
    }
    
    func startModule() {
        switch state {
        case .feed:
            let coordinator = FeedCoordinator()
            let feedViewController = coordinator.showDetail(coordinator: coordinator)
            navigationController.setViewControllers([feedViewController], animated: true)
            navigationController.navigationBar.barTintColor = .white
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
            navigationController.tabBarItem = UITabBarItem(
                title: "Newsline",
                image: UIImage(systemName: "list.bullet.circle"),
                selectedImage: UIImage(systemName: "list.bullet.circle.fill")
            )
            
        case .profile:
            let coordinator = ProfileCoordinator()
            let profileViewController = coordinator.showDetail(coordinator: coordinator)
            navigationController.setViewControllers([profileViewController], animated: true)
            navigationController.navigationBar.barTintColor = .white
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
            navigationController.tabBarItem = UITabBarItem(
                title: "Profile",
                image: UIImage(systemName: "person.circle"),
                selectedImage: UIImage(systemName:"person.circle.fill")
            )
        }
    }
    
}
