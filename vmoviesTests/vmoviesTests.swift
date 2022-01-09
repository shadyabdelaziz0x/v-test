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

    func testSavingImagePerformance() throws {
        guard let image = R.image.placeholderImage(), let imageData = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return
        }
        let imageName: String = "testImage"
        self.measure {
            LocalStorageManager.shared.saveImage(imageData: imageData, with: imageName)
        }
    }

}
