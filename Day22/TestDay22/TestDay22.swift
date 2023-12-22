//
//  TestDay22.swift
//  TestDay22
//
//  Created by Peter of the Norse on 12/21/23.
//

import XCTest

final class TestDay22: XCTestCase {
    let input = """
    1,0,1~1,2,1
    0,0,2~2,0,2
    0,2,3~2,2,3
    0,0,4~0,2,4
    2,0,5~2,2,5
    0,1,6~2,1,6
    1,1,8~1,1,9
    """
    
    func testExample() throws {
        var pile = Pile(input)
        pile.fall()
        XCTAssertEqual(pile.countRedundant(), 5)
    }

    func testPerformanceExample() throws {
        var pile = Pile(input)
        pile.fall()
        XCTAssertEqual(pile.getCascadeCount(), 7)
    }

}
