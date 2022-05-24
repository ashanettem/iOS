//
//  UITextFieldSecureToggle.swift
//  Bankey
//
//  Created by PandaH on 5/23/22.
//
import UIKit
import Foundation

//add password toggle button to right hand side of text field to right view and right view mode
let passwordToggleButton = UIButton(type: .custom)

extension UITextField{
    //defines a button that toggles into two states
    func enablePasswordToggle(){
        //normal state, initially shown
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        //selected state, shown when selected
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        //if clicked (touch up inside) the style is flipped between secure entry or not
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = passwordToggleButton
        rightViewMode = .always
    }
    
    
    @objc func togglePasswordView(_ sender: Any){
        //set text entry to true or false
        isSecureTextEntry.toggle()
        //set password toggle from selected to normal, depending on state when pressed
        passwordToggleButton.isSelected.toggle()
    }
}
