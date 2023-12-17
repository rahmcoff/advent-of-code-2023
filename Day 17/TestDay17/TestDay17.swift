//
//  TestDay17.swift
//  TestDay17
//
//  Created by Peter of the Norse on 12/16/23.
//

import XCTest

final class TestDay17: XCTestCase {

    let input = """
    2413432311323
    3215453535623
    3255245654254
    3446585845452
    4546657867536
    1438598798454
    4457876987766
    3637877979653
    4654967986887
    4564679986453
    1224686865563
    2546548887735
    4322674655533
    """

    func testPart1() throws {
        let blocks = City(input: input)
        let path = blocks.findShortestPath()
        XCTAssertEqual(path, 102)
    }
    
    let input2 = """
    111111111111
    999999999991
    999999999991
    999999999991
    999999999991
    """
    
    func testPart2() {
        let city1 = City(input: input)
        XCTAssertEqual(city1.findShortestPath(ultra: true), 94)
        let city2 = City(input: input2)
        XCTAssertEqual(city2.findShortestPath(ultra: true), 71)
    }
}
