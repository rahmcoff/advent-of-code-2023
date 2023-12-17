
class BeamTile {
    let type: Character
    
    var energized = false
    
    init(type: Character) {
        self.type = type
    }
}

typealias BeamMap = [[BeamTile]]

extension BeamMap {
    init(input: String) {
        self = input.split(separator: "\n").map({ $0.map({ BeamTile(type: $0) }) })
    }
    
    func runBeams(start: Beam = Beam(r: 0, c: 0, d: .east)) {
        var runningQueue = [start]
        var seenBeams = Set<Beam>()
        
        while !runningQueue.isEmpty {
            let beam = runningQueue.popLast()!
            if seenBeams.contains(beam) {
                continue
            }
            if beam.r < 0 || beam.r >= self.count || beam.c < 0 || beam.c >= self[beam.r].count {
                continue
            }
            let tile = self[beam.r][beam.c]
            switch tile.type {
            case ".":
                runningQueue.append(beam.getNextBeam(beam.d))
            case "/":
                switch beam.d {
                case .north:
                    runningQueue.append(beam.getNextBeam(.east))
                case .south:
                    runningQueue.append(beam.getNextBeam(.west))
                case .east:
                    runningQueue.append(beam.getNextBeam(.north))
                case .west:
                    runningQueue.append(beam.getNextBeam(.south))
                }
            case "\\":
                switch beam.d {
                case .north:
                    runningQueue.append(beam.getNextBeam(.west))
                case .south:
                    runningQueue.append(beam.getNextBeam(.east))
                case .east:
                    runningQueue.append(beam.getNextBeam(.south))
                case .west:
                    runningQueue.append(beam.getNextBeam(.north))
                }
            case "|":
                switch beam.d {
                case .north:
                    fallthrough
                case .south:
                    runningQueue.append(beam.getNextBeam(beam.d))
                case .east:
                    fallthrough
                case .west:
                    runningQueue.append(beam.getNextBeam(.north))
                    runningQueue.append(beam.getNextBeam(.south))
                }
            case "-":
                switch beam.d {
                case .north:
                    fallthrough
                case .south:
                    runningQueue.append(beam.getNextBeam(.east))
                    runningQueue.append(beam.getNextBeam(.west))
                case .east:
                    fallthrough
                case .west:
                    runningQueue.append(beam.getNextBeam(beam.d))
                }
            default:
                break
            }
            tile.energized = true
            seenBeams.insert(beam)
        }
    }
        
    var litTiles: Int {
        self.map({ $0.filter({ $0.energized }).count }).reduce(0, +)
    }
    
    func reset() {
        for row in self {
            for tile in row {
                tile.energized = false
            }
        }
    }
    
    func findMaxStart() -> Int {
        var maxLitTiles = 0
        let maxRow = self.count - 1
        let maxCol = self.first!.count - 1
        
        for col in 0...maxCol {
            self.runBeams(start: Beam(r: 0, c: col, d: .south))
            maxLitTiles = Swift.max(maxLitTiles, self.litTiles)
            self.reset()
            self.runBeams(start: Beam(r: maxRow, c: col, d: .north))
            maxLitTiles = Swift.max(maxLitTiles, self.litTiles)
            self.reset()
        }
        
        for row in 0...maxRow {
            self.runBeams(start: Beam(r: row, c: 0, d: .east))
            maxLitTiles = Swift.max(maxLitTiles, self.litTiles)
            self.reset()
            self.runBeams(start: Beam(r: row, c: maxCol, d: .west))
            maxLitTiles = Swift.max(maxLitTiles, self.litTiles)
            self.reset()
        }
        
        return maxLitTiles
    }
}

enum Direction: Character {
    case north = "^"
    case south = "v"
    case east = ">"
    case west = "<"
}

struct Beam {
    let r: Int
    let c: Int
    let d: Direction
    
    func getNextBeam(_ going: Direction) -> Beam {
        switch going {
        case .north:
            return Beam(r: r-1, c: c, d: going)
        case .east:
            return Beam(r: r, c: c+1, d: going)
        case .south:
            return Beam(r: r+1, c: c, d: going)
        case .west:
            return Beam(r: r, c: c-1, d: going)
        }
    }
}

extension Beam: Hashable {
}
