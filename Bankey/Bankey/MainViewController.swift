//
//  MainViewController.swift
//  Bankey
//
//  Created by PandaH on 4/4/22.
//

import Foundation
import UIKit

//class called main view controller that extends the UI tab bar controller
class MainViewController:UITabBarController{
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        setupViews()
        setupTabBar()
    }
    
    private func setupViews(){
        
        //set up views
        //instantiate view controllers
        let summaryVC = AccountSummaryViewController()
        let moneyVC = MoveMoneyViewController()
        let moreVC = MoreViewController()
        
        //set up tab bar
        //set tab bar image for each view controller with image name and title
        summaryVC.setTabBarImage(imageName:"list.dash.header.rectangle", title: "Summary")
        moneyVC.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Move Money")
        moreVC.setTabBarImage(imageName: "ellipsis.circle", title: "More")
        
        //instantiate navigation controllers whose root controller is set to their corresponding view controller
        let summaryNC = UINavigationController(rootViewController: summaryVC)
        let moneyNC = UINavigationController(rootViewController: moneyVC)
        let moreNC = UINavigationController(rootViewController: moreVC)
        
        //set the navigation bar color to app color (system teal)
        summaryNC.navigationBar.barTintColor = appColor
        
        //hide the navigation bar at the top
        hideNavigationBarLine(summaryNC.navigationBar)
        
        //create an array with all tab bar view controllers
        let tabBarList = [summaryVC, moneyVC, moreVC]
        
        //set viewControlers equal to tab bar list array
        viewControllers = tabBarList
        
        
    }
    
    //hide 1px line that appears under nav bar
    private func hideNavigationBarLine(_ navigationBar: UINavigationBar){
        //take nav bar, create a blank image
        let img = UIImage()
        //set shadow to be img
        navigationBar.shadowImage = img
        //set background to be img
        navigationBar.setBackgroundImage(img, for: .default)
        //set
        navigationBar.isTranslucent = false
    }
    
    private func setupTabBar(){
        tabBar.tintColor = appColor
        tabBar.isTranslucent = false
    }
}

class AccountSummaryViewController:UIViewController{
    override func viewDidLoad(){
        view.backgroundColor = .systemGreen
    }
}

class MoveMoneyViewController:UIViewController{
    override func viewDidLoad() {
        view.backgroundColor = .systemOrange
    }
}

class MoreViewController:UIViewController{
    override func viewDidLoad() {
        view.backgroundColor = .systemPurple
    }
}
