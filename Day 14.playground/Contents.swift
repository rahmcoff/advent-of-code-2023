enum Rock: Character {
    case round = "O"
    case square = "#"
    case empty = "."
}

typealias Field = [[Rock]]

extension Field {
    var description: String {
        self.map({ String($0.map({ $0.rawValue })) }).joined(separator: "\n")
    }
    
    mutating func tiltNorth() -> Self {
        let width = self.first!.count
        var nextAvailable = [Int](repeating: 0, count: width)
        
        for row in 0..<self.count {
            for col in 0..<width {
                switch self[row][col] {
                case .empty:
                    continue
                case .square:
                    nextAvailable[col] = row+1
                case .round:
                    let available = nextAvailable[col]
                    self[row][col] = .empty
                    self[available][col] = .round
                    nextAvailable[col] = available + 1
                }
            }
        }
        return self
    }

    mutating func tiltSouth() -> Self {
        var nextSouth = [Int](repeating: self.count-1, count: self.first!.count)
        
        for (row, line) in self.enumerated().reversed() {
            for (col, rock) in line.enumerated().reversed() {
                switch rock {
                case .empty:
                    continue
                case .square:
                    nextSouth[col] = row-1
                case .round:
                    let southRow = nextSouth[col]
                    self[row][col] = .empty
                    self[southRow][col] = .round
                    nextSouth[col] = southRow - 1
                }
            }
        }
        return self
    }

    mutating func tiltWest() -> Self {
        var nextWest = [Int](repeating: 0, count: self.count)
        
        for (row, line) in self.enumerated() {
            for (col, rock) in line.enumerated() {
                switch rock {
                case .empty:
                    continue
                case .square:
                    nextWest[row] = col + 1
                case .round:
                    let westCol = nextWest[row]
                    self[row][col] = .empty
                    self[row][westCol] = .round
                    nextWest[row] = westCol + 1
                }
            }
        }

        return self
    }

    mutating func tiltEast() -> Self {
        var nextEast = [Int](repeating: self.first!.count-1, count: self.count)
        
        for (row, line) in self.enumerated() {
            for (col, rock) in line.enumerated().reversed() {
                switch rock {
                case .empty:
                    continue
                case .square:
                    nextEast[row] = col - 1
                case .round:
                    let eastCol = nextEast[row]
                    self[row][col] = .empty
                    self[row][eastCol] = .round
                    nextEast[row] = eastCol - 1
                }
            }
        }

        return self
    }

}

func parseField(_ input: String) -> Field {
    var field = Field()
    
    let lines = input.split(separator: "\n")
    for line in lines {
        field.append(line.map({ Rock(rawValue: $0)! }))
    }
    
    return field
}





func northLoad(_ field: Field) -> Int {
    var load = 0
    for (row, line) in field.enumerated() {
        load += line.filter({ $0 == .round }).count * (field.count - row)
    }
    return load
}

import XCTest

class TestDay14: XCTestCase {
    let startInput = """
    O....#....
    O.OO#....#
    .....##...
    OO.#O....O
    .O.....O#.
    O.#..O.#.#
    ..O..#O..O
    .......O..
    #....###..
    #OO..#....
    """
    
    let finishInput = """
    OOOO.#.O..
    OO..#....#
    OO..O##..O
    O..#.OO...
    ........#.
    ..#....#.#
    ..O..#.O.O
    ..O.......
    #....###..
    #....#....
    """
    
    func testTiltNorth() {
        var start = parseField(startInput)
        var finish = parseField(finishInput)
        start.tiltNorth()
        XCTAssertEqual(start, finish)
    }
    
    func testLoad() {
        let field = parseField(finishInput)
        XCTAssertEqual(northLoad(field), 136)
    }
    
    let final3Spins = """
    .....#....
    ....#...O#
    .....##...
    ..O#......
    .....OOO#.
    .O#...O#.#
    ....O#...O
    .......OOO
    #...O###.O
    #.OOO#...O
    """
    
    func test3Spins() {
        var field = parseField(startInput)
        for rep in 0..<3 {
            field.tiltNorth()
            field.tiltWest()
            field.tiltSouth()
            field.tiltEast()
            print(field.description)
            print()
        }
        XCTAssertEqual(field.description, final3Spins)
    }
}

TestDay14.defaultTestSuite.run()


let clock = ContinuousClock()

var start = parseField(getInput())

let time1 = clock.measure {
    start.tiltNorth()
    let load = northLoad(start)
    
    print(load)
}

print(time1)

let timeBillion = clock.measure {
    var currentState: Field = parseField(getInput())
    var loopCheck = [String: Int]()
    var loopStart = 0
    var loopEnd = 0
    
    for rep in 0..<100000 {
        currentState.tiltNorth()
        currentState.tiltWest()
        currentState.tiltSouth()
        currentState.tiltEast()
        let desc = currentState.description
        if let previousLoop = loopCheck[desc] {
            print("We have a loop! \(previousLoop) is the same as \(rep)")
            loopStart = previousLoop
            loopEnd = rep
            break
        } else {
            loopCheck[desc] = rep
        }
    }
    
    let necessaryLoops = (1000000000 - loopStart) % (loopEnd - loopStart) + loopStart
    
    currentState = parseField(getInput())
    for _ in 0..<necessaryLoops {
        currentState.tiltNorth()
        currentState.tiltWest()
        currentState.tiltSouth()
        currentState.tiltEast()
    }
    print(northLoad(currentState))
}
print(timeBillion)
