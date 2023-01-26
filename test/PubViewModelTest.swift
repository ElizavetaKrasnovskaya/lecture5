import XCTest
@testable import lecture5

final class PubViewModelTest: XCTestCase {

    var viewModel: PubViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = PubViewModel.shared
    }

    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }
    
    func testGetInfo() throws {
        let earnings = 0.0
        let totalSelled = 0.0
        
        viewModel.updateForNewDay()
        viewModel.getInfo()
        
        XCTAssertEqual(viewModel.totalSelled, totalSelled)
        XCTAssertEqual(viewModel.earnings, earnings)
    }

    func testUpdateForNewDay() throws {
        let earnings = 0.0
        let totalSelled = 0.0
        
        viewModel.updateForNewDay()
        
        XCTAssertEqual(viewModel.earnings, earnings)
        XCTAssertEqual(viewModel.totalSelled, totalSelled)
    }

    func testPerformanceExample() throws {
        self.measure {
            viewModel.updateForNewDay()
        }
    }

}
