import XCTest
@testable import SwiftyTranslate

final class SwiftyTranslateTests: XCTestCase {

    func testExample() {
        let resultExpectation = expectation(description: "Result")
        SwiftyTranslate.translate(text: "Hello World", from: "en", to: "de") { result in
            switch result {
            case .success(let translation):
                XCTAssertEqual(translation.translated, "Hallo Welt")
            case .failure(let error):
                print("Error: \(error)")
            }
            resultExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testStringWithLinebreaks() {
        let resultExpectation = expectation(description: "Result")
        SwiftyTranslate.translate(text: "Hello World\nThis is a sentence with\nlinebreaks", from: "en", to: "de") { result in
            switch result {
            case .success(let translation):
                XCTAssertEqual(translation.translated, "Hallo Welt\nDies ist ein Satz mit\nZeilenumbrüche")
            case .failure(let error):
                print("Error: \(error)")
            }
            resultExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    static var allTests = [
        ("testExample", testExample),
        ("testStringWithLinebreaks", testStringWithLinebreaks),
    ]
}
