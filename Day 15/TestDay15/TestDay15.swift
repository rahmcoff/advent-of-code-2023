//
//  TestDay15.swift
//  TestDay15
//
//  Created by Peter of the Norse on 12/14/23.
//

import XCTest

final class TestDay15: XCTestCase {
    let input = """
    rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
    """

    func testHash() throws {
        XCTAssertEqual(aocHash("HASH"), 52)
    }

    func testPart1() throws {
       XCTAssertEqual(hashSum(input), 1320)
    }

    func testPart2() throws {
        var map = Hashmap.new()
        map.runAllRules(input)
        map.printBoxes()
        
        XCTAssertEqual(map.getFocusingPower(), 145)
    }
}
