//
//  AppDelegate.swift
//  Navigation
//
//  Created by Shom on 10.02.2022.
//

import UIKit
//import FirebaseAuth
//import FirebaseCore




@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Фабрика
        let myInspector = Factory.shared.myFactory()
        //FirebaseApp.configure()

        //NetworkService enum
        //let appConfiguration = AppConfiguration.allCases.randomElement()
        
        //let manager = MyManager()
        
        
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let logInViewController = LogInViewController()
        let logInNavigationController = UINavigationController(rootViewController: logInViewController)
        logInNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), selectedImage: nil)
        
        
        let mainCoordinator = RootCoordinator()
        window?.rootViewController = mainCoordinator.startApplication()
        window?.makeKeyAndVisible()
        logInViewController.delegate = myInspector
        
        //NetworkService method
        //NetworkService.startNetwork(url: appConfiguration?.rawValue ?? "Ошибка кейсов")
        
        //manager.fetchData()
        //manager.myView()
        
        
        return true
        
    }
}

