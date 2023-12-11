struct Point: Hashable {
    let r: Int
    let c: Int
}

struct Node {
    let left: Point
    let right: Point
}

func buildPath(_ input: String) -> ([Point: Node], Point) {
    var path = [Point: Node]()
    var start: Point?
    
    for (row, line) in input.split(separator: "\n").enumerated() {
        for (col, letter) in Array(line).enumerated() {
            let pnt = Point(r: row, c: col)
            switch letter {
            case "S":
                start = pnt
            case "|":
                path[pnt] = Node(left: Point(r: row-1, c: col), right: Point(r: row+1, c: col))
            case "-":
                path[pnt] = Node(left: Point(r: row, c: col-1), right: Point(r: row, c: col+1))
            case "L":
                path[pnt] = Node(left: Point(r: row-1, c: col), right: Point(r: row, c: col+1))
            case "J":
                path[pnt] = Node(left: Point(r: row-1, c: col), right: Point(r: row, c: col-1))
            case "7":
                path[pnt] = Node(left: Point(r: row+1, c: col), right: Point(r: row, c: col-1))
            case "F":
                path[pnt] = Node(left: Point(r: row+1, c: col), right: Point(r: row, c: col+1))
            default:
                continue
            }
        }
    }
    return (path, start!)
}

func getLoop(_ path: [Point: Node], start: Point) -> [Point: Int] {
    var foundNodes = [start: 0]
    var workingNodes: [Point] = []
    
    for point in [Point(r: start.r+1, c: start.c), Point(r: start.r, c: start.c+1), Point(r: start.r-1, c: start.c), Point(r: start.r, c: start.c-1)] {
        guard let node = path[point] else { continue }
        if node.left == start {
            foundNodes[point] = 1
            foundNodes[node.right] = 2
            workingNodes.append(node.right)
        } else if node.right == start {
            foundNodes[point] = 1
            foundNodes[node.left] = 2
            workingNodes.append(node.left)
        }
    }
    
    while let nextPoint = workingNodes.first {
        let node = path[nextPoint]!
        let foundLeft = foundNodes[node.left]
        let foundRight = foundNodes[node.right]
        //        debugPrint(workingNodes)
        
        if foundLeft != nil && foundRight != nil{
            break
        } else if foundLeft != nil {
            workingNodes.append(node.right)
            foundNodes[node.right] = foundNodes[nextPoint]! + 1
        } else {
            workingNodes.append(node.left)
            foundNodes[node.left] = foundNodes[nextPoint]! + 1
        }
        workingNodes.remove(at: 0)
    }
    return foundNodes
}

func findInteriorCount(loop: [Point: Int], path: [Point: Node]) -> Int {
    var crossingPoints = Set<Point>()
    var maxCol = 0
    var maxRow = 0
    
    for point in loop.keys {
        maxCol = max(point.c, maxCol)
        maxRow = max(point.r, maxRow)
        
        guard let node = path[point] else { continue }  // Not dealing with the S because it doesn’t matter for real data
        if node.right.c == point.c + 1 {
            crossingPoints.insert(point)
        }
    }
    
    var interiorPoints = 0
    for r in 0...maxRow {
        for c in 0...maxCol {
            if loop[Point(r: r, c: c)] != nil {
                continue
            }
            
            var crossings = 0
            for testRow in 0..<r {
                if crossingPoints.contains(Point(r: testRow, c: c)) {
                    crossings += 1
                }
            }
            if crossings % 2 != 0 {
//                print(" Row: \(r) Col: \(c)")
                interiorPoints += 1
            }
        }
    }
    return interiorPoints
}

import XCTest

class TestDay10: XCTestCase {
    let simpleInput = """
    .....
    .S-7.
    .|.|.
    .L-J.
    .....
    """
    
    let complexInput = """
    7-F7-
    .FJ|7
    SJLL7
    |F--J
    LJ.LJ
    """
    
    func testPart1() {
        let (simplePath, startingPoint) = buildPath(simpleInput)
        let loop = getLoop(simplePath, start: startingPoint)
        XCTAssertEqual(loop.values.max(), 4)
    }
    
    func testComplexPart1() {
        let (simplePath, startingPoint) = buildPath(complexInput)
        XCTAssertEqual(getLoop(simplePath, start: startingPoint).values.max(), 8)
    }
    
    let input2A = """
    .F----7F7F7F7F-7....
    .|F--7||||||||FJ....
    .||.FJ||||||||L7....
    FJL7L7LJLJ||LJ.L-7..
    L--J.L7...LJS7F-7L7.
    ....F-J..F7FJ|L7L7L7
    ....L7.F7||L7|.L7L7|
    .....|FJLJ|FJ|F7|.LJ
    ....FJL-7.||.||||...
    ....L---J.LJ.LJLJ...
    """
    
    let input2B = """
    FF7FSF7F7F7F7F7F---7
    L|LJ||||||||||||F--J
    FL-7LJLJ||||||LJL-77
    F--JF--7||LJLJ7F7FJ-
    L---JF-JLJ.||-FJLJJ7
    |F|F-JF---7F7-L7L|7|
    |FFJF7L7F-JF7|JL---7
    7-L-JL7||F7|L7F-7F7|
    L.L7LFJ|||||FJL7||LJ
    L7JLJL-JLJLJL--JLJ.L
    """
    
    func testPart2A() {
        let (pipes, start) = buildPath(input2A)
        let loop = getLoop(pipes, start: start)
        XCTAssertEqual(findInteriorCount(loop: loop, path: pipes), 8)
    }
    
    func testPart2B() {
        let (pipes, start) = buildPath(input2B)
        let loop = getLoop(pipes, start: start)
        XCTAssertEqual(findInteriorCount(loop: loop, path: pipes), 10)
    }
}

TestDay10.defaultTestSuite.run()

let (pipes, start) = buildPath(getInput())
let loop = getLoop(pipes, start: start)
print(findInteriorCount(loop: loop, path: pipes))

