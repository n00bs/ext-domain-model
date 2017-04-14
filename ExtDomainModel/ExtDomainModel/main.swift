//
//  main.swift
//  ExtDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

// Implementing protocols and extensions

protocol CustomStringConvertible {
    var description : String { get }
}

protocol Mathematics {
    func add (_ to: Money) -> Money
    func subtract (_ from: Money) -> Money
}

public func + (left: Money, right: Money) -> Money {
    return left.add(right)
}

public func - (left: Money, right: Money) -> Money {
    return left.subtract(right)
}

extension Double {
    var USD: Money { return Money(amount: Int(self), currency: "USD") }
    var CAN: Money { return Money(amount: Int(self), currency: "CAN") }
    var EUR: Money { return Money(amount: Int(self), currency: "EUR") }
    var GBP: Money { return Money(amount: Int(self), currency: "GBP") }
}

////////////////////////////////////
// Money
//
public struct Money: Mathematics, CustomStringConvertible {
    public var amount : Int
    public var currency : String
    
    public var description: String {
        get {
            return "\(self.currency)\(Double(self.amount))"
        }
    }
    
    // Decides the current state of the money with USD as base
    private func state(type: String) -> Double {
        switch type {
            case "USD":
                return 1
            case "GBP":
                return 0.5
            case "EUR":
                return 1.5
            case "CAN":
                return 1.25
            default:
                return 0
        }
    }
    
    public func convert(_ to: String) -> Money {
        let currentState = state(type: self.currency)
        let convertState = state(type: to)
        return Money(amount: Int(Double(self.amount) * convertState / currentState), currency: to)
    }
    
    public func add(_ to: Money) -> Money {
        let converted = self.convert(to.currency)
        return Money(amount: (converted.amount + to.amount), currency: to.currency)
    }
    
    public func subtract(_ from: Money) -> Money {
        let converted = self.convert(from.currency)
        return Money(amount: (from.amount - converted.amount), currency: from.currency)
    }
}

////////////////////////////////////
// Job
//
open class Job: CustomStringConvertible {
    fileprivate var title : String
    fileprivate var type : JobType
    
    public var description: String {
        get {
            var earning : String
            switch self.type {
                case .Hourly(let hourlyIncome):
                    earning = "Earns \(hourlyIncome) an hour."
                case .Salary(let yearlyIncome):
                    earning = "Earns \(yearlyIncome) an year."
            }
            return "\(self.title). \(earning)"
        }
    }
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    open func calculateIncome(_ hours: Int) -> Int {
        var income: Int = 0
        switch self.type {
            case .Hourly(let hourlyIncome):
                income = Int(Double(hours) * hourlyIncome)
            case .Salary(let yearlyIncome):
                income = yearlyIncome
        }
        return income
    }
    
    open func raise(_ amt : Double) {
        switch self.type {
        case .Hourly(let hourlyIncome):
            self.type = JobType.Hourly(hourlyIncome + amt)
        case .Salary(let yearlyIncome):
            self.type = JobType.Salary(yearlyIncome + Int(amt))
        }
    }
}

////////////////////////////////////
// Person
//
open class Person: CustomStringConvertible {
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    fileprivate var _job : Job? = nil
    open var job : Job? {
        get { return self._job }
        set(value) {
            if (self.age >= 16) {
                self._job = value!
            }
        }
    }
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get { return self._spouse }
        set(value) {
            if (self.age >= 18 && value!.age >= 18) {
                self._spouse = value!
            }
        }
    }
    
    public var description: String {
        get {
            return self.toString()
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    open func toString() -> String {
        let jobDescription = self.job != nil ? self.job!.description : nil
        let spouseDescription = self.spouse != nil ? self.spouse!.description : nil
        let toPrint = "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(jobDescription) spouse:\(spouseDescription)]"
        return toPrint
    }
}

////////////////////////////////////
// Family
//
open class Family: CustomStringConvertible {
    fileprivate var members : [Person] = []
    
    public var description: String {
        get {
            var family : String
            let memberCount = members.count
            if (memberCount <= 0) {
                family = "There's no one in the family."
            } else {
                family = "There are \(memberCount) members in the family. "
                family += "The family's household income is \(self.householdIncome()). "
                for i in 0 ..< memberCount-1 {
                    family += "\(members[i].firstName), "
                }
                family += "\(members[memberCount-1].firstName) are in the family."
            }
            return family
        }
    }
    
    public init(spouse1: Person, spouse2: Person) {
        if (spouse1.spouse == nil && spouse2.spouse == nil) {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            self.members.append(spouse1)
            self.members.append(spouse2)
        }
    }
    
    open func haveChild(_ child: Person) -> Bool {
        for member in self.members {
            if (member.age >= 21) {
                self.members.append(child)
                return true
            }
        }
        return false
    }
    
    open func householdIncome() -> Int {
        var totalIncome: Int = 0
        for member in self.members {
            if (member.job != nil) {
                // Assumes that a person works for 2000 hours.
                totalIncome = totalIncome + member.job!.calculateIncome(2000)
            }
        }
        return totalIncome
    }
}
