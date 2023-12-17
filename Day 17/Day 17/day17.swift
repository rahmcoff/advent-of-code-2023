enum Direction: Comparable {
    case north
    case east
    case south
    case west
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        if rhs == .south || lhs == .north { return false }
        if lhs == .south || rhs == .north { return true }
        if lhs == .east && rhs == .west { return true }
        return false
    }
}

struct Step: Hashable {
    let d: Direction
    let count: Int
}

struct Path {
    let step: Step
    let r: Int
    let c: Int

    var loss = 0
    
    func getPath(_ dir: Direction, ultra: Bool) -> Path? {
        if ultra && step.count < 4 && dir != step.d {
            return nil
        }
        if step.d == dir && step.count >= (ultra ? 10 : 3) {
            return nil
        }
        
        let nextStep = Step(d: dir, count: dir == step.d ? step.count+1 : 1)
        switch dir {
        case .north:
            if step.d == .south {
                return nil
            }
            return Path(step: nextStep, r: r-1, c: c, loss: loss)
        case .east:
            if step.d == .west {
                return nil
            }
            return Path(step: nextStep, r: r, c: c+1, loss: loss)
        case .south:
            if step.d == .north {
                return nil
            }
            return Path(step: nextStep, r: r+1, c: c, loss: loss)
        case .west:
            if step.d == .east {
                return nil
            }
            return Path(step: nextStep, r: r, c: c-1, loss: loss)
        }
    }
    
    func nextPaths(ultra: Bool = false) -> [Path] {
        var next: [Path] = []
        for d in [Direction.south, .east, .west, .north] {
            if let p = getPath(d, ultra: ultra) {
                next.append(p)
            }
        }
        return next
    }
}

class Block {
    let loss: Int
    
    init(loss: Int) {
        self.loss = loss
    }
    
    var minPaths = [Step: Int]()
}

typealias City = [[Block]]

extension City {
    init(input: String) {
        self = input.split(separator: "\n").map({ $0.map({ Block(loss: Int($0.asciiValue! - 48)) }) })
    }
    
    func findShortestPath(ultra: Bool = false) -> Int {
        let maxRow = self.count-1
        let maxCol = self.first!.count-1
        var endValue = Int.max
        
        self[0][0].minPaths = [ Step(d: .north, count: 1): 0, Step(d: .west, count: 1): 0 ]
        
        var workingPaths = [
            Path(step: Step(d: .east, count: 1), r: 0, c: 1),
            Path(step: Step(d: .south, count: 1), r: 1, c: 0)
        ]
        while !workingPaths.isEmpty {
            workingPaths.sort{ $0.loss < $1.loss }
            var testPath = workingPaths.removeFirst()
            let testBlock = self[testPath.r][testPath.c]
            testPath.loss += testBlock.loss
            if testPath.loss >= endValue {
                continue
            }
            
            if !ultra || testPath.step.count >= 4 {
                var bestPath = true
                for cnt in (ultra ? 4 : 1)...testPath.step.count {
                    if let testLoss = testBlock.minPaths[Step(d: testPath.step.d, count: cnt)] {
                        if testLoss <= testPath.loss {
                            bestPath = false
                        }
                    }
                }
                if !bestPath {
                    continue
                }
                
                testBlock.minPaths[testPath.step] = testPath.loss
                if testPath.c == maxCol && testPath.r == maxRow {
                    endValue = testPath.loss
                }
            }
            
            for newPath in testPath.nextPaths(ultra: ultra) {
                if newPath.r < 0 || newPath.r > maxRow
                    || newPath.c < 0 || newPath.c > maxCol {
                    continue
                }
                workingPaths.append(newPath)
            }
            print("\(workingPaths.count) \(testPath.r) \(testPath.c) loss:\(testPath.loss)")
        }
        
        return endValue
    }
}
