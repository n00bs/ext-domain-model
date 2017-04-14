//
//  CustomStringConvertibleTests.swift
//  ExtDomainModel
//
//  Created by Abhishek Chauhan on 4/13/17.
//  Copyright © 2017 Abhishek Chauhan. All rights reserved.
//

import XCTest

class CustomStringConvertibleTests: XCTestCase {
    
    func testUSDDescription() {
        let twelveUSD = Money(amount: 12, currency: "USD")
        XCTAssert(twelveUSD.description == "USD12.0")
    }
    
    func testGBPDescription() {
        let fiveGBP = Money(amount: 5, currency: "GBP")
        XCTAssert(fiveGBP.description == "GBP5.0")
    }
    
    func testEURDescription() {
        let fifteenEUR = Money(amount: 15, currency: "EUR")
        XCTAssert(fifteenEUR.description == "EUR15.0")
    }
    
    func testCANDescription() {
        let fifteenCAN = Money(amount: 15, currency: "CAN")
        XCTAssert(fifteenCAN.description == "CAN15.0")
    }
    
    func testHourlyJobDescription() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.description == "Janitor. Earns 15.0 an hour.")
    }
    
    func testYearlyJobDescription() {
        let job = Job(title: "Software Developer", type: Job.JobType.Salary(150000))
        XCTAssert(job.description == "Software Developer. Earns 150000 an year.")
    }
    
    func testPersonDescription() {
        let person = Person(firstName: "Amy", lastName: "Jane", age: 45)
        XCTAssert(person.description == "[Person: firstName:Amy lastName:Jane age:45 job:nil spouse:nil]")
    }
    
    func testFamilyWithKids() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        ted.job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        
        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)
        
        let family = Family(spouse1: ted, spouse2: charlotte)
        
        XCTAssert(family.description == "There are 2 members in the family. The family's household income is 1000. Ted, Charlotte are in the family.")
        
        let mike = Person(firstName: "Mike", lastName: "Neward", age: 22)
        mike.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
        
        let matt = Person(firstName: "Matt", lastName: "Neward", age: 16)
        let _ = family.haveChild(mike)
        let _ = family.haveChild(matt)
        
        XCTAssert(family.description == "There are 4 members in the family. The family's household income is 12000. Ted, Charlotte, Mike, Matt are in the family.")
    }
    

}
