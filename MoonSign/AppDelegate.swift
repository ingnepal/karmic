//
//  AppDelegate.swift
//  MoonSign
//
//  Created by Mac on 9/6/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import UIKit
import KYDrawerController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var drawerController = KYDrawerController.init(drawerDirection: .left, drawerWidth: UIScreen.main.bounds.width/1.5)
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().barTintColor = ColorConstants.primaryColor
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        if SaveData.isLoggedIn(){
            openDashboard()
        }
        else{
            let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController")
            self.window?.makeKeyAndVisible()
        }
        return true
    }
    
    func openDashboard(){
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        let drawerVC = storyboard.instantiateViewController(withIdentifier: "NavigationDrawerViewController")
        
        self.drawerController.mainViewController = UINavigationController(rootViewController: mainVC)
        self.drawerController.drawerViewController = drawerVC
        
        self.window?.rootViewController = self.drawerController
        self.window?.makeKeyAndVisible()
    }
    
    class func globalDelegate() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

