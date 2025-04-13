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
    
    init?(amount : Int, currency : String) {
        if currency != "USD" && currency != "EUR" && currency != "GBP" && currency != "CAN" {
            return nil;
        } else {
            self.amount = amount;
            self.currency = currency;
        }
    }
    
    
    func convert (toCur : String) -> Money {
        var newCur : String
        var newAmt : Double
        
        var toUSDAmt: Double = Double(self.amount);
        
        // Convert to USD
        if self.currency == "EUR" {
            toUSDAmt = toUSDAmt * (1.5/2)
        }
        else if self.currency == "GBP" {
            toUSDAmt = toUSDAmt * (0.5/2)
        }
        else if self.currency == "CAN" {
            toUSDAmt = toUSDAmt * (1.25/4)
        }
        else{
            newCur = self.currency
        }
        
        // Convert to new Cur
        if toCur == "EUR" {
            newAmt = toUSDAmt * (1.5/2)
        }
        else if toCur == "GBP" {
            newAmt = toUSDAmt * (0.5/2)
        }
        else if toCur == "CAN" {
            newAmt = toUSDAmt * (1.25/4)
        }
        else{
            newAmt = toUSDAmt;
        }
        
        newCur = toCur;
        return Money(amount: Int(round(newAmt)), currency: newCur)!
    }
    
    
    
  func  add(_ other: Money) -> Money {
        if(self.currency != other.currency) {
            var moneyConverted : Money = self.convert(toCur: other.currency)
            return Money(amount: other.amount + moneyConverted.amount, currency: other.currency)!
        }
        else {
            return Money(amount: self.amount + other.amount, currency: self.currency)!
        }
    }
    
   func  subtract(_ other:Money) -> Money {
        if(self.currency != other.currency) {
            var moneyConverted : Money = self.convert(toCur: other.currency)
            return Money(amount: self.amount - moneyConverted.amount, currency: self.currency)!
        }
        else {
            return Money(amount: self.amount - other.amount, currency: self.currency)!
        }
    }
}

////////////////////////////////////
// Job
//
public class Job {
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
}

////////////////////////////////////
// Person
//
public class Person {
}

////////////////////////////////////
// Family
//
public class Family {
}
