import RegexBuilder

let map = [
    "one": "1",
    "eno": "1",
    "two": "2",
    "owt": "2",
    "three": "3",
    "eerht": "3",
    "four": "4",
    "ruof": "4",
    "five": "5",
    "evif": "5",
    "six": "6",
    "xis": "6",
    "seven": "7",
    "neves": "7",
    "eight": "8",
    "thgie": "8",
    "nine": "9",
    "enin": "9"
]

let digits = Regex {
        ChoiceOf {
            "one"
            "two"
            "three"
            "four"
            "five"
            "six"
            "seven"
            "eight"
            "nine"
            "1"
            "2"
            "3"
            "4"
            "5"
            "6"
            "7"
            "8"
            "9"
            "0"
        }
}
let reversedDigits = Regex {
        ChoiceOf {
            "eno"
            "owt"
            "eerht"
            "ruof"
            "evif"
            "xis"
            "neves"
            "thgie"
            "enin"
            "1"
            "2"
            "3"
            "4"
            "5"
            "6"
            "7"
            "8"
            "9"
            "0"
        }
}


func getnumberFromLine(_ line: String) -> Int {
    let firstDigit = try! digits.firstMatch(in: line)!.0.lowercased()
    let lastDigit = try! reversedDigits.firstMatch(in: String(line.reversed()))!.0.lowercased()
    debugPrint(firstDigit, lastDigit)
    return Int("\(map[firstDigit] ?? firstDigit)\(map[lastDigit] ?? lastDigit)")!
}

import XCTest

class Day1Test: XCTestCase {
    let part1 = [
        "1abc2",
        "pqr3stu8vwx",
        "a1b2c3d4e5f",
        "treb7uchet",
    ]
    
    let part1_result = [
        12,
        38,
        15,
        77
    ]
    
    func testPart1() {
        for (i, line) in part1.enumerated() {
            XCTAssertEqual(getnumberFromLine(line), part1_result[i])
        }
    }
    
    let part2 = [
        "two1nine",
        "eightwothree",
        "abcone2threexyz",
        "xtwone3four",
        "4nineeightseven2",
        "zoneight234",
        "7pqrstsixteen",
        "oneight"
    ]
    
    let part2_result = [
        29, 
        83,
        13,
        24,
        42,
        14,
        76,
        18
    ]
    
    func testPart2() {
        for (i, line) in part2.enumerated() {
            XCTAssertEqual(getnumberFromLine(line), part2_result[i])
        }
    }
}

Day1Test.defaultTestSuite.run()


let sum = getLines()
    .map(getnumberFromLine)
            .reduce(0, +)
