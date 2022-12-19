//
//  AppDelegate.swift
//  NYCSchools
//
//  Created by Sara on 15/12/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?
    var navigationController : UINavigationController?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let schoolListController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NYCSchoolListViewController") as! NYCSchoolListViewController
        navigationController = UINavigationController(rootViewController: schoolListController)
        // Override point for customization after application launch.
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }


}

