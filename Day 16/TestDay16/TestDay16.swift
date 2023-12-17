//
//  TestDay16.swift
//  TestDay16
//
//  Created by Peter of the Norse on 12/16/23.
//

import XCTest

final class TestDay16: XCTestCase {
    let input = #"""
    .|...\....
    |.-.\.....
    .....|-...
    ........|.
    ..........
    .........\
    ..../.\\..
    .-.-/..|..
    .|....-|.\
    ..//.|....
    """#
    
    func testPart1() throws {
        let map = BeamMap(input: input)
        map.runBeams()
        XCTAssertEqual(map.litTiles, 46)
    }

    func testPart2() throws {
        let map = BeamMap(input: input)
        map.runBeams(start: Beam(r: 0, c: 3, d: .south))
        XCTAssertEqual(map.litTiles, 51)
    }
    
    func testPart2Performance() {
        measure {
            let map = BeamMap(input: input)
            XCTAssertEqual(map.findMaxStart(), 51)
        }
    }

}
