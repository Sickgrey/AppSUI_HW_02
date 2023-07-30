import XCTest
@testable import UISystem

final class UISystemTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(UISystem().text, "Hello, World!")
    }
}
