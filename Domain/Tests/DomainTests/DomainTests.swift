import XCTest
@testable import Domain
@testable import Entities

final class DomainTests: XCTestCase {
    var words: [String]!
    var sut: TopKWordsUseCase!

    override func setUp() {
        sut = TopKWordsUseCase()
    }
    
    func testTopThreeFrequentWords() {
        
        words = ["ankara", "istanbul", "istanbul", "izmir", "ankara", "ankara", "ankara", "istanbul", "izmir", "antalya"]
        let exp = expectation(description: "testTop3")
        
        sut.execute(TopKWordsUseCase.Request(k: 3, items: words)) { (result) in
            switch result{
            case .success(let model):
                XCTAssertEqual(model.items[0], "ankara 4")
                XCTAssertEqual(model.items[1], "istanbul 3")
                XCTAssertEqual(model.items[2], "izmir 2")
            default:
                break
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testEmptyCase() {
        words = ["van"]

        let exp = expectation(description: "testEmptyCase")
        
        sut.execute(TopKWordsUseCase.Request(k: 3, items: words)) { (result) in
            switch result{
            case .failure(let error as TopKError):
                XCTAssertEqual(error, TopKError.empty)
            default:
                break
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    override func tearDown() {
        sut = nil
        words = nil
        super.tearDown()
    }
}
