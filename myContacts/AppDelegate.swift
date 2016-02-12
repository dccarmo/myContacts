//
//  AppDelegate.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/9/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.setApplicationAppearance()
        
        return true
    }
    
    /**
     Set up Appearance for visual elements in the app
     */
    
    func setApplicationAppearance() {
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName : UIFont(name: "AvenirNext-Medium", size: 17.0)!]
        UIView.appearance().tintColor = UIColor(red:0, green:0.64, blue:0.769, alpha:1)
    }
    
}

