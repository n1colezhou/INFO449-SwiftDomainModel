import XCTest
@testable import DomainModel

class MoneyTests: XCTestCase {
  
  let tenUSD = Money(amount: 10, currency: "USD")
  let twelveUSD = Money(amount: 12, currency: "USD")
  let fiveGBP = Money(amount: 5, currency: "GBP")
  let fifteenEUR = Money(amount: 15, currency: "EUR")
  let fifteenCAN = Money(amount: 15, currency: "CAN")
  
  func testCanICreateMoney() {
    let oneUSD = Money(amount: 1, currency: "USD")
    XCTAssert(oneUSD.amount == 1)
    XCTAssert(oneUSD.currency == "USD")
    
    let tenGBP = Money(amount: 10, currency: "GBP")
    XCTAssert(tenGBP.amount == 10)
    XCTAssert(tenGBP.currency == "GBP")
  }
  
  func testUSDtoGBP() {
    let gbp = tenUSD.convert("GBP")
    XCTAssert(gbp.currency == "GBP")
    XCTAssert(gbp.amount == 5)
  }
  func testUSDtoEUR() {
    let eur = tenUSD.convert("EUR")
    XCTAssert(eur.currency == "EUR")
    XCTAssert(eur.amount == 15)
  }
  func testUSDtoCAN() {
    let can = twelveUSD.convert("CAN")
    XCTAssert(can.currency == "CAN")
    XCTAssert(can.amount == 15)
  }
  func testGBPtoUSD() {
    let usd = fiveGBP.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 10)
  }
  func testEURtoUSD() {
    let usd = fifteenEUR.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 10)
  }
  func testCANtoUSD() {
    let usd = fifteenCAN.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 12)
  }
  
  func testUSDtoEURtoUSD() {
    let eur = tenUSD.convert("EUR")
    let usd = eur.convert("USD")
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
  }
  func testUSDtoGBPtoUSD() {
    let gbp = tenUSD.convert("GBP")
    let usd = gbp.convert("USD")
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
  }
  func testUSDtoCANtoUSD() {
    let can = twelveUSD.convert("CAN")
    let usd = can.convert("USD")
    XCTAssert(twelveUSD.amount == usd.amount)
    XCTAssert(twelveUSD.currency == usd.currency)
  }
  
  func testAddUSDtoUSD() {
    let total = tenUSD.add(tenUSD)
    XCTAssert(total.amount == 20)
    XCTAssert(total.currency == "USD")
  }
  
  func testAddUSDtoGBP() {
    let total = tenUSD.add(fiveGBP)
    XCTAssert(total.amount == 10)
    XCTAssert(total.currency == "GBP")
  }
    
// ADDED TESTS FOR EC
    func testInvalidCurrency() {
        let invalidMoney = Money(amount: 10, currency: "XYZ")
        XCTAssert(invalidMoney.currency == "USD", "Money should default to USD if invalid currency is provided")
    }
    
    func testNegativeMoneyAmount() {
        let negativeMoney = Money(amount: -10, currency: "USD")
        XCTAssert(negativeMoney.amount == -10, "Money should accept negative amounts")
    }

    func testMoneyAdditionWithNegativeAmount() {
        let tenUSD = Money(amount: 10, currency: "USD")
        let negativeFiveUSD = Money(amount: -5, currency: "USD")
        
        let total = tenUSD.add(negativeFiveUSD)
        XCTAssert(total.amount == 5, "Money addition with negative amount should result in correct total")
    }

    func testMoneySubtractionWithNegativeAmount() {
        let tenUSD = Money(amount: 10, currency: "USD")
        let negativeFiveUSD = Money(amount: -5, currency: "USD")
        
        let total = tenUSD.subtract(negativeFiveUSD)
        XCTAssert(total.amount == 15, "Money subtraction with negative amount should result in correct total")
    }

    static var allTests = [
        ("testCanICreateMoney", testCanICreateMoney),

        ("testUSDtoGBP", testUSDtoGBP),
        ("testUSDtoEUR", testUSDtoEUR),
        ("testUSDtoCAN", testUSDtoCAN),
        ("testGBPtoUSD", testGBPtoUSD),
        ("testEURtoUSD", testEURtoUSD),
        ("testCANtoUSD", testCANtoUSD),
        ("testUSDtoEURtoUSD", testUSDtoEURtoUSD),
        ("testUSDtoGBPtoUSD", testUSDtoGBPtoUSD),
        ("testUSDtoCANtoUSD", testUSDtoCANtoUSD),
        
        ("testAddUSDtoUSD", testAddUSDtoUSD),
        ("testAddUSDtoGBP", testAddUSDtoGBP),
        ("testInvalidCurrency", testInvalidCurrency),
        ("testNegativeMoneyAmount", testNegativeMoneyAmount),
        ("testMoneyAdditionWithNegativeAmount", testMoneyAdditionWithNegativeAmount),
        ("testMoneySubtractionWithNegativeAmount", testMoneySubtractionWithNegativeAmount)
    ]
}

