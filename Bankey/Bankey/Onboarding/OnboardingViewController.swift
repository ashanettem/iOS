//
//  OnboardingViewController.swift
//  Bankey
//
//  Created by PandaH on 3/25/22.
//

import Foundation
import UIKit

class OnboardingViewController:UIViewController{
    
    let stackView = UIStackView()
    let imageView = UIImageView()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension OnboardingViewController{
    func style(){
        //STACKVIEW
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        //IMAGE
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //scale entire image to fit within Image View
        imageView.contentMode = .scaleAspectFit
        //set image to image name in assets folder
        imageView.image = UIImage(named: "delorean")
        
        
        //LABEL
        label.translatesAutoresizingMaskIntoConstraints = false
        //center text
        label.textAlignment = .center
        //dynamic type of title 3 built in font
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        //adjust font as the size changes the font will also
        label.adjustsFontForContentSizeCategory = true
        //make text multilined
        label.numberOfLines = 0
        //text of label
        label.text = "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in 1989."
        
        
    }
    
    func layout(){
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        ])
        
    }
}
