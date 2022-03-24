//
//  ViewController.swift
//  Bankey
//
//  Created by PandaH on 3/5/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    //add button to loginVC, default .system
    let signInButton = UIButton(type: .system)
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let errorMessageLabel = UILabel()
    
    //computer property that return text from username field, returns type optional
    var username:String?{
        return loginView.usernameTextField.text
    }
    //cpomputer property that returns text from password, returns type optional
    var password:String?{
        return loginView.passwordTextField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        style()
        layout()
    }


}

extension LoginViewController{
    private func style(){
        
        //LOGIN VIEW STYLE
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        //BUTTON STYLE
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        //filled style of button, i.e plan, gray, tinted
        signInButton.configuration = .filled()
        //distance between image and text/title in button, the activity indicator in this case 
        signInButton.configuration?.imagePadding = 8
        //button text
        signInButton.setTitle("Sign In", for: [])
        //action that calls selector called signInTapped (function defined in extension)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        //TITLE LABEL
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "Bankey"
        titleLabel.isHidden = false
        
        
        //SUBTITLE LABEL
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.textColor = .black
        subTitleLabel.textAlignment = .center
        subTitleLabel.numberOfLines = 0
        subTitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subTitleLabel.adjustsFontForContentSizeCategory = true
        subTitleLabel.text = "Your premium source for all things banking!"
        subTitleLabel.isHidden = false
        
        //ERROR MESSAGE LABEL
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        //align text in the center of label
        errorMessageLabel.textAlignment = .center
        //set text color
        errorMessageLabel.textColor = .systemRed
        //set number of lines
        errorMessageLabel.numberOfLines = 0
        //set error message text -default
        //errorMessageLabel.text = "Error failure"
        //set whether label is hidden or not
        errorMessageLabel.isHidden = true
    }
    
    private func layout(){
        //ADD SUBVIEWS
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        //AUTO LAYOUT FOR TITLE LABEL
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 14)
        ])
        
        //AUTO LAYOUT FOR SUBTITLE LABEL
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.topAnchor, multiplier: 3),
            //set leading constraint to view leading anchor to allow text wrap
            subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            //set trailing constraint to view trailing anchor to allow text wrap
            view.trailingAnchor.constraint(equalTo: subTitleLabel.trailingAnchor)
        ])
        
        //AUTO LAYOUT FOR LOGIN VIEW
        NSLayoutConstraint.activate([
            //center loginView on Y axis
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //top anchor is below bottom anchor of greeting label
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subTitleLabel.bottomAnchor, multiplier: 1),
            //leading anchor (left) of loginView set to be after leading anchor of the view
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            //trailing anchor (right) set to be after trailing anchor of the loginView
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)])
            
        //AUTO LAYOUT FOR SIGN IN BUTTON
        NSLayoutConstraint.activate([
            //signIn button top anchor two multipliers beneath login view bottom anchor
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            //signIn button leading anchor equal to login view leading anchor
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            //signIn button trailing anchor equal to login view trailing anchor
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)])
            
        //AUTO LAYOUT FOR MESSAGE LABEL
        NSLayoutConstraint.activate([
            //message label top anchor two multipliers beneath signIn button
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)])
        
    }
}

//MARK: Actions
extension LoginViewController{
    //logic for what happens when button is tapped
    @objc func signInTapped(sender:UIButton){
        errorMessageLabel.isHidden = true
        
        login()
    }
    
    
    //login function does validation check of username and password textfields
    private func login(){
        //using guard let to unwrap username optional
        guard let username = username, let password = password else{
            assertionFailure("Username / password should never be nil")
            return
        }
        
        //check to see if username and password are blank
        if username.isEmpty || password.isEmpty{
            configureView(withMessage: "Username / Password cannot be blank")
            return
        }
        
        if username == "Amanda" && password == "welcome"{
            //shows the activity indicator / spining circle
            signInButton.configuration?.showsActivityIndicator = true
        }
        else{
            configureView(withMessage: "Incorrect username or password")
        }
    }
    
    
    //configure view function displays error message
    private func configureView(withMessage message: String){
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
        
    }
}
