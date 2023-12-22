class Brick: Equatable {
    static func == (lhs: Brick, rhs: Brick) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
    
    let x: ClosedRange<Int>
    let y: ClosedRange<Int>
    var z: ClosedRange<Int>
    
    init(_ input: String) {
        let parts = input.split(separator: "~")
        let bottom = parts[0].split(separator: ",")
        let top = parts[1].split(separator: ",")
        
        x = Int(bottom[0])!...Int(top[0])!
        y = Int(bottom[1])!...Int(top[1])!
        z = Int(bottom[2])!...Int(top[2])!
    }
    
    func supports(_ other: Brick) -> Bool {
        return other.z.lowerBound == z.upperBound + 1 
            && x.overlaps(other.x)
            && y.overlaps(other.y)
    }
}

struct Position: Hashable {
    let x: Int
    let y: Int
}

class Pile {
    var bricks: [Brick]
    var top: [Position: Int] = [:]
    
    init(_ input: String) {
        bricks = input.split(separator: "\n").map{ Brick(String($0)) }
    }
    
    func fall() {
        bricks.sort{ $0.z.lowerBound < $1.z.lowerBound }
        
        for brick in bricks {
            var newTop = 0
            for x in brick.x {
                for y in brick.y {
                    newTop = max(top[Position(x: x, y: y), default: 0], newTop)
                }
            }
            
            let zDiff = brick.z.lowerBound - newTop - 1
            brick.z = brick.z.lowerBound - zDiff ... brick.z.upperBound - zDiff
            for x in brick.x {
                for y in brick.y {
                    top[Position(x: x, y: y)] = brick.z.upperBound
                }
            }
        }
    }
    
    func countRedundant() -> Int {
        var redundantBricks = 0
        
        var levels = [Int: [Brick]]()
        for brick in bricks {
            levels[brick.z.upperBound, default: []].append(brick)
        }
        
        for (level, lowerBricks) in levels {
            let upperBricks = bricks.filter{ $0.z.lowerBound == level + 1 }
            
            brickTest: for brick in lowerBricks {
                let supported = upperBricks.filter{ brick.supports($0) }
                if supported.count == 0 {
                    redundantBricks += 1
                    continue
                }
                for topBrick in supported {
                    if (topBrick.x.count == 1 && topBrick.y.count == 1) 
                        || lowerBricks.filter({ $0.supports(topBrick) }).count == 1 {
                        continue brickTest
                    }
                }
                redundantBricks += 1
            }
        }
        
        return redundantBricks
    }
    
    func getCascadeCount() -> Int {
        var casecadeSum = 0
        
        for brick in bricks {
            var fallenBricks = [brick]
            var fallingBrickQueue = [brick]

            while !fallingBrickQueue.isEmpty {
                let fallingBrick = fallingBrickQueue.removeFirst()
                
                for topBrick in bricks.filter({ fallingBrick.supports($0) }) {
                    if fallenBricks.contains(topBrick) {
                        continue
                    }
                    if (topBrick.x.count == 1 && topBrick.y.count == 1)
                        || bricks.filter({ $0.supports(topBrick) && !fallenBricks.contains($0) }).count == 0 {
                        fallenBricks.append(topBrick)
                        fallingBrickQueue.append(topBrick)
                    }
                }
            }
            casecadeSum += fallenBricks.count - 1
        }
        
        return casecadeSum
    }
}
