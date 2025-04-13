struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
import Foundation



public struct Money {
    let amount : Int
    let currency: String
    
    init(amount : Int, currency : String) {
            self.amount = amount;
            self.currency = currency;
        }
    
    
    
    func convert (_ toCur : String) -> Money {
        var newCur : String
        var newAmt : Double
        
        var toUSDAmt: Double = Double(self.amount);
        
        // Convert to USD
        if self.currency == "EUR" {
            toUSDAmt = toUSDAmt * (2/3)
        }
        else if self.currency == "GBP" {
            toUSDAmt = toUSDAmt * (2)
        }
        else if self.currency == "CAN" {
            toUSDAmt = toUSDAmt * (0.8)
        }
        else{
            newCur = self.currency
        }
        
        // Convert to new Cur
        if toCur == "EUR" {
            newAmt = toUSDAmt * (1.5)
        }
        else if toCur == "GBP" {
            newAmt = toUSDAmt * (0.5)
        }
        else if toCur == "CAN" {
            newAmt = toUSDAmt * (1.25)
        }
        else{
            newAmt = toUSDAmt;
        }
        
        newCur = toCur;
        return Money(amount: Int(round(newAmt)), currency: newCur)
    }
    
    
    
  func  add(_ other: Money) -> Money {
        if(self.currency != other.currency) {
            let moneyConverted : Money = self.convert(other.currency)
            return Money(amount: other.amount + moneyConverted.amount, currency: other.currency)
        }
        else {
            return Money(amount: self.amount + other.amount, currency: self.currency)
        }
    }
    
   func  subtract(_ other:Money) -> Money {
        if(self.currency != other.currency) {
            let moneyConverted : Money = self.convert(other.currency)
            return Money(amount:  moneyConverted.amount - other.amount, currency: self.currency)
        }
        else {
            return Money(amount: self.amount - other.amount, currency: self.currency)
        }
    }
}


////////////////////////////////////
// Job
//
public class Job {
    
    var title : String
    var type : JobType
    
    init(title:String,type: JobType )  {
        self.title = title
        self.type = type
        
    }
    
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    
    func calculateIncome(_ hoursWorked: Int) -> Int {
        switch self.type {
        case .Hourly(let double):
            return Int(double * Double(hoursWorked))
        case .Salary(let uInt):
            return Int(uInt)
        }
    }
    
    func raise(byAmount : Int){
        switch type {
        case .Hourly(let double):
            self.type = .Hourly(double + Double(byAmount))
        case .Salary(let uInt):
            self.type = .Salary(uInt + UInt(byAmount))
        }
    }
    
    func raise(byAmount : Double){
        switch type {
        case .Hourly(let double):
            self.type = .Hourly(double + Double(byAmount))
        case .Salary(let uInt):
            self.type = .Salary(uInt + UInt(byAmount))
        }
    }

    
    func raise(byPercent : Double){
        switch type {
        case .Hourly(let double):
            self.type = .Hourly(double * (1 + Double(byPercent)))
        case .Salary(let uInt):
            let newSalary = Double(uInt) * (1.0 + byPercent)
            self.type = .Salary(UInt(newSalary))
        }
    }
    
    
}

////////////////////////////////////
// Person
//
public class Person {
    var firstName : String
    var lastName : String
    var age : Int
    var job : Job?
    var spouse : Person?
    
    init(firstName : String, lastName : String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    init(firstName : String, lastName : String, age: Int, job: Job?, spouse: Person?) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.job = job
        self.spouse = spouse
    }
    
    func toString() -> String {
        var returnString = "[Person: \(firstName) \(lastName), age: \(age)"

        if let job = job {
            switch job.type {
            case .Hourly(let rate):
                returnString += ", job: Hourly(\(rate))"
            case .Salary(let salary):
                returnString += ", job: Salary(\(salary))"
            }
        }

        if let spouse = spouse {
            returnString += ", spouse: \(spouse.firstName)"
        }

        return returnString + "]"
    }

}

////////////////////////////////////
// Family
//
public class Family {
    
    var members : [Person]
    init(spouse1 : Person, spouse2 : Person){
        guard spouse1.spouse == nil && spouse2.spouse == nil else {
            fatalError("Spouses can only marry within the family")
        }
        
        self.members = [spouse1, spouse2]
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
        
    }
    
    func haveChild(_ child : Person) -> Bool{
        if(members[0].age >= 21 || members[1].age >= 21){
            members.append(child)
            return true
        }
        return false
    }
    
    func householdIncome() -> Int{
        var totalIncome : Int = 0
        for member in members{
            totalIncome += member.job?.calculateIncome(2000) ?? 0
        }
        return totalIncome
    }
    
    
}
