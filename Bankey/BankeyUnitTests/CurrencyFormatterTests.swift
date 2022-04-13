//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by PandaH on 5/18/22.
//

import Foundation
//import XCTest
import XCTest
//access all files in Bankey target
@testable import Bankey

class CurrencyFormatterTests:XCTestCase{
    
    var formatter:CurrencyFormatter!
    
    //set up run everytime we run a unit test, once per test, for independency
    override func setUp() {
        super.setUp()
        
        //create brand new formatter every single time we run a test
        formatter = CurrencyFormatter()
    }
    
    func testBreakIntoDollarsAndCents() throws{
        //use format to access breakIntoDollarsAndCents function, passing in 929466.23 as argument
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        //assert that first part of returned tuple is 929,466
        XCTAssertEqual(result.0, "929,466")
        //assert that second half of returned tuple is 23
        XCTAssertEqual(result.1, "23")
    }
    
    func testDollarsFormatted() throws{
        let result = formatter.dollarsFormatted(929466.23)
        
        XCTAssertEqual(result, "$929,466.23")
    }
    
    func testZeroDollarsFormatted() throws{
        let local = Locale.current
        let currencySymbol = local.currencySymbol!
        
        
        let result = formatter.dollarsFormatted(0.00)
        
        XCTAssertEqual(result, "\(currencySymbol)0.00")
    }
}
