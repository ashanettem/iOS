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
    //let dummyViewController = DummyViewController()
    let mainViewController = MainViewController()
    
    var hasOnboarded = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? )->Bool{
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible() //make key and visible
        window?.backgroundColor = .systemBackground// set background
        //window?.rootViewController = LoginViewController() // set view controller onto root view controller in app delegate
        
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        //dummyViewController.logoutDelegate = self
        
        displayLogin()
        return true
    }
    
    private func displayLogin(){
        //calls setRootViewController function passing in the loginViewController as an argument
        setRootViewController(loginViewController)
    }
    
    private func displayNextScreen(){
        if LocalState.hasOnboarded{
            prepMainView()
            setRootViewController(mainViewController)
        }else{
            setRootViewController(onboardingContainerViewController)
        }
    }
    
    private func prepMainView(){
        mainViewController.setStatusBar()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
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


extension AppDelegate:LoginViewControllerDelegate{

    func didLogin() {
       displayNextScreen()
    }
}

extension AppDelegate:OnboardingContainerViewControllerDelegate{
    
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        prepMainView()
        setRootViewController(mainViewController)
        
    }
}

extension AppDelegate:LogoutDelegate{
    
    func didLogout() {
        setRootViewController(loginViewController)
    }
}





