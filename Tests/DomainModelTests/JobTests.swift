import XCTest
@testable import DomainModel

class JobTests: XCTestCase {
  
    func testCreateSalaryJob() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.calculateIncome(50) == 1000)
        XCTAssert(job.calculateIncome(100) == 1000)
        // Salary jobs pay the same no matter how many hours you work
    }

    func testCreateHourlyJob() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.calculateIncome(10) == 150)
        XCTAssert(job.calculateIncome(20) == 300)
    }

    func testSalariedRaise() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.calculateIncome(50) == 1000)

        job.raise(byAmount: 1000)
        XCTAssert(job.calculateIncome(50) == 2000)

        job.raise(byPercent: 0.1)
        XCTAssert(job.calculateIncome(50) == 2200)
    }

    func testHourlyRaise() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.calculateIncome(10) == 150)

        job.raise(byAmount: 1.0)
        XCTAssert(job.calculateIncome(10) == 160)

        job.raise(byPercent: 1.0) // Nice raise, bruh
        XCTAssert(job.calculateIncome(10) == 320)
    }
    
// ADDED TESTS FOR EC
    func testNegativeHourlyJob() {
        let negativeHourlyJob = Job(title: "Cleaner", type: Job.JobType.Hourly(-10.0))
        XCTAssert(negativeHourlyJob.calculateIncome(10) == -100, "Hourly job should accept negative wages but handle them correctly")
    }

    func testRaiseWithNegativeAmount() {
        let job = Job(title: "Cleaner", type: Job.JobType.Hourly(10.0))
        job.raise(byAmount: -5)
        XCTAssert(job.calculateIncome(10) == 50, "Job raise with negative amount should be handled properly")
    }

    func testRaiseWithNegativePercent() {
        let job = Job(title: "Developer", type: Job.JobType.Salary(3000))
        job.raise(byPercent: -0.1)
        XCTAssert(job.calculateIncome(40) == 2700, "Job raise with negative percentage should be handled properly")
    }
  
    static var allTests = [
        ("testCreateSalaryJob", testCreateSalaryJob),
        ("testCreateHourlyJob", testCreateHourlyJob),
        ("testSalariedRaise", testSalariedRaise),
        ("testHourlyRaise", testHourlyRaise),
        ("testNegativeHourlyJob", testNegativeHourlyJob),
        ("testRaiseWithNegativeAmount", testRaiseWithNegativeAmount),
        ("testRaiseWithNegativePercent", testRaiseWithNegativePercent)
    ]
}
