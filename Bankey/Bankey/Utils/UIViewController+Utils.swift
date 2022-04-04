//
//  UIViewController+Utils.swift
//  Bankey
//
//  Created by PandaH on 4/4/22.
//

import UIKit

extension UIViewController{
    
    //sets status bar on our app
    func setStatusBar(){
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        let frame = CGRect(origin: .zero, size: statusBarSize)
        let statusbarView = UIView(frame: frame)
        
        statusbarView.backgroundColor = appColor
        view.addSubview(statusbarView)
    }
    
    //set tab images
    func setTabBarImage(imageName: String, title: String){
        //create a symbol configuration to use standard SF symbols that come with UIKit, make them large
        let configuraton = UIImage.SymbolConfiguration(scale: .large)
        //instantiate image using system name (SF symbol), using large config to set up image
        let image = UIImage(systemName: imageName, withConfiguration: configuraton)
        //add image and title to tab bar item
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
    
    
}
