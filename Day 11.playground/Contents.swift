struct Galaxy {
    var r: Int
    var c: Int
}

func getGalaxies(map: String, expansion: Int = 2) -> [Galaxy] {
    var galaxies = [Galaxy]()
    var maxRow = 0
    var maxCol = 0
    
    for (row, line) in map.split(separator: "\n").enumerated() {
        for (col, letter) in line.enumerated() {
            if letter == "#" {
                galaxies.append(Galaxy(r: row, c: col))
                maxCol = max(maxCol, col)
                maxRow = row
            }
        }
    }
    
    // Now for expanion
    for r in (1..<maxRow).reversed() {
        if galaxies.filter({ $0.r == r }).isEmpty {
//            print("expanding row \(r)")
            for index in galaxies.indices {
                var galaxy = galaxies[index]
                if galaxy.r > r {
                    galaxy.r += expansion - 1
                    galaxies[index] = galaxy
                }
            }
        }
    }
    for c in (1..<maxCol).reversed() {
        if galaxies.filter({ $0.c == c }).isEmpty {
//            print("expanding col \(c)")
            for index in galaxies.indices {
                var galaxy = galaxies[index]
                if galaxy.c > c {
                    galaxy.c += expansion - 1
                    galaxies[index] = galaxy
                }
            }
        }
    }

    return galaxies
}

func getDistances(galaxies: [Galaxy]) -> Int {
    var totalDistance = 0
    
    for (index, galaxy) in galaxies.enumerated() {
        for otherGalaxy in galaxies[0..<index] {
            totalDistance += abs(galaxy.c - otherGalaxy.c) + abs(galaxy.r - otherGalaxy.r)
        }
    }
    
    return totalDistance
}

import XCTest

class TestDay11: XCTestCase {
    let input = """
    ...#......
    .......#..
    #.........
    ..........
    ......#...
    .#........
    .........#
    ..........
    .......#..
    #...#.....
    """
    
    func testPart1() {
        let galaxies = getGalaxies(map: input)
        XCTAssertEqual(getDistances(galaxies: galaxies), 374)
    }
    
    func testPart2() {
        let galaxies = getGalaxies(map: input, expansion: 10)
        print(galaxies)
        XCTAssertEqual(getDistances(galaxies: galaxies), 1030)
    }
    
    func testPart2_100() {
        let galaxies = getGalaxies(map: input, expansion: 100)
        XCTAssertEqual(getDistances(galaxies: galaxies), 8410)
    }
}

TestDay11.defaultTestSuite.run()


let galaxies = getGalaxies(map: getInput(), expansion: 1000000)
print(getDistances(galaxies: galaxies))
