struct Hailstone {
    let pos: (x: Int, y: Int, z: Int)
    let vel: (x: Int, y: Int, z: Int)
    
    init(_ input: Substring) {
        let match = try! /([-\d]+), ([-\d]+), ([-\d]+) @ ([-\d]+), ([-\d]+), ([-\d]+)/.firstMatch(in: input)!
        pos = (x: Int(match.1)!, y: Int(match.2)!, z: Int(match.3)!)
        vel = (x: Int(match.4)!, y: Int(match.5)!, z: Int(match.6)!)
    }
    
    func collide(_ other: Hailstone) -> (x: Double, y: Double)? {
        let selfSlope = Double(self.vel.y)/Double(self.vel.x)
        let selfInter = Double(self.pos.y) - selfSlope * Double(self.pos.x)
        
        let otherSlope = Double(other.vel.y)/Double(other.vel.x)
        let otherInter = Double(other.pos.y) - otherSlope * Double(other.pos.x)
        
        if abs(otherSlope - selfSlope) < 0.00002 { // rounding error
            return nil
        }
        
        let x = (selfInter - otherInter) / (otherSlope - selfSlope)
        let y = Double(x) * selfSlope + selfInter
        
        if (x > Double(self.pos.x)) != (self.vel.x > 0)
            || (x > Double(other.pos.x)) != (other.vel.x > 0){ // happened in the past
            return nil
        }
        
        return (x: x, y: y)
    }
}

class Hailstorm {
    let stones: [Hailstone]
    
    init(_ input: String) {
        stones = input.split(separator: "\n").map{ Hailstone($0) }
    }
    
    func futureFlatCollisions(from: Int, to: Int) -> Int {
        var collisions = 0
        let allowedRange = Double(from)...Double(to)
        
        for (index, stone) in stones.enumerated() {
            for other in stones[..<index] {
                if let collide = stone.collide(other) {
                    if allowedRange.contains(collide.x) && allowedRange.contains(collide.y) {
                        collisions += 1
                    }
                }
            }
        }
        
        return collisions
    }
}
