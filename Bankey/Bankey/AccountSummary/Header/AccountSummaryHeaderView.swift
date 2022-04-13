//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by PandaH on 4/21/22.
//

import UIKit

class AccountSummaryHeaderView: UIView{
    
    
    @IBOutlet var contentView: UIView!
    
    //Regular UIView with CGRect frame and commonInit
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    //the size a view by default gives itself, set height
    override var intrinsicContentSize: CGSize{
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    
    private func commonInit(){
        //go to bundle and pass name of the class for bundle
        let bundle = Bundle(for: AccountSummaryHeaderView.self)
        //load bundle with nib
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
        //add xib content view to subview
        addSubview(contentView)
        //set background color
        contentView.backgroundColor = appColor
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        //constraints - pin nib to all four edges
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    
    }
}
