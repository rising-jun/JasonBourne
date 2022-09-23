//
//  AppDelegate.swift
//  JasonBourne
//
//  Created by rising-jun on 09/23/2022.
//  Copyright (c) 2022 rising-jun. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let service = NewsService()
        service.fetchNews()
        service.fetchFakeNews()
        return true
    }
}

