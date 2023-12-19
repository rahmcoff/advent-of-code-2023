//
//  TestDay18.swift
//  TestDay18
//
//  Created by Peter of the Norse on 12/17/23.
//

import XCTest

final class TestDay18: XCTestCase {
    let input = """
    R 6 (#70c710)
    D 5 (#0dc571)
    L 2 (#5713f0)
    D 2 (#d2c081)
    R 2 (#59c680)
    D 2 (#411b91)
    L 5 (#8ceee2)
    U 2 (#caa173)
    L 1 (#1b58a2)
    U 2 (#caa171)
    R 2 (#7807d2)
    U 3 (#a77fa3)
    L 2 (#015232)
    U 2 (#7a21e3)
    """.split(separator: "\n").map({ String($0) })
    
    let inputCross = """
    R 2
    D 1
    R 2
    U 1
    R 2
    D 3
    L 6
    U 3
    """.split(separator: "\n").map{ String($0) }
    
    func testPart1() throws {
        let polygon = DigPolygon(input: input)
        XCTAssertEqual(polygon.interiorSize(), 62)
    }
    
    func testPart2() {
        let polygon = DigPolygon(input: input, parseHex: true)
        XCTAssertEqual(polygon.interiorSize(), 952408144115)
    }
    
    func testJoin() {
        let polygon = DigPolygon(input: inputCross)
        XCTAssertEqual(polygon.interiorSize(), 27)
    }
}
