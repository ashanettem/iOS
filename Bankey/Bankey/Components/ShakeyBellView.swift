//
//  ShakeyBellView.swift
//  Bankey
//
//  Created by PandaH on 5/24/22.
//
//Views required override init frame, super.init(frame) and required init, fatalError with message
//to change size of view override intrinsicContentSize:CGSize, return CGSize(width, height)

import Foundation
import UIKit

class ShakeyBellView:UIView{
    
    //instantiate new imageView of type UIImageView
    //imageView holds the image
    let imageView = UIImageView()
    let badgeButton = UIButton()
    
    let buttonHeight: CGFloat = 16
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setup()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize{
        return CGSize(width: 48, height: 48)
    }
    
    
}

extension ShakeyBellView{
    
    func setup(){
        //make bell tapable using UITapGestureRecognizer
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_ :)))
        //add gesture recognizer to the imagview pass in single tap as parameter
        imageView.addGestureRecognizer(singleTap)
        //set user interaction to be true
        imageView.isUserInteractionEnabled = true
        
        //BADGE BUTTON
        badgeButton.translatesAutoresizingMaskIntoConstraints = false
        //set background color with .backgroundColor
        badgeButton.backgroundColor = .systemRed
        //sent font size with UIFont.systemFont of size
        badgeButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        //CALayer - Core Animation Layer, set the corners to be rounded
        badgeButton.layer.cornerRadius = buttonHeight/2
        //set title of the button
        badgeButton.setTitle("9", for: .normal)
        //set the title's color on button
        badgeButton.setTitleColor(.white, for: .normal)
    }
    
    func style(){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        //IMAGE
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        //create a constant var to hold the image created using UIImage, system name of bell.fill, change color to white using tintColor, rendering Mode always Original
        let image = UIImage(systemName: "bell.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.image = image
        
        
        
        
    }
    
    func layout(){
        
        //add image to subview
        self.addSubview(imageView)
        self.addSubview(badgeButton)
        
        NSLayoutConstraint.activate([
            //width of 24
            imageView.widthAnchor.constraint(equalToConstant: 24),
            //height of 24
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        //BADGE BUTTON
        NSLayoutConstraint.activate([
            //top anchor equal to the top anchor of bell view
            badgeButton.topAnchor.constraint(equalTo: imageView.topAnchor),
            //leading anchor of badge equivalent to bell's trailing anchor -9
            badgeButton.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -9),
            //width anchor of badge set to button height 16
            badgeButton.widthAnchor.constraint(equalToConstant: buttonHeight),
            //height anchor of badge set to button height 16
            badgeButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
        
    }
    
}

extension ShakeyBellView{
    
    @objc func imageViewTapped( _ recognizer: UITapGestureRecognizer){
        //call function shakeWith, duration, angle in radians, and y offset
        shakeWith(duration: 1.0, angle: .pi/8, yOffset: 0.0)
    }
    
    private func shakeWith(duration: Double, angle: CGFloat, yOffset: CGFloat){
        //number of frames
        let numberOfFrames: Double = 6
        //frame duration calculated
        let frameDuration = Double(1/numberOfFrames)
        
        //pinning to middle of image with offset of 0 at the top, point which we rotate
        imageView.setAnchorPoint(CGPoint(x: 0.5, y: yOffset))
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [], animations:{
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: frameDuration){
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            
            UIView.addKeyframe(withRelativeStartTime: frameDuration, relativeDuration: frameDuration){
                self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*2, relativeDuration: frameDuration){
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*3, relativeDuration: frameDuration){
                self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*4, relativeDuration: frameDuration){
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIImageView.addKeyframe(withRelativeStartTime: frameDuration*5, relativeDuration: frameDuration){
                //starting at inital point
                self.imageView.transform = CGAffineTransform.identity
            }
        },
        completion: nil)
    }
    
}

extension UIView{
    func setAnchorPoint(_ point: CGPoint){
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)
        
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        
        var position = layer.position
        
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        layer.position = position
        layer.anchorPoint = point
    }
}
