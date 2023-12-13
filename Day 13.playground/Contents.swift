func findVertReflection(_ input: String) -> Int? {
    return findReflection(lines: input.getVertArray())
}

func findHorzReflection(_ input: String) -> Int? {
    return findReflection(lines: input.getHorzArray())
}

func findReflection(lines: [String]) -> Int? {
    let firstLine = lines.first!
    let lastLine = lines.last!
    
    for (index, testLine) in lines.enumerated() {
        if index == 0 || index == lines.count - 1 {
            continue
        }
        
        if testLine == firstLine {
            let midPoint = (index+1)/2
            if Array(lines[0..<midPoint]) == Array(lines[midPoint...index].reversed()) {
                return midPoint
            }
        }
        if testLine == lastLine {
            let midPoint = (lines.count + index) / 2
            if Array(lines[index..<midPoint]) == Array(lines[midPoint...].reversed()) {
                return midPoint
            }
        }
    }
    return nil
}

func findSmugedVertReflection(_ input: String) -> Int? {
    return findSmugedReflection(lines: input.getVertArray())
}

func findSmugedHorzReflection(_ input: String) -> Int? {
    return findSmugedReflection(lines: input.getHorzArray())
}

func findSmugedReflection(lines: [String]) -> Int? {
    let firstLine = lines.first!
    let lastLine = lines.last!
    
    for (index, testLine) in lines.enumerated() {
        if index == 0 || index == lines.count - 1 {
            continue
        }

        if index % 2 == 1 && testLine.differences(firstLine) <= 1 {
            let midPoint = (index+1)/2
            if Array(lines[0..<midPoint]).almostEqual(Array(lines[midPoint...index].reversed())) {
                return midPoint
            }
        }
        if (lines.count + index) % 2 == 0 && testLine.differences(lastLine) <= 1 {
            let midPoint = (lines.count + index) / 2
            if Array(lines[index..<midPoint]).almostEqual(Array(lines[midPoint...].reversed())) {
                return midPoint
            }
        }
    }
    return nil
}


extension String {
    func differences(_ rhs: String) -> Int {
        let rhs = Array(rhs)
        var runningTotal = 0
        for (index, letter) in self.enumerated() {
            if letter != rhs[index] {
                runningTotal += 1
            }
        }
        return runningTotal
    }
    
    func getVertArray() -> [String] {
        let inputLines = self.split(separator: "\n")
        
        var lines = [String](repeating: "", count: inputLines.first!.count)

        for line in inputLines {
            for (index, letter) in line.enumerated() {
                lines[index] += String(letter)
            }
        }
        
        return lines
    }
    
    func getHorzArray() -> [String] {
        return self.split(separator: "\n").map({ String($0) })
    }
}

extension [String] {
    func almostEqual(_ rhs: [String]) -> Bool {
        var totalDifferences = 0
        for (index, line) in self.enumerated() {
            totalDifferences += line.differences(rhs[index])
            if totalDifferences > 1 { return false }
        }
        return totalDifferences == 1
    }
}

import XCTest

class TestDay13 : XCTestCase {
    let inputA = """
    #.##..##.
    ..#.##.#.
    ##......#
    ##......#
    ..#.##.#.
    ..##..##.
    #.#.##.#.
    """
    
    let inputB = """
    #...##..#
    #....#..#
    ..##..###
    #####.##.
    #####.##.
    ..##..###
    #....#..#
    """
    
    func testPart1() {
        XCTAssertEqual(findVertReflection(inputA), 5)
        XCTAssertEqual(findHorzReflection(inputB), 4)
    }
    
    func testPart2() {
        XCTAssertEqual(findSmugedHorzReflection(inputA), 3)
        XCTAssertEqual(findSmugedHorzReflection(inputB), 1)
    }
}

TestDay13.defaultTestSuite.run()

let blocks = getInput().split(separator: "\n\n")

var total = 0
var smugedTotal = 0

for b in blocks {
    let b = String(b)
    
    let horzLine = findHorzReflection(b)
    if let horzLine = horzLine {
        total += horzLine * 100
        continue
    }
    let vertLine = findVertReflection(b)
    if let vertLine = vertLine {
        total += vertLine
    } else {
        print(b)
    }
    
    let smugedHorzLine = findSmugedHorzReflection(b)
    if let smugedHorzLine = smugedHorzLine {
        smugedTotal += smugedHorzLine * 100
        continue
    }
    let smugedVertLine = findSmugedVertReflection(b)
    if let smugedVertLine = smugedVertLine {
        smugedTotal += smugedVertLine
    } else {
        print(b)
    }
}

print(total)
print(smugedTotal)
