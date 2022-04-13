//
//  AccountSummarCell.swift
//  Bankey
//
//  Created by PandaH on 5/3/22.
//

import Foundation
import UIKit

//create account cells programmatically
class AccountSummaryCell:UITableViewCell{
    
    enum AccountType: String{
        case Banking
        case CreditCard
        case Investment
    }
    
    struct ViewModel{
        let accountType: AccountType //enum
        let accountName: String
        let balance: Decimal
        
        var balanceAsAttributedString: NSAttributedString{
            //Currency Formatter Struct call to function
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }
    
    //can't guarantee the cell will have all the details it should have when API call made
    let viewModel:ViewModel? = nil
    
    var typeLabel = UILabel()
    var underlineView = UIView()
    var nameLabel = UILabel()
    var balanceStackView = UIStackView()
    var balanceLabel = UILabel()
    var balanceAmountLabel = UILabel()
    var chevronImageView = UIImageView()
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 112
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        layout()
    }
    
    
    //support required init for loading storyboads
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AccountSummaryCell{
    private func setup(){
        
        //typeLabel
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        //font resizes self if someone changes category size on device i.e. accessiblity
        typeLabel.adjustsFontForContentSizeCategory = true
        typeLabel.text = "Account type"
        
        
        //dividerView
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = appColor
        
        //nameLabel
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.text = "Account Name"
        
        //balanceStackView
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceStackView.axis = .vertical
        balanceStackView.spacing = 0
        
        //balanceLabel
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.textAlignment = .right
        balanceLabel.text = "Some balance"
        
        //balanceAmountLabel
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.textAlignment = .right
        //attributedText used to formate AttributedStrings
        balanceAmountLabel.attributedText = makeFormattedBalance(dollars: "XXX,XXX", cents: "XX")
        //balanceAmountLabel.text = "$929,466.63"
        
        //add balance label and balanceAmount label to balance stack view
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        
        //chevron Image View
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        //declare and instantiate chevron image to put in image view
        //UIImage of system SF symbol cheveron pointing to right, set tint color to app color, rendering always original
        let chevronImage = UIImage(systemName: "chevron.right")!.withTintColor(appColor, renderingMode: .alwaysOriginal)
        //assign chevron image to chevron image view
        chevronImageView.image = chevronImage
        
        //Cells have contentView - the content view of a UITableViewCell object is the default superview for content that the cell displays
        //add to contentView.addSubview()
        contentView.addSubview(typeLabel)
        contentView.addSubview(underlineView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(balanceStackView)
        contentView.addSubview(chevronImageView)
    }
    
    private func layout(){
        
        //typeLabel Constraint
        NSLayoutConstraint.activate(
            [typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 2),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2)]
        )
        
        //underlineView Constraint
        NSLayoutConstraint.activate([
            underlineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            underlineView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2),
            //set width constraint
            underlineView.widthAnchor.constraint(equalToConstant: 70),
            //set height constraint
            underlineView.heightAnchor.constraint(equalToConstant: 4)
        ])
        
        //nameLabel Constraint
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2)
        ])
        
        //balanceStackView Constraints
        NSLayoutConstraint.activate([
            balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 0),
            balanceStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: nameLabel.trailingAnchor, multiplier: 4),
            trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4)
        ])
        
        //chevronImageView Constraint
        NSLayoutConstraint.activate([
            chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1)
        ])
        
    }
    
    private func makeFormattedBalance(dollars: String, cents: String)->NSMutableAttributedString{
        
        //key value dictionary property, key of font, and value of font preferred font style with baseline offset of 8
        //baseline offset elevates 8 points from the ground
        //dollar sign smaller
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        
        //dollar Attributes - bigger font
        //declare dollarAttributes as Key-Value pair of key type NSAttributed String, and value type Any
        //key of font (NSAttributedString type), value of font preferred and baselineOffset if applicable
        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        
        //cents Attribute - smaller and raised up by 8 points
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
        
        //define each as separate NSAttributedStrings and combine them at the end
        //define root string, pass in dollar sign and set dollar sign attributes on the dollar sign
        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollarString = NSMutableAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSMutableAttributedString(string: cents, attributes: centAttributes)
        
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }
}

extension AccountSummaryCell{
    func configure(with vm: ViewModel){
        typeLabel.text = vm.accountType.rawValue
        nameLabel.text = vm.accountName
        balanceAmountLabel.attributedText = vm.balanceAsAttributedString
        
        switch vm.accountType{
            
        case .Banking:
            underlineView.backgroundColor = appColor
            balanceLabel.text = "Current Balance"
        case .CreditCard:
            underlineView.backgroundColor = .systemOrange
            balanceLabel.text = "Current Balance"
        case .Investment:
            underlineView.backgroundColor = .systemPurple
            balanceLabel.text = "Value"
        }
    }
}
