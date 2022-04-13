//
//  CurrencyFormatter.swift
//  Bankey
//
//  Created by PandaH on 5/16/22.
//

import UIKit

struct CurrencyFormatter{
    
    //takes decimal breaks into two parts and then does the formatting
    func makeAttributedCurrency(_ amount: Decimal)->NSMutableAttributedString{
        let tuple = breakIntoDollarsAndCents(amount)
        return makeBalanceAttributed(dollars: tuple.0, cents: tuple.1)
    }
    
    //Converts 929466 > "929466" "23"
    func breakIntoDollarsAndCents(_ amount: Decimal)->(String, String){
        //modf takes any decimal double value and breaks into tuple, (integer, fraction)
        let tuple = modf(amount.doubleValue)
        
        //convert dollar tuple.0
        let dollars = convertDollar(tuple.0)
        let cents = convertCents(tuple.1)
        
        return (dollars, cents)
    }
    
    private func convertDollar(_ dollarPart: Double)->String{
        //convert to currency using dollars formatted adds back decimal -> "$929,466.00"
        let dollarsWithDecimal = dollarsFormatted(dollarPart)
        //instantiate formatter with Number Formatter class
        let formatter = NumberFormatter()
        //use formatter to access decimal separator
        let decimalSeparator = formatter.decimalSeparator!//"."
        //use decimal separator to strip decimal from currency format into array named dollar component using components function
        let dollarComponent = dollarsWithDecimal.components(separatedBy: decimalSeparator) //"$929,466" "00"
        //access the dollar amount in first index using first function
        var dollars = dollarComponent.first! //"$929,466"
        //remove the dollar sign from the dollar amount using remove first array function
        dollars.removeFirst() //"929,466"
        
        //return dollar amount -> "929,466"
        return dollars
    }
    
    private func convertCents(_ centPart: Double)->String{
        let cents:String
        
        //if centPart is 0, cents = 00
        if centPart == 0{
            cents = "00"
        //else use string formatter to make cent Part only 2 decimal places i.e. %0.2f
        }else{
            cents = String(format: "%0.f", centPart * 100)
        }
        
        //return cents
        return cents
    }
    
    func dollarsFormatted(_ dollars:Double)->String{
        //instantiate formatter var from NumberFormatter class
        let formatter = NumberFormatter()
        //set formatter numberStyle to currency
        formatter.numberStyle = .currency
        //set formatter usesGroupingSeparator to true
        formatter.usesGroupingSeparator = true
        
        //use formatter to format dollars downcasted to NSNumber into currency string
        if let result = formatter.string(from: dollars as NSNumber){
            return result
        }
        
        return ""
    }
    
    private func makeBalanceAttributed(dollars: String, cents: String)->NSMutableAttributedString{
        
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
