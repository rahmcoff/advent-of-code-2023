typealias Point = (r:Int, c:Int)

class Garden {
    var map: [[Int]]
    var start: Point
    let maxRow: Int
    let maxCol: Int
    
    init(_ input: String) {
        let lines = input.split(separator: "\n")
        map = []
        start = (r:0, c:0)
        
        for line in lines {
            var row: [Int] = []
            for letter in line {
                if letter == "S" {
                    start = (r:map.count, c:row.count)
                }
                row.append(letter == "#" ? -1 : 0)
            }
            map.append(row)
        }
        maxRow = map.count - 1
        maxCol = map.first!.count - 1
    }
    
    func findDistances(max: Int = .max) {
        var pointQueue = [start]
        
        while !pointQueue.isEmpty {
            let workingPoint = pointQueue.removeFirst()
            let workingDistance = map[workingPoint.r][workingPoint.c]
            if workingDistance >= max {
                break
            }
            for nextPoint in [
                (r: workingPoint.r + 1, c: workingPoint.c),
                (r: workingPoint.r - 1, c: workingPoint.c),
                (r: workingPoint.r, c: workingPoint.c + 1),
                (r: workingPoint.r, c: workingPoint.c - 1),
            ] {
                if 0 > workingPoint.r || workingPoint.r > maxRow
                    || 0 > workingPoint.c || workingPoint.c > maxCol {
                    continue
                }
                if map[nextPoint.r][nextPoint.c] == 0 {
                    map[nextPoint.r][nextPoint.c] = workingDistance + 1
                    pointQueue.append(nextPoint)
                }
            }
        }
    }
    
    func countEvenDistances() -> Int {
        map.map({ $0.filter({ $0 > 0 && $0 % 2 == 0 }).count }).reduce(0, +)
    }
    
    func countOddDistances() -> Int {
        map.map({ $0.filter({ $0 > 0 && $0 % 2 == 1 }).count }).reduce(0, +)
    }
    
    func reset() {
        for (rowIndex, row) in map.enumerated() {
            for (colIndex, value) in row.enumerated() {
                if map[rowIndex][colIndex] != -1 {
                    map[rowIndex][colIndex] = 0
                }
            }
        }
    }
    
    func findInfinitePossibilities(max: Int) -> Int {
        var totalMatches = 0
        
        findDistances(max: max)
        
        // matches in the center
        totalMatches += (max % 2 == 1 ? countOddDistances() : countEvenDistances())
        
        let leftInitalOffset = map[start.r][0]
        let topInitalOffset = map[0][start.c]
        let rightInitalOffset = map[start.r][maxRow]
        let bottomInitalOffset = map[maxRow][start.c]

        let topLeftInitialOffset = map[0][0]
        let topRightInitalOffset = map[0][maxCol]
        let bottomLeftInitalOffset = map[maxRow][0]
        let bottomRightInitalOffset = map[maxRow][maxCol]
        
        // matches to the left
        
        
        return totalMatches
    }
}
