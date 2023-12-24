struct Point: Hashable {
    let r: Int
    let c: Int
}

class Maze {
    let blocks: [[Character]]
    
    init(_ input: String) {
        blocks = input.split(separator: "\n").map{ Array($0) }
    }
    
    func findPathDistances(dry: Bool = false) -> [Int] {
        var forks = [(Point, [Point])]() // Point where a decision was made, and the paths not taken
        var currentPoint = Point(r: 1, c: blocks.first!.firstIndex(where: {$0 == "."})!)
        var distances = [currentPoint: 1, Point(r: 0, c: currentPoint.c): 0]
        
        var pathDistances = [Int]()
        
        let allowedDirections = dry ? { [self] (p:Point) -> [Point] in
                if p.r == blocks.count - 1 { return [] }

                let cardPoints = [
                    Point(r: p.r-1, c: p.c),
                    Point(r: p.r, c: p.c+1),
                    Point(r: p.r+1, c: p.c),
                    Point(r: p.r, c: p.c-1)
                ]
                return cardPoints.filter({ distances[$0] == nil && blocks[$0.r][$0.c] != "#" })
            }
            : { [self] (p:Point) -> [Point] in
                if p.r == blocks.count - 1 { return [] }
                
                switch blocks[p.r][p.c] {
                case "^": return [Point(r: p.r-1, c: p.c)]
                case ">": return [Point(r: p.r, c: p.c+1)]
                case "v": return [Point(r: p.r+1, c: p.c)]
                case "<": return [Point(r: p.r, c: p.c-1)]
                default: break
                }
                let cardPoints: [(Point, Character)] = [
                    (Point(r: p.r-1, c: p.c), "^"),
                    (Point(r: p.r, c: p.c+1), ">"),
                    (Point(r: p.r+1, c: p.c), "v"),
                    (Point(r: p.r, c: p.c-1), "<"),
                ]
                return cardPoints.filter({ p, arrow in
                    distances[p] == nil && (blocks[p.r][p.c] == "." || blocks[p.r][p.c] == arrow)
                }).map{ $0.0 }
            }
        
        var currentDistance = 1
        
        while true {
            var allowed = allowedDirections(currentPoint)
            if allowed.count == 1 {
                currentPoint = allowed.first!
            } else if allowed.count > 1 {
                let nextPoint = allowed.removeFirst()
                forks.append((currentPoint, allowed))
                currentPoint = nextPoint
            } else {
                if forks.isEmpty {
                    break
                }
                (currentPoint, allowed) = forks.removeLast()
                currentDistance = distances[currentPoint]!
                for (p, d) in distances {
                    if d > currentDistance {
                        distances.removeValue(forKey: p)
                    }
                }
                let nextPoint = allowed.removeFirst()
                if !allowed.isEmpty {
                    forks.append((currentPoint, allowed))
                }
                currentPoint = nextPoint
            }
            currentDistance += 1
            distances[currentPoint] = currentDistance

            if currentPoint.r == blocks.count - 1 {
                pathDistances.append(currentDistance)
            }
        }
        
        return pathDistances
    }
    
    struct Remainder: Hashable {
        let p: Point
        let remain: Set<Point>
    }
    
    func findDryDistance() -> Int {
        let distances = getNodeDistances()
        
        var bestRemaining = [Remainder: Int]()
        
        func getLongestRemaining(_ remain: Remainder) -> Int {
            if remain.p.r == blocks.count - 1 {
                return 0
            }
            
            if let distance = bestRemaining[remain] {
                return distance
            }
            
            var distance = -9999999999
            
            for (nextNode, distanceToNextNode) in distances[remain.p]! {
                if !remain.remain.contains(nextNode) {
                    continue
                }
                var nextRemain = remain.remain
                nextRemain.remove(nextNode)
                distance = max(distance, distanceToNextNode + getLongestRemaining(Remainder(p: nextNode, remain: nextRemain)))
            }
            
            return distance
        }
        
        var allNodes = Set(distances.keys)
        allNodes.remove(Point(r: 0, c: 1))
        let remain = Remainder(p: Point(r: 0, c: 1), remain: allNodes)
        
        return getLongestRemaining(remain)
    }
    
    func getNodeDistances() -> [Point: [(Point, Int)]] {
        var nodes = Set(arrayLiteral: Point(r: 0, c: 1))
        var distances = [Point: [(Point, Int)]]()
        
        var testNodes = Set<Point>()
        var previousPoint = Point(r: 0, c: 1)
        var currentPoint = Point(r: 1, c: 1)
        var currentDistance = 1
        
        let getAvailable = { [self] ()->[Point] in
            if currentPoint.r == 0 || currentPoint.r == blocks.count - 1 { return []}
            let cardPoints = [
                Point(r: currentPoint.r-1, c: currentPoint.c),
                Point(r: currentPoint.r, c: currentPoint.c+1),
                Point(r: currentPoint.r+1, c: currentPoint.c),
                Point(r: currentPoint.r, c: currentPoint.c-1)
            ]
            return cardPoints.filter({ $0 != previousPoint && blocks[$0.r][$0.c] != "#" })
        }
        
        while true {
            let available = getAvailable()
            if available.count > 1 {
                testNodes.insert(currentPoint)
                distances[Point(r: 0, c: 1)] = [(currentPoint, currentDistance)]
                break
            }
            previousPoint = currentPoint
            currentPoint = available.first!
            currentDistance += 1
        }
        
        while !testNodes.isEmpty {
            let previousNode = testNodes.removeFirst()
            distances[previousNode] = []
            currentPoint = previousNode
            for direction in getAvailable() {
                previousPoint = previousNode
                currentPoint = direction
                currentDistance = 1
                var available = getAvailable();
                while available.count == 1 {
                    previousPoint = currentPoint
                    currentPoint = available.first!
                    available = getAvailable()
                    currentDistance += 1
                }
                distances[previousNode]?.append((currentPoint, currentDistance))
                if !nodes.contains(currentPoint) {
                    testNodes.insert(currentPoint)
                    nodes.insert(currentPoint)
                }
            }
        }

        return distances
    }
}
