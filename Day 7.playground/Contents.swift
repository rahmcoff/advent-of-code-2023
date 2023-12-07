struct Hand: Comparable {
    let cards: [Int]
    let type: Int
    let bid: Int

    init(_ hand: String) {
        let parts = hand.split(separator: " ")
        self.cards = Hand.changeToInt(parts[0])
        self.type = Hand.getType(self.cards)
//        print(self.type)
        self.bid = Int(parts[1])!
    }
    
    static func changeToInt(_ hand: Substring) -> [Int] {
        var values = [Int]()
        for letter in hand {
            switch letter {
            case "A":
                values.append(14)
            case "K":
                values.append(13)
            case "Q":
                values.append(12)
            case "J":
                values.append(1) // change to 11 for part 1
            case "T":
                values.append(10)
            default:
                values.append(Int(String(letter)) ?? 0)
            }
        }
        return values
    }
    
    static func getType(_ hand: [Int]) -> Int {
        var unique = Set(hand)
        unique.remove(1)
        let handStructure = unique.map({ card in hand.filter({ $0 == card }).count }).sorted()
        
        switch handStructure.count {
        case 0, 1:
            // five of a kind
            return 6
        case 2:
            if handStructure[0] == 1 {
                // four of a kind
                return 5
            } else {
                // full house
                return 4
            }
        case 3:
            if handStructure[1] == 1 {
                // three of a kind
                return 3
            } else {
                // two pair
                return 2
            }
        case 4:
            // one pair
            return 1
        default:
            // high card
            return 0
        }
        
    }
    
    static func < (lhs: Hand, rhs: Hand) -> Bool {
        if lhs.type < rhs.type {
            return true
        } else if lhs.type > rhs.type {
            return false
        }
        for (index, value) in lhs.cards.enumerated() {
            if value < rhs.cards[index] {
                return true
            } else if value > rhs.cards[index] {
                return false
            }
        }
        return false
    }
}


import XCTest

class TestDay7: XCTestCase {
    let input = """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
    """.split(separator: "\n").map{ String($0) }
    
    func testHandsRank() {
        var hands = input.map{ Hand($0) }
        hands.sort()
        print(hands)
        var totalWinnings = 0
        for (mlp, hand) in hands.enumerated() {
            print("\(hand.type) \(hand.cards) : \(mlp+1) * \(hand.bid)")
            totalWinnings += (mlp+1) * hand.bid
        }
        XCTAssertEqual(totalWinnings, 5905)
    }
}

TestDay7.defaultTestSuite.run()

var hands = getLines().map{ Hand($0) }
hands.sort()
var totalWinnings = 0
for (mlp, hand) in hands.enumerated() {
//    print("\(hand.type) \(hand.cards) : \(mlp+1) * \(hand.bid)")
    totalWinnings += (mlp+1) * hand.bid
}

print(totalWinnings)
