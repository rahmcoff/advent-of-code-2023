let gameNumberRegex = /Game (\d+):/
let pullRegex = /(\d+) (.)/

struct Pull: Equatable {
    var r: Int
    var g: Int
    var b: Int
    
    init(r: Int = 0, g: Int = 0, b: Int = 0) {
        self.r = r
        self.g = g
        self.b = b
    }
}

struct Bag: Equatable {
    static func == (lhs: Bag, rhs: Bag) -> Bool {
        lhs.num == rhs.num && lhs.pulls == rhs.pulls
    }
    
    let num: Int
    let pulls: [Pull]
}

func parseGame(_ line: String) -> Bag {
    let numberMatch = try! gameNumberRegex.firstMatch(in: line)
    let num = Int(numberMatch!.1)!
    var pulls: [Pull] = []
    
    for pullStr in line.replacing(gameNumberRegex, with: "").split(separator: "; ") {
        var pull = Pull()

        for match in pullStr.matches(of: pullRegex) {
            switch match.2 {
            case "r":
                pull.r = Int(match.1)!
            case "g":
                pull.g = Int(match.1)!
            case "b":
                pull.b = Int(match.1)!
            default:
                print("problem with match: \(match.0)")
            }
        }
        pulls.append(pull)
    }
    
    return Bag(num: num, pulls: pulls)
}

func possibleBag(_ bag: Bag) -> Bool {
    for p in bag.pulls {
        if p.r > 12 || p.g > 13 || p.b > 14 {
            return false
        }
    }
    return true
}

func bagPower(_ bag: Bag) -> Int {
    let r = bag.pulls.reduce(0, { max($0, $1.r) })
    let g = bag.pulls.reduce(0, { max($0, $1.g) })
    let b = bag.pulls.reduce(0, { max($0, $1.b) })
    return r*g*b
}


import XCTest

class Day2Test: XCTestCase {
    let part1_input = [
        "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
        "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
        "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
        "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
        "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"
    ]
    
    let part1_parsed = [
        Bag(num: 1, pulls: [Pull(r: 4, b: 3), Pull(r: 1, g: 2, b: 6), Pull(g: 2)]),
        Bag(num: 2, pulls: [Pull(g: 2, b: 1), Pull(r: 1, g: 3, b: 4), Pull(g: 1, b: 1)]),
        Bag(num: 3, pulls: [Pull(r: 20, g: 8, b: 6), Pull(r: 4, g: 13, b: 5), Pull(r:1, g: 5)]),
        Bag(num: 4, pulls: [Pull(r: 3, g: 1, b: 6), Pull(r: 6, g: 3, b: 0), Pull(r: 14, g: 3, b: 15)]),
        Bag(num: 5, pulls: [Pull(r: 6, g: 3, b: 1), Pull(r: 1, g: 2, b: 2)]),
    ]
    
    let part1_possible = [
        1: true,
        2: true,
        3: false,
        4: false,
        5: true
    ]
    
    let part2_power = [
        1: 48,
        2: 12,
        3: 1560,
        4: 630,
        5: 36
    ]
    
    
    func testParse() {
        for (i, input) in part1_input.enumerated() {
            XCTAssertEqual(parseGame(input), part1_parsed[i])
        }
    }
    
    func testPart1() {
        for bag in part1_parsed {
            XCTAssertEqual(possibleBag(bag), part1_possible[bag.num], "bag num \(bag.num) failed ")
        }
    }
    
    func testPart2() {
        for bag in part1_parsed {
            XCTAssertEqual(bagPower(bag), part2_power[bag.num])
        }
    }
}

Day2Test.defaultTestSuite.run()

let bags = getLines().map(parseGame)
print(bags.filter(possibleBag).reduce(0, { $0 + $1.num }))
print(bags.reduce(0, { $0 + bagPower($1) }))
