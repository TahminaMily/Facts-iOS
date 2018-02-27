//
//  AppDelegate.swift
//  Facts
//
//  Created by Tahmina Khanam on 22/2/18.
//  Copyright © 2018 Cognizant. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let factListViewController = FactListViewController()
        let navigationController = UINavigationController(rootViewController: factListViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

}

