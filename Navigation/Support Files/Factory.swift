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
        case login
        case favorite
        case map
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
                title: NSLocalizedString("feed.title", comment: ""),
                image: UIImage(systemName: "list.bullet.circle"),
                selectedImage: UIImage(systemName: "list.bullet.circle.fill")
            )
            
        case .login:
            let coordinator = LoginCoordinator()
            let loginViewController = coordinator.showDetail(coordinator: coordinator)
            navigationController.setViewControllers([loginViewController], animated: true)
            navigationController.tabBarItem = UITabBarItem(
                title: NSLocalizedString("profile.title", comment: ""),
                image: UIImage(systemName: "person.circle"),
                selectedImage: UIImage(systemName: "person.circle.fill")
            )
        case .favorite:
            let coordinator = FavoriteCoordinator()
            let favoriteViewController = coordinator.showDetail(coordinator: coordinator)
            navigationController.setViewControllers([favoriteViewController], animated: true)
            navigationController.navigationBar.barTintColor = .white
            
            navigationController.tabBarItem = UITabBarItem(
                title: NSLocalizedString("favorite.title", comment: ""),
                image: UIImage(systemName: "heart.circle"),
                selectedImage: UIImage(systemName: "heart.circle.fill")
            )
        case .map:
            let coordinator = MapCoordinator()
            let mapViewController = coordinator.showDetail(coordinator: coordinator)
            navigationController.setViewControllers([mapViewController], animated: true)
            navigationController.tabBarItem = UITabBarItem(
                title: NSLocalizedString("map.title", comment: ""),
                image: UIImage(systemName: "map.circle"),
                selectedImage: UIImage(systemName: "map.circle.fill")
            )
        }
    }
    
}
