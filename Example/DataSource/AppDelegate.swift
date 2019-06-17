//
//  AppDelegate.swift
//  DataSource
//
//  Created by Brad Smith on 02/02/2017.
//  Copyright (c) 2017 Brad Smith. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    private let window = UIWindow(frame: UIScreen.main.bounds)
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let _ = CoreDataController.sharedInstance
        
        let rootViewController = RootViewController(nibName: nil, bundle: nil)
        let rootNavigationController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        
        return true
    }
}

