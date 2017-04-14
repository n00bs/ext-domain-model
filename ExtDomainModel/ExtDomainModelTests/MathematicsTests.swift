//
//  MathematicsTests.swift
//  ExtDomainModel
//
//  Created by Abhishek Chauhan on 4/13/17.
//  Copyright © 2017 Abhishek Chauhan. All rights reserved.
//

import XCTest

import ExtDomainModel

class MathematicsTests: XCTestCase {

    let twelveUSD = Money(amount: 12, currency: "USD")
    let fiveGBP = Money(amount: 5, currency: "GBP")
    let fifteenEUR = Money(amount: 15, currency: "EUR")
    
    func testAddUSDtoGBP() {
        let sum = twelveUSD + fiveGBP
        XCTAssert(sum.currency == "GBP")
        XCTAssert(sum.amount == 11)
    }
    
    func testAddGBPtoEUR() {
        let sum = fiveGBP + fifteenEUR
        XCTAssert(sum.currency == "EUR")
        XCTAssert(sum.amount == 30)
    }
    
    func testSubtractUSDfromEUR() {
        let diff = twelveUSD - fifteenEUR
        XCTAssert(diff.currency == "EUR")
        XCTAssert(diff.amount == -3)
    }
    
    func testSubtractEURfromGBP() {
        let diff = fifteenEUR - fiveGBP
        XCTAssert(diff.currency == "GBP")
        XCTAssert(diff.amount == 0)
    }

}

