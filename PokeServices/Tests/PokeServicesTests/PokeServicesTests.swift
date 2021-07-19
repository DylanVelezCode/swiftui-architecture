import XCTest
@testable import PokeServices

final class PokeServicesTests: XCTestCase {
    func testExample() throws {
        let service = LocalPokeService()
        var count = 0
        let exp = expectation(description: "expect 9 results")
        service.getPokemonList().sink(receiveCompletion: {
            if case .failure = $0 {
                XCTFail()
            }
        }, receiveValue: {
            count = $0.count
            exp.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertEqual(count, 9)
    }
}
