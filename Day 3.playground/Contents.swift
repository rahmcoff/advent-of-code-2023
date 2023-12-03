import RegexBuilder

struct Num {
    let number: String
    let row: Int
    let start: Int
    let end: Int
}

let numPattern = /\d+/
let symbolPattern = Regex {
    CharacterClass(
        .anyOf("."),
        .digit
    )
    .inverted
}


func findNumbers(_ input: [String]) -> [Int] {
    var numMatches = [Num]()
    var symMatches = [Num]()
    
    for (row, line) in input.enumerated() {
        for match in line.matches(of: numPattern) {
            numMatches.append(Num(number: String(match.0), row: row, start: match.range.lowerBound.utf16Offset(in: line), end: match.range.upperBound.utf16Offset(in: line)))
        }
        for match in line.matches(of: symbolPattern) {
            symMatches.append(Num(number: String(match.0), row: row, start: match.range.lowerBound.utf16Offset(in: line), end: match.range.upperBound.utf16Offset(in: line)))
        }
    }
    
    var partNumbers = [Int]()
    for num in numMatches {
        let rowRange = num.row-1...num.row+1
        let colRange = num.start-1...num.end
        if symMatches.contains(where: { rowRange.contains($0.row) && colRange.contains($0.start) }) {
            partNumbers.append(Int(num.number)!)
        }
    }
    return partNumbers
}


func findGears(_ input: [String]) -> [Int] {
    var numMatches = [Num]()
    var symMatches = [Num]()
    
    for (row, line) in input.enumerated() {
        for match in line.matches(of: numPattern) {
            numMatches.append(Num(number: String(match.0), row: row, start: match.range.lowerBound.utf16Offset(in: line), end: match.range.upperBound.utf16Offset(in: line)))
        }
        for match in line.matches(of: /\*/) {
            symMatches.append(Num(number: String(match.0), row: row, start: match.range.lowerBound.utf16Offset(in: line), end: match.range.upperBound.utf16Offset(in: line)))
        }
    }

    var ratios = [Int]()
    for sym in symMatches {
        let num = numMatches.filter({ $0.row-1 <= sym.row && $0.row+1 >= sym.row && $0.start-1 <= sym.start && $0.end+1 >= sym.end })
        if num.count == 2 {
            ratios.append(Int(num[0].number)! * Int(num[1].number)!)
        }
    }
    return ratios
}


import XCTest

class TestDay3: XCTestCase {
    let part1_input = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """.split(separator: "\n").map{ String($0) }
    
    let part1_array = [
        467, 35, 633, 617, 592, 755, 664, 598
    ].sorted()
    
    let custom_input = """
    *......
    .1.....
    ....2..
    .3.....
    *...4..
    .....*.
    """.split(separator: "\n").map{ String($0) }
    
    let custom_array = [1, 3, 4]
    
    func testPart1() {
        XCTAssertEqual(findNumbers(part1_input).sorted(), part1_array)
        XCTAssertEqual(findNumbers(custom_input).sorted(), custom_array)
    }
    
    func testPart2() {
        XCTAssertEqual(findGears(part1_input), [16345, 451490])
    }
}

TestDay3.defaultTestSuite.run()

//print(findNumbers(getLines()).reduce(0, +))
print(findGears(getLines()).reduce(0, +))
