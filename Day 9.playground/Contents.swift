func nextNumber(_ line: String) -> (Int, Int) {
    let initialSequence = line.split(separator: " ").map{ Int($0)! }
    var sequences: [[Int]] = []
    var workingSequence = initialSequence
    
    while !workingSequence.filter({ $0 != 0 }).isEmpty {
        var nextSequence = [Int]()
        for idx in 1..<workingSequence.count {
            nextSequence.append(workingSequence[idx] - workingSequence[idx-1])
        }
        sequences.append(workingSequence)
        workingSequence = nextSequence
    }
    
    var rightNumber = 0
    var leftNumber = 0
    for sequence in sequences.reversed() {
        let lastNumber = sequence.last!
        rightNumber += lastNumber
        
        let firstNumber = sequence.first!
        leftNumber = firstNumber - leftNumber
    }
    return (leftNumber, rightNumber)
}

import XCTest

class TestDay9: XCTestCase {
    let input = """
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
    """.split(separator: "\n").map{ String($0) }
    
    let part1Solutions = [
        (-3, 18),
        (0, 28),
        (5, 68),
    ]
    
    func testPart1() {
        for (index, line) in input.enumerated() {
            let numbers = nextNumber(line)
            XCTAssertEqual(numbers.0, part1Solutions[index].0)
            XCTAssertEqual(numbers.1, part1Solutions[index].1)
        }
    }
    
}

TestDay9.defaultTestSuite.run()

let input = getLines()
let numbers = input.map(nextNumber).reduce((0, 0), { ($0.0 + $1.0, $0.1 + $1.1) })
print("start: \(numbers.0) end: \(numbers.1)")
