struct SpringRecord: Hashable {
    let springs: [Character]
    let groups: [Int]
}

var cachedPermutations = [SpringRecord(springs: [], groups: []): 1]

func parseStringLine(line: String, unfolded: Bool) -> SpringRecord {
    let parts = line.split(separator: " ")
    
    var cleanString = String(parts[0])
    if unfolded {
        cleanString = Array(repeating: cleanString, count: 5).joined(separator: "?")
    }
    cleanString.replace(/\.+/, with: ".")
    cleanString.trimPrefix(".")
    
    var groupSizes = parts[1].split(separator: ",").map{ Int($0)! }
    if unfolded {
        groupSizes = groupSizes + groupSizes + groupSizes + groupSizes + groupSizes
    }
    
    return SpringRecord(springs: Array(cleanString), groups: groupSizes)
}

func numberOfVariations(_ line: String, unfolded: Bool = false) -> Int {
    var foundVariations = 0
    
    let record = parseStringLine(line: line, unfolded: unfolded)
    
    return numberOfPermutations(record: record)
}

func numberOfPermutations(record: SpringRecord) -> Int {
    if let result = cachedPermutations[record] {
        return result
    }
    
    if record.springs.count == 0 && record.groups.count == 0 {
        return 1
    }
    
    if record.groups.count == 0 {
        let result = record.springs.contains("#") ? 0 : 1
        cachedPermutations[record] = result
        return result
    }
    
    let wiggleRoom = record.springs.count - record.groups.reduce(0, +) - record.groups.count + 1
    
    if wiggleRoom < 0 {
        cachedPermutations[record] = 0
        return 0
    }
    
    var result = 0
    
    let nextGroup = record.groups[0]

    for offset in 0...wiggleRoom {
        if offset > 0 && record.springs[offset - 1] == "#" {
            break;
        }
        let nextBlank = offset + nextGroup
        if nextBlank == record.springs.count {
            if !record.springs[offset...].contains(".") {
                result += 1
            }
        } else if !record.springs[offset..<nextBlank].contains(".") && record.springs[nextBlank] != "#" {
            result += numberOfPermutations(record: SpringRecord(springs: Array(record.springs[(nextBlank+1)...]), groups: Array(record.groups[1...])))
        }
    }

    cachedPermutations[record] = result
    return result
}



import XCTest

class TestDay12: XCTestCase {
    let validInput = """
    #.#.### 1,1,3
    .#...#....###. 1,1,3
    .#.###.#.###### 1,3,1,6
    ####.#...#... 4,1,1
    #....######..#####. 1,6,5
    .###.##....# 3,2,1
    """.split(separator: "\n").map{ String($0) }
    
    let missingData = """
    ???.### 1,1,3
    .??..??...?##. 1,1,3
    ?#?#?#?#?#?#?#? 1,3,1,6
    ????.#...#... 4,1,1
    ????.######..#####. 1,6,5
    ?###???????? 3,2,1
    """.split(separator: "\n").map{ String($0) }

    let arrangements = [
        1,
        4,
        1,
        1,
        4,
        10
    ]
    
    func testValid() {
        for line in validInput {
            XCTAssertEqual(numberOfVariations(line), 1)
        }
    }
    
    func testPart1() {
        for (index, line) in missingData.enumerated() {
            XCTAssertEqual(numberOfVariations(line), arrangements[index])
        }
    }
    
    let unfoldedArrangements = [
        1,
        16384,
        1,
        16,
        2500,
        506250
    ]
    
    func testPart2() {
        for (index, line) in missingData.enumerated() {
            XCTAssertEqual(numberOfVariations(line, unfolded: true), unfoldedArrangements[index])
        }
    }
}

//TestDay12.defaultTestSuite.run()

let clock = ContinuousClock()
let time = clock.measure {
    print(getLines().map({ numberOfVariations($0, unfolded: true) }).reduce(0, +))
}
print(time)
