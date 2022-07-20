//
//  AppDelegate.swift
//  LoggerDemo
//


import UIKit
import Logger

typealias AppLogger = Logger

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let viewController = ViewController()
        viewController.tabBarItem.title = "Default"
        
        let categorisedViewController = CategorisedLoggingViewController()
        categorisedViewController.tabBarItem.title = "Categorised"
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([viewController, categorisedViewController], animated: false)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

