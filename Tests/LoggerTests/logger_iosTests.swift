import XCTest
@testable import LoggerKit

final class logger_iosTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let categoryName = "test"
        let logger = Logger(category: categoryName)
        
        XCTAssertEqual(logger.category , categoryName)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
