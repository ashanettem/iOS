//
//  DummyViewController.swift
//  Bankey
//
//  Created by PandaH on 3/28/22.
//

import Foundation
import UIKit

class DummyViewController:UIViewController{
    
    let stackView = UIStackView()
    let label = UILabel()
    
    let logoutButton = UIButton(type: .system)
    let loginViewController = LoginViewController()
    
    weak var logoutDelegate: LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        style()
        layout()
    }
}

extension DummyViewController{
    func style(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.configuration = .filled()
        logoutButton.setTitle("Logout", for: [])
        
        //the target object whose action method is called
        //selector allows us to referce obj-c method from swift, i.e. @obj
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .primaryActionTriggered)
    }
    
    func layout(){
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(logoutButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
}

extension DummyViewController{
    
    //@objc bridges swift into obj-c, allows for obj-c runtime in swift
    @objc func logoutButtonTapped(sender:UIButton){
        logoutDelegate?.didLogout()
    }
}


