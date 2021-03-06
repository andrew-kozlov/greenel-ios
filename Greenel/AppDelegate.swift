//
//  AppDelegate.swift
//  Greenel
//
//  Created by Andrew Kozlov on 10/11/2018.
//  Copyright © 2018 Andrew Kozlov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Service.shared.fetch()
        
        window?.tintColor = UIColor(red: CGFloat(17.0 / 255.0), green: CGFloat(147.0 / 255.0), blue: CGFloat(0.0 / 255.0), alpha: 1.0)
        
        return true
    }
    
}
