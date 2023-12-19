struct HorzPath {
    let r: Int
    let left: Int
    let right: Int
}

struct VertPath {
    let c: Int
    let top: Int
    let bottom: Int
}

class DigPolygon {
    var horz: [HorzPath]
    var vert: [VertPath]
    
    init(input: [String], parseHex: Bool = false) {
        horz = []
        vert = []
        
        var currentRow = 0
        var currentCol = 0
        
        for line in input {
            let (dir, distance) = parseHex ? getHexDirDistance(line) : getDirDistance(line)
            
            switch dir {
            case "L":
                horz.append(HorzPath(r: currentRow, left: currentCol - distance, right: currentCol))
                currentCol -= distance
            case "R":
                horz.append(HorzPath(r: currentRow, left: currentCol, right: currentCol + distance))
                currentCol += distance
            case "U":
                vert.append(VertPath(c: currentCol, top: currentRow - distance, bottom: currentRow))
                currentRow -= distance
            case "D":
                vert.append(VertPath(c: currentCol, top: currentRow, bottom: currentRow + distance))
                currentRow += distance
            default:
                fatalError("There is no direction \(dir)")
            }
        }
        horz.sort{ $0.r < $1.r }
    }
    
    func getDirDistance(_ line: String) -> (Character, Int) {
        let parts = line.split(separator: " ")
        return (parts[0].first!, Int(parts[1])!)
    }
    
    func getHexDirDistance(_ line: String) -> (Character, Int) {
        let parts = line.replacing(")", with: "").split(separator: "#")
        let dir: Character
        switch parts[1].last! {
        case "0":
            dir = "R"
        case "1":
            dir = "D"
        case "2":
            dir = "L"
        case "3":
            dir = "U"
        default:
            dir = parts[1].last!
        }
        
        let lastindex = parts[1].index(before: parts[1].endIndex)
        
        return (dir, Int(parts[1][..<lastindex], radix: 16)!)
    }
    
    func interiorSize() -> Int {
        var size = 0
        
        var bars = [ClosedRange<Int>]()
        var barsWidth = 0
        var prevRow = 0
        
        for path in horz {
            size += barsWidth * (path.r - prevRow)
            print("Width: \(barsWidth) Height: \(path.r - prevRow) \(bars)")
            prevRow = path.r
            
            if let index = bars.firstIndex(of: path.left...path.right) {
                bars.remove(at: index)
                barsWidth -= path.right - path.left + 1
                size += path.right - path.left + 1
//                print ("+ \(path.right - path.left + 1) for the bottom")
            } else if let indexToShrink = bars.firstIndex(where: {$0.lowerBound == path.left }){
                bars[indexToShrink] = path.right ... bars[indexToShrink].upperBound
                barsWidth -= path.right - path.left
                size += path.right - path.left
//                print ("+ \(path.right - path.left) for the bottom")
            } else if let indexToShrink = bars.firstIndex(where: {$0.upperBound == path.right }){
                bars[indexToShrink] = bars[indexToShrink].lowerBound ... path.left
                barsWidth -= path.right - path.left
                size += path.right - path.left
//                print ("+ \(path.right - path.left) for the bottom")
            } else if let indexToSplit = bars.firstIndex(where: {$0.lowerBound < path.left && path.right < $0.upperBound }){
                let barToSplit = bars[indexToSplit]
                bars[indexToSplit] = barToSplit.lowerBound ... path.left
                bars.append(path.right ... barToSplit.upperBound)
                barsWidth -= path.right - path.left - 1
                size += path.right - path.left - 1
//                print ("+ \(path.right - path.left - 1) for the bottom")
            } else if let indexToExtend = bars.firstIndex(where: { $0.upperBound == path.left }) {
                if let indexToRemove = bars.firstIndex(where: { $0.lowerBound == path.right }) {
                    bars[indexToExtend] = bars[indexToExtend].lowerBound ... bars[indexToRemove].upperBound
                    bars.remove(at: indexToRemove)
                    barsWidth += path.right - path.left - 1
                    print("join together")
                } else {
                    bars[indexToExtend] = bars[indexToExtend].lowerBound ... path.right
                    barsWidth += path.right - path.left
//                    print("extend right")
                }
            } else if let indexToExtend = bars.firstIndex(where: { $0.lowerBound == path.right }) {
                bars[indexToExtend] = path.left ... bars[indexToExtend].upperBound
                barsWidth += path.right - path.left
//                print("Extend to the left")
            } else {
                bars.append(path.left ... path.right)
                barsWidth += path.right - path.left + 1
            }
        }

        return size
    }
}
