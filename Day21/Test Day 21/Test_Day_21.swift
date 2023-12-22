//
//  Test_Day_21.swift
//  Test Day 21
//
//  Created by Peter of the Norse on 12/20/23.
//

import XCTest

final class Test_Day_21: XCTestCase {
    let input = """
    ...........
    .....###.#.
    .###.##..#.
    ..#.#...#..
    ....#.#....
    .##..S####.
    .##..#...#.
    .......##..
    .##.#.####.
    .##..##.##.
    ...........
    """

    func testPart1() throws {
        let g = Garden(input)
        g.findDistances(max: 6)
        XCTAssertEqual(g.countEvenDistances(), 16)
    }

}
