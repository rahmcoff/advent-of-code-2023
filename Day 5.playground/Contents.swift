struct Section {
    struct Mapping {
        let range: Range<Int>
        let diff: Int
    }
    
    let from: String
    let to: String
    var maps: [Mapping] = []

    func map(_ value: Int) -> Int {
        for seg in maps {
            if seg.range.contains(value) {
                return value + seg.diff
            }
        }
        return value
    }
    
    func mapRanges(_ fromRanges: [Range<Int>]) -> [Range<Int>] {
        var from = fromRanges
        var to = [Range<Int>]()
        
        while var working = from.popLast() {
            guard let matching = maps.first(where: { $0.range.overlaps(working) }) else {
                to.append(working)
                continue
            }
            
            if working.lowerBound < matching.range.lowerBound {
                from.append(working.lowerBound..<matching.range.lowerBound)
                working = matching.range.lowerBound..<working.upperBound
            }
            
            if working.upperBound > matching.range.upperBound {
                from.append(matching.range.upperBound..<working.upperBound)
                working = working.lowerBound..<matching.range.upperBound
            }
            
            to.append(working.lowerBound+matching.diff..<working.upperBound+matching.diff)
        }
        
        return to
    }
    
    mutating func addMap(_ map: any StringProtocol) {
        let values = map.split(separator: " ").map({ Int($0)! })
        let newMap = Mapping(range: values[1]..<values[1]+values[2], diff: values[0]-values[1])
        maps.append(newMap)
    }
}

extension [Section] {
    func mapValue(_ value: Int, from: String, to: String) -> Int {
        var value = value
        var currentSection = self.first{ $0.from == from }!
        value = currentSection.map(value)
        while currentSection.to != to {
            currentSection = self.first{ $0.from == currentSection.to }!
            value = currentSection.map(value)
        }
        return value
    }
    
    func mapRanges(_ value: [Range<Int>], from: String, to:String) -> [Range<Int>] {
        var value = value
        var currentSection = self.first{ $0.from == from }!
        value = currentSection.mapRanges(value)
        while currentSection.to != to {
            currentSection = self.first{ $0.from == currentSection.to }!
            value = currentSection.mapRanges(value)
        }
        return value
    }
}

func generateMaps(_ input: String) -> [Section] {
    var sections = [Section]()
    var currentSection: Section!
    
    let mapHeader = /(.+)-to-(.+) map:/
    let mapLine = /\d+ \d+ \d+/
    
    for line in input.split(separator: "\n") {
        if let match = try! mapHeader.prefixMatch(in: line) {
            if currentSection != nil {
                sections.append(currentSection)
            }
            currentSection = Section(from: String(match.1), to: String(match.2))
        }
        if try! mapLine.prefixMatch(in: line) != nil {
            currentSection.addMap(line)
        }
    }
    sections.append(currentSection)
    return sections
}

import XCTest

class TestDay5: XCTestCase {
    let input = """
    seeds: 79 14 55 13

    seed-to-soil map:
    50 98 2
    52 50 48

    soil-to-fertilizer map:
    0 15 37
    37 52 2
    39 0 15

    fertilizer-to-water map:
    49 53 8
    0 11 42
    42 0 7
    57 7 4

    water-to-light map:
    88 18 7
    18 25 70

    light-to-temperature map:
    45 77 23
    81 45 19
    68 64 13

    temperature-to-humidity map:
    0 69 1
    1 0 69

    humidity-to-location map:
    60 56 37
    56 93 4
    """
    
    let range_input = [
        "50 98 2",
        "52 50 48"
    ]
    
    let seedSoil = [
        79: 81,
        14: 14,
        55: 57,
        13: 13
    ]
    
    let seedLocation = [
        79: 82,
        14: 43,
        55: 86,
        13: 35
    ]
    
    func testSeedSoilMap() {
        var sec = Section(from: "seed", to: "soil")
        for r in range_input {
            sec.addMap(r)
        }
        for (seed, soil) in seedSoil {
            XCTAssertEqual(sec.map(seed), soil)
        }
    }
    
    func testGeneralMap() {
        let maps = generateMaps(input)
        for (seed, soil) in seedSoil {
            XCTAssertEqual(maps.mapValue(seed, from: "seed", to: "soil"), soil)
        }
        for (seed, location) in seedLocation {
            XCTAssertEqual(maps.mapValue(seed, from: "seed", to: "location"), location)
        }
    }
    
    let seedRanges = [
        79..<79+14,
        55..<55+13
    ]
    
    func testRangeMapping() {
        let maps = generateMaps(input)
        let locationRanges = maps.mapRanges(seedRanges, from: "seed", to: "location")
        print(locationRanges.map({ "[\($0.lowerBound) - \($0.upperBound)]"}).reduce("", { "\($0)\($1)\n" }))
        let minValue = locationRanges.map({ $0.lowerBound }).reduce(.max, min)
    }
}

TestDay5.defaultTestSuite.run()

let input = getInput()
let fullMap = generateMaps(input)

let firstLine = input.split(separator: "\n")[0]
let seeds = firstLine.matches(of: /\d+/).map{ Int($0.0)! }

var seedLocation = [Int: Int]()
for s in seeds {
    seedLocation[s] = fullMap.mapValue(s, from: "seed", to: "location")
}

for (s, l) in seedLocation {
    print("\(s) -> \(l)")
}
print(seedLocation.values.reduce(.max, min))

let seedRanges = firstLine.matches(of: /(\d+) (\d+)/).map{ Int($0.1)!..<Int($0.1)!+Int($0.2)! }
let locationRanges = fullMap.mapRanges(seedRanges, from: "seed", to: "location")
print(locationRanges.map({ "[\($0.lowerBound) - \($0.upperBound)]"}).reduce("", { "\($0)\($1)\n" }))
let minValue = locationRanges.map({ $0.lowerBound }).reduce(.max, min)

