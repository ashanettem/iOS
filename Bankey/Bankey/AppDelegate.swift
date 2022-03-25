//
//  AppDelegate.swift
//  Bankey
//
//  Created by PandaH on 3/5/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? //reference to window
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? )->Bool{
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible() //make key and visible
        window?.backgroundColor = .systemBackground// set background
        //window?.rootViewController = LoginViewController() // set view controller onto root view controller in app delegate
        window?.rootViewController = OnboardingViewController()
        return true
    }
    
}

