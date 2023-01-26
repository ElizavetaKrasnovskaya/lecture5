import XCTest
@testable import lecture5

final class InfoViewModelTest: XCTestCase {
    
    var viewModel: InfoViewModel!
    var databaseService: DatabaseService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = InfoViewModel.shared
        databaseService = DatabaseService.shared
    }

    override func tearDownWithError() throws {
        viewModel = nil
        databaseService = nil
        try super.tearDownWithError()
    }

    func testBuyBeerWithSuccess() throws {
        let beer = Beer(name: "name", country: "country", cost: 10, volume: 10)
        let volume = 2.0
        let price = 20.0
        let totalSelled = databaseService.getSelled() + 2.0
        let earnings = databaseService.getEarnings() + 20.0
        
        let testedPrice = viewModel.buyBeer(with: beer, value: volume)
        let testedSelled = databaseService.getSelled()
        let testedEarnings = databaseService.getEarnings()
        
        XCTAssertEqual(testedPrice, price)
        XCTAssertEqual(testedSelled, totalSelled)
        XCTAssertEqual(testedEarnings, earnings)
    }
    
    func testRound() throws {
        let number = 42.00003
        let result = 42.0
        
        let testedResult = viewModel.round(number)
        
        XCTAssertEqual(testedResult, result)
    }

    func testPerformanceExample() throws {
        let beer = Beer(name: "name", country: "country", cost: 10, volume: 10)
        let volume = 2.0
        measure {
            viewModel.buyBeer(with: beer, value: volume)
        }
    }
}
