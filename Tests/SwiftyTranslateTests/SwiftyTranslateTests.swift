import XCTest
@testable import SwiftyTranslate

final class SwiftyTranslateTests: XCTestCase {

    func testExample() {
        let resultExpectation = expectation(description: "Result")
        SwiftyTranslate.translate(text: "Hello World", from: "en", to: "de") { result in
            switch result {
            case .success(let translation):
                print("Translated: \(translation.translated)")
            case .failure(let error):
                print("Error: \(error)")
            }
            resultExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
