//
//  AppDelegate.swift
//  Navigation
//
//  Created by Shom on 10.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = UITabBarController()
        self.window?.rootViewController = tabBarController
        
        let navigationControllerNewsline = UINavigationController()
        navigationControllerNewsline.tabBarItem = UITabBarItem(title: "Newsline", image: UIImage(named: "news"), selectedImage: nil)
        let navigationControllerProfile = UINavigationController()
        navigationControllerProfile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), selectedImage: nil)

        
        tabBarController.viewControllers = [navigationControllerNewsline, navigationControllerProfile]
        
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        
        navigationControllerNewsline.setViewControllers([viewController], animated: true)
        
        self.window?.makeKeyAndVisible()
        return true
    }

}

