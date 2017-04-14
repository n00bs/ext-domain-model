//
//  ExtensionDoubleTests.swift
//  ExtDomainModel
//
//  Created by Abhishek Chauhan on 4/13/17.
//  Copyright © 2017 Abhishek Chauhan. All rights reserved.
//

import XCTest

import ExtDomainModel

class ExtensionDoubleTests: XCTestCase {

    func testUSD() {
        let USD = 15.0
        let money = USD.USD
        XCTAssert(money.amount == 15)
        XCTAssert(money.currency == "USD")
    }
    
    func testCAN() {
        let CAN = 100.2
        let money = CAN.CAN
        XCTAssert(money.amount == 100)
        XCTAssert(money.currency == "CAN")
    }
    
    func testGBP() {
        let GBP = 8.6
        let money = GBP.GBP
        XCTAssert(money.amount == 8)
        XCTAssert(money.currency == "GBP")
    }
    
    func testEUR() {
        let EUR = 57.0
        let money = EUR.EUR
        XCTAssert(money.amount == 57)
        XCTAssert(money.currency == "EUR")
    }

}
