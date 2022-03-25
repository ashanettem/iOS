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
    
    let heroImageName:String
    let titleText:String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    init(heroImageName: String, titleText: String){
        self.heroImageName = heroImageName
        self.titleText = titleText
        
        super.init(nibName: nil, bundle: nil)
    }
    
    //required initializer/constructor for storyboards, should never reach the fatal line if no storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingViewController{
    func style(){
        
        view.backgroundColor = .systemBackground
        
        //STACKVIEW
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        //IMAGE
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //scale entire image to fit within Image View
        imageView.contentMode = .scaleAspectFit
        //set image to image name in assets folder
        imageView.image = UIImage(named: heroImageName)
        
        
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
        label.text = titleText
        
        
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
