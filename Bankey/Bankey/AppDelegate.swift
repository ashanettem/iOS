//
//  AppDelegate.swift
//  Bankey
//
//  Created by PandaH on 3/5/22.
//

import UIKit

//access to this throughout the app
let appColor:UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
   

    var window: UIWindow? //reference to window
    
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let dummyViewController = DummyViewController()
    let mainViewController = MainViewController()
    
    var hasOnboarded = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? )->Bool{
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible() //make key and visible
        window?.backgroundColor = .systemBackground// set background
        //window?.rootViewController = LoginViewController() // set view controller onto root view controller in app delegate
        
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        dummyViewController.logoutDelegate = self
        
        window?.rootViewController = mainViewController
        
        //main view controllers is tab view controller, programmatically select th move money tab view controller
        //mainViewController.selectedIndex = 0
        
        return true
    }
    
}

extension AppDelegate:LoginViewControllerDelegate{

    func didLogin() {
        //set root view controller to next view controller to be shown
        if LocalState.hasOnboarded{
            setRootViewController(dummyViewController)
        }
        else{
            setRootViewController(onboardingContainerViewController)
        }
    }
}

extension AppDelegate:OnboardingContainerViewControllerDelegate{
    
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(dummyViewController)
        
    }
}

extension AppDelegate:LogoutDelegate{
    
    func didLogout() {
        setRootViewController(loginViewController)
    }
}


extension AppDelegate{
    
    //set a given UIViewController onto the rootview controller with a smooth transition
    func setRootViewController(_ vc: UIViewController, animated:Bool = true){
        
        
        guard animated, let window = self.window else{
            //if animated is false, set window.rootViewController to vc passed in
            self.window?.rootViewController = vc
            //make window key and visible
            self.window?.makeKeyAndVisible()
            return
        }
        
        //if animated is true set window.rootViewController to vc passed in
        window.rootViewController = vc
        //make window key and visible
        window.makeKeyAndVisible()
        //transition to view with window, duration of .3, option transitional cross dissolve, animations nil, completion nil
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}


