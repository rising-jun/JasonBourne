import XCTest
import JasonBourne

class Tests: XCTestCase {
    
    var bourne: Bourne!
    
    func test_Bourne일때_request가_호출되면_성공하고_Data를_반환하여_modelData를_업데이트한다() throws {
        //give
        bourne = Bourne(stubMode: .immediately)
        var testResult = false
        var modelData: Data?
        let didFinish = expectation(description: #function)

        //when
        bourne.request(api: NewsAPI.topHeadlines) { result in
            switch result {
            case .success(let responseData):
                testResult = true
                modelData = responseData
                didFinish.fulfill()
            case .failure(let error):
                testResult = false
                didFinish.fulfill()
            }
        }
        
        wait(for: [didFinish], timeout: 1.0)
        
        //then
        XCTAssertTrue(testResult)
        XCTAssertNotNil(modelData)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
