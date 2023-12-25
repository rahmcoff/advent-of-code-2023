//
//  TestDay24.swift
//  TestDay24
//
//  Created by Peter of the Norse on 12/23/23.
//

import XCTest

final class TestDay24: XCTestCase {

    let input = """
    19, 13, 30 @ -2, 1, -2
    18, 19, 22 @ -1, -1, -2
    20, 25, 34 @ -2, -2, -4
    12, 31, 28 @ -1, -2, -1
    20, 19, 15 @ 1, -5, -3
    """
    
    func testExample() throws {
        let storm = Hailstorm(input)
        let collisions = storm.futureFlatCollisions(from: 7, to: 27)
        XCTAssertEqual(collisions, 2)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
