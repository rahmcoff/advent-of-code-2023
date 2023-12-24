//
//  TestDay23.swift
//  TestDay23
//
//  Created by Peter of the Norse on 12/22/23.
//

import XCTest

final class TestDay23: XCTestCase {
    let input = """
    #.#####################
    #.......#########...###
    #######.#########.#.###
    ###.....#.>.>.###.#.###
    ###v#####.#v#.###.#.###
    ###.>...#.#.#.....#...#
    ###v###.#.#.#########.#
    ###...#.#.#.......#...#
    #####.#.#.#######.#.###
    #.....#.#.#.......#...#
    #.#####.#.#.#########v#
    #.#...#...#...###...>.#
    #.#.#v#######v###.###v#
    #...#.>.#...>.>.#.###.#
    #####v#.#.###v#.#.###.#
    #.....#...#...#.#.#...#
    #.#########.###.#.#.###
    #...###...#...#...#.###
    ###.###.#.###v#####v###
    #...#...#.#.>.>.#.>.###
    #.###.###.#.###.#.#v###
    #.....###...###...#...#
    #####################.#
    """
    
    func testPart1() throws {
        let maze = Maze(input)
        let distances = maze.findPathDistances()
        print(distances)
        XCTAssertEqual(distances.max(), 94)
    }

    func testPart2() throws {
        let maze = Maze(input)
        XCTAssertEqual(maze.findDryDistance(), 154)
    }

}
