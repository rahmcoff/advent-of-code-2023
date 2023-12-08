struct Node {
    let left: String
    let right: String
}

func parseMap(_ input: String) -> ([Character], [String: Node]) {
    let lines = input.split(separator: "\n").map({ String($0) })
    let directions = Array(lines[0])
    var nodes = [String: Node]()
    
    for line in lines {
        if let match = line.firstMatch(of: /(\w+) = \((\w+), (\w+)\)/) {
            nodes[String(match.1)] = Node(left: String(match.2), right: String(match.3))
        }
    }
    
    return (directions, nodes)
}

func runMap(_ directions: [Character], _ nodes: [String: Node]) -> Int {
    var currentNode = "AAA"
    var steps = 0
    let dirCount = directions.count
    
    while currentNode != "ZZZ" {
//        debugPrint(directions[steps % dirCount], nodes[currentNode]!)
        
        if directions[steps % dirCount] == "R" {
            currentNode = nodes[currentNode]!.right
        } else {
            currentNode = nodes[currentNode]!.left
        }
        steps += 1
        
    }
    
    return steps
}

func find_gcd(_ num1: Int, _ num2: Int) -> Int {
    debugPrint(num1, num2)
    return num2 == 0 ? num1 : find_gcd(num2, num1 % num2)
}

func find_lcm(_ num1: Int, _ num2: Int) -> Int {
    let gcd = find_gcd(num1, num2)
    return abs(num1 * num2) / gcd
}

func ghostRunMap(_ directions: [Character], _ nodes: [String: Node]) -> Int {
    var currentNodes = nodes.keys.filter{ $0.hasSuffix("A") }
    var steps = [Int]()
    let dirCount = directions.count
    
    for currentNode in currentNodes {
        var currentNode = currentNode
        var step = 0
        
        while !currentNode.hasSuffix("Z") || step % dirCount != 0 {
//            debugPrint(directions[step % dirCount], step, nodes[currentNode]!)
            
            if directions[step % dirCount] == "R" {
                currentNode = nodes[currentNode]!.right
            } else {
                currentNode = nodes[currentNode]!.left
            }
            step += 1
        }
        steps.append(step)
    }
    print(steps)
    return steps.reduce(1, { find_lcm($0, $1) })
}

import XCTest

class TestDay8: XCTestCase {
    let input1 = """
    RL

    AAA = (BBB, CCC)
    BBB = (DDD, EEE)
    CCC = (ZZZ, GGG)
    DDD = (DDD, DDD)
    EEE = (EEE, EEE)
    GGG = (GGG, GGG)
    ZZZ = (ZZZ, ZZZ)
    """
    
    let input2 = """
    LLR

    AAA = (BBB, BBB)
    BBB = (AAA, ZZZ)
    ZZZ = (ZZZ, ZZZ)
    """
    
    func testExample1() {
        let (directions, nodes) = parseMap(input1)
        XCTAssertEqual(runMap(directions, nodes), 2)
    }
    
    func testExample2() {
        let (directions, nodes) = parseMap(input2)
        XCTAssertEqual(runMap(directions, nodes), 6)
    }

    let part2input = """
    LR

    11A = (11B, XXX)
    11B = (XXX, 11Z)
    11Z = (11B, XXX)
    22A = (22B, XXX)
    22B = (22C, 22C)
    22C = (22Z, 22Z)
    22Z = (22B, 22B)
    XXX = (XXX, XXX)
    """
    
    func testPart2() {
        let (directions, nodes) = parseMap(part2input)
        XCTAssertEqual(ghostRunMap(directions, nodes), 6)
    }
}

TestDay8.defaultTestSuite.run()


let (directions, nodes) = parseMap(getInput())
print(runMap(directions, nodes))
print(ghostRunMap(directions, nodes))
