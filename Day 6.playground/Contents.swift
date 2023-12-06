func parseRaces(_ input: String) -> [Int: Int] {
    var times: [Int] = []
    var distances: [Int] = []
    for line in input.split(separator: "\n") {
        if line.hasPrefix("Time:") {
            times = input[input.index(line.startIndex, offsetBy: 9)..<line.endIndex].split(separator: " ", omittingEmptySubsequences: true).map({ Int($0)! })
        }
        if line.hasPrefix("Distance:") {
            distances = input[input.index(line.startIndex, offsetBy: 9)..<line.endIndex].split(separator: " ", omittingEmptySubsequences: true).map({ Int($0)! })
        }
    }
    var races = [Int: Int]()
    for (index, time) in times.enumerated() {
        races[time] = distances[index]
    }
    return races
}

func numOfWins(_ time: Int, _ distance: Int) -> Int {
    let time = Double(time)
    let distance = Double(distance)
    
    let smallRoot = (time - sqrt(time*time - 4 * distance))/2
    let bigRoot = (time + sqrt(time*time - 4 * distance))/2
    
    return Int(ceil(bigRoot) - floor(smallRoot) - 1)
}

func stupidParse(_ input: String) -> (Int, Int) {
    var time = 0
    var distance = 0
    
    for line in input.split(separator: "\n") {
        if line.hasPrefix("Time:") {
            time = Int(input[input.index(line.startIndex, offsetBy: 9)..<line.endIndex].replacing(" ", with: ""))!
        }
        if line.hasPrefix("Distance:") {
            distance = Int(input[input.index(line.startIndex, offsetBy: 9)..<line.endIndex].replacing(" ", with: ""))!
        }
    }
    return (time, distance)
}

import XCTest

class TestDay6: XCTestCase {
    let input = """
    Time:      7  15   30
    Distance:  9  40  200
    """
    
    let races = [
        7: 9,
        15: 40,
        30: 200
    ]
    
    let numberOfWins = [
        7: 4,
        15: 8,
        30: 9
    ]
    
    func testParse() {
        XCTAssertEqual(parseRaces(input), races)
    }
    
    func testNumberOfWins() {
        for (time, distance) in races {
            XCTAssertEqual(numOfWins(time, distance), numberOfWins[time])
        }
    }
    
    let stupidTime = 71530
    let stupidDistance = 940200
    
    func testStupidParse() {
        let (testTime, testDistance) = stupidParse(input)
        XCTAssertEqual(testTime, stupidTime)
        XCTAssertEqual(testDistance, stupidDistance)
        
        XCTAssertEqual(numOfWins(testTime, testDistance), 71503)
    }
}

TestDay6.defaultTestSuite.run()

let input = getInput()
let races = parseRaces(input)
var totalWins = 1
for (time, distance) in races {
    totalWins *= numOfWins(time, distance)
}

print("\(totalWins)")

let (time, distance) = stupidParse(input)
print("\(numOfWins(time, distance))")
