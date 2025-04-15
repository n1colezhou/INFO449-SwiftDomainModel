struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    var amount: Int
    var currency: String

    public init(amount: Int, currency: String) {
        let validCurrencies = ["USD", "GBP", "EUR", "CAN"]
        if validCurrencies.contains(currency) {
            self.amount = amount
            self.currency = currency
        } else {
            self.amount = amount
            self.currency = "USD"
        }
    }
    
    public func convert(_ targetCurrency: String) -> Money {
        let usdAmount: Double
        switch currency {
        case "USD":
            usdAmount = Double(amount)
        case "GBP":
            usdAmount = Double(amount) * 2 // 1 USD = 0.5 GBP
        case "EUR":
            usdAmount = Double(amount) * 2 / 3 // 1 USD = 1.5 EUR
        case "CAN":
            usdAmount = Double(amount) * 4 / 5 // 1 USD = 1.25 CAN
        default:
            usdAmount = 0
        }
        
        let targetAmount: Int
        switch targetCurrency {
        case "USD":
            targetAmount = Int(usdAmount)
        case "GBP":
            targetAmount = Int(usdAmount / 2)
        case "EUR":
            targetAmount = Int(usdAmount * 3 / 2)
        case "CAN":
            targetAmount = Int(usdAmount * 5 / 4)
        default:
            targetAmount = 0
        }
        
        return Money(amount: targetAmount, currency: targetCurrency)
    }
    
    public func add(_ other: Money) -> Money {
        // Convert both to the same currency (USD), then add
        let selfInUSD = self.convert("USD").amount
        let otherInUSD = other.convert("USD").amount
        let totalInUSD = selfInUSD + otherInUSD
        
        return Money(amount: totalInUSD, currency: other.currency)
    }
    
    public func subtract(_ other: Money) -> Money {
        let selfInUSD = self.convert("USD").amount
        let otherInUSD = other.convert("USD").amount
        let totalInUSD = selfInUSD - otherInUSD
        
        return Money(amount: totalInUSD, currency: other.currency)
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
    
    var title: String
    var type: JobType
    
    public init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }
    
    public var description: String {
        switch type {
        case .Hourly(let wage):
            return "\(title): Hourly job at \(wage) per hour"
        case .Salary(let salary):
            return "\(title): Salary job at \(salary) annually"
        }
    }
    
    public func calculateIncome(_ hoursWorked: Int) -> Int {
        switch type {
        case .Hourly(let wage):
            return Int(wage * Double(hoursWorked)) // Income for hourly jobs
        case .Salary(let salary):
            return Int(salary) // Income for salary jobs (fixed amount)
        }
    }

    public func raise(byAmount amount: Double) {
        switch type {
        case .Hourly(let wage):
            self.type = .Hourly(wage + amount) // Increase hourly wage
        case .Salary(let salary):
            self.type = .Salary(salary + UInt(amount)) // Increase salary
        }
    }

    public func raise(byPercent percent: Double) {
        switch type {
        case .Hourly(let wage):
            let newWage = wage * (1 + percent) // Increase hourly wage by percentage
            self.type = .Hourly(newWage)
        case .Salary(let salary):
            let newSalary = UInt(Double(salary) * (1 + percent)) // Increase salary by percentage
            self.type = .Salary(newSalary)
        }
    }
}

////////////////////////////////////
// Person
//
public class Person {
    
    var firstName: String
    var lastName: String
    var age: Int
    var _job: Job?
    var _spouse: Person?
    
    public init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self._job = nil
        self._spouse = nil
    }
    
    public func toString() -> String {
        let jobDescription = job?.description ?? "nil"
        let spouseDescription = spouse?.toString() ?? "nil"
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(jobDescription) spouse:\(spouseDescription)]"
    }
    
    public var job: Job? {
        get { return _job }
        set {
            if let _ = newValue, age < 18 {
                _job = nil
            } else {
                _job = newValue
            }
        }
    }
    
    public var spouse: Person? {
        get { return _spouse }
        set {
            if let _ = newValue, age < 18 {
                _spouse = nil
            } else {
                _spouse = newValue
            }
        }
    }
}

////////////////////////////////////
// Family
//
public class Family {
    var spouse1: Person
    var spouse2: Person
    var members: [Person]

    public init(spouse1: Person, spouse2: Person) {
        self.spouse1 = spouse1
        self.spouse2 = spouse2
        self.members = [spouse1, spouse2]
    }

    public func haveChild(_ child: Person) -> Person {
        members.append(child)
        return child
    }
    
    public func householdIncome() -> Int {
        var totalIncome = 0
        
        for member in members {
            if member.age >= 18, let job = member.job {
                totalIncome += job.calculateIncome(2000)
            }
        }
        
        return totalIncome
    }
}
