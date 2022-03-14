//
//  LoginView.swift
//  Bankey
//
//  Created by PandaH on 3/5/22.
//

import Foundation
import UIKit

class LoginView:UIView{
    
    let stackView = UIStackView()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    //divider view
    let dividerView = UIView()
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //intrinsic content size is the default size an element wants to size itself in auto layout
    //buttons, labels, and text fields already have a size
    //this sets the view to a size of 200 x 200
    //override var intrinsicContentSize: CGSize{
        //return CGSize(width: 200, height: 200)
    //}
}

extension LoginView{
    func style(){
        
        //view
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        //stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical //top and bottom
        stackView.spacing = 8 //gap between elements
        
        //username text field
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "Username"
        usernameTextField.delegate = self
        
        //password text field
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true //Secure's password entry i.e ***
        passwordTextField.delegate = self
        
        //divider view
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .secondarySystemFill
        
        //add rounded corners by accessing the CA layer, corner Radius, clip to bounds, exclude background img
        layer.cornerRadius = 5
        clipsToBounds = true
        
    }
    
    func layout(){
        
        //add elements to stackView
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(passwordTextField)
        addSubview(stackView)
        
        //addSubview(usernameTextField)
        
        //Constraints Array
        NSLayoutConstraint.activate([
            //top anchor set to be below topAnchor of the view (custom view allows access to "view" unlike vc)
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            //leading anchor (left) set to spacing after leadingAnchor of the view
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            //trailing anchor (right) set to spacing after trailing anchor of stack view
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            //bottom anchor set to be below the stack view's bottom anchor
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
        
        ])
        
        //add height constraint to divider view, is active same as activate in ns layout constraint
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}

extension LoginView:UITextFieldDelegate{
    
    //end the editing and return true if they hit return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    
    //make checks to see what is in text field
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
