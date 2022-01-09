//
//  vmoviesTests.swift
//  vmoviesTests
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import XCTest
@testable import vmovies

class vmoviesTests: XCTestCase {

    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {

    }
    
    func testChunkArray() {
        let inputArr: [Int] = Array(1...100)
        let chunkSize: Int = 5
        let chunkedArr: [[Int]] = inputArr.chunked(into: chunkSize)
        chunkedArr.forEach { XCTAssertLessThanOrEqual($0.count, chunkSize) }
    }
    
    func testSafeSubscript() {
        let inputArr: [Int] = Array(1...100)
        XCTAssertNil(inputArr[safe: 200])
        XCTAssertNotNil(inputArr[safe: 50])
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
