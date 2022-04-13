//
//  DecimalUtils.swift
//  Bankey
//
//  Created by PandaH on 5/16/22.
//

import Foundation

extension Decimal{
    
    //computed variable that takes the decimal itself and converts into double using NSDecimalNumber().doubleValue function
    var doubleValue:Double{
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
