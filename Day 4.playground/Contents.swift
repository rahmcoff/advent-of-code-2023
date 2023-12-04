func calculatePoints(_ card: String) -> Int {
    let parts = card.split(separator: ":")[1].split(separator: "|")
    
    let leftNumbers = parts[0].trimmingCharacters(in: .whitespaces).split(separator: " ").map{ Int($0)! }
    let rightNumbers = parts[1].trimmingCharacters(in: .whitespaces).split(separator: " ").map{ Int($0)! }

    let count = rightNumbers.filter({ leftNumbers.contains($0) }).count
    if count == 0 {
        return 0
    }
    
    var points = 1
    for _ in 1..<count {
        points *= 2
    }
    return points
}


func countCards(_ cards: [String]) -> [Int: Int] {
    var cardCounts = [Int: Int](minimumCapacity: cards.count)
    for i in 1...cards.count {
        cardCounts[i] = 1
    }
    
    for card in cards{
        let wholeParts = card.split(separator: ":")
        let scratchParts = wholeParts[1].split(separator: "|")
        
        let cardNum = Int(wholeParts[0].split(separator: " ", omittingEmptySubsequences: true)[1])!
        
        let leftNumbers = scratchParts[0].trimmingCharacters(in: .whitespaces).split(separator: " ").map{ Int($0)! }
        let rightNumbers = scratchParts[1].trimmingCharacters(in: .whitespaces).split(separator: " ").map{ Int($0)! }
        
        let count = rightNumbers.filter({ leftNumbers.contains($0) }).count
        if count > 0 {
            for nextCard in cardNum+1 ... cardNum+count {
                if let nextCardCount = cardCounts[nextCard] {
                    cardCounts[nextCard] = cardCounts[cardNum]! + nextCardCount
                }
            }
        }
    }
    return cardCounts
}


import XCTest

class TestDay4: XCTestCase {
    let part1_input = """
    Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
    Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
    Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
    Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
    Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
    Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
    """.split(separator: "\n").map({ String($0) })
    
    let part1_points = [
        8,
        2,
        2,
        1,
        0,
        0
    ]
    
    func testPart1() {
        for (i, card) in part1_input.enumerated() {
            XCTAssertEqual(calculatePoints(card), part1_points[i])
        }
    }
    
    let part2_cardCount = [
        1: 1,
        2: 2,
        3: 4,
        4: 8,
        5: 14,
        6: 1
    ]
    
    func testPart2() {
        XCTAssertEqual(countCards(part1_input), part2_cardCount)
    }
}

TestDay4.defaultTestSuite.run()

let lines = getLines()

let totalPoints = lines.map(calculatePoints).reduce(0, +)

print(totalPoints)

let totalCards = countCards(lines).values.reduce(0, +)

print(totalCards)
