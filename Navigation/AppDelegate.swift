//
//  AppDelegate.swift
//  Navigation
//
//  Created by Shom on 10.02.2022.
//

import UIKit
//import FirebaseAuth
//import FirebaseCore
import CoreData




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
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    //загрузка базы
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PostData")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Error \(nserror), \(nserror.userInfo)")

            }
        }
    }
}

