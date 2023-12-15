func aocHash(_ input: String) -> Int {
    input.map({ $0.asciiValue! }).reduce(0) { hash, letter in
        (hash + Int(letter)) * 17 % 256
    }
}

func hashSum(_ input: String) -> Int {
    input.split(separator: ",").map({ aocHash(String($0)) }).reduce(0, +)
}


class Lens {
    let label: String
    var focalLength: Int
    
    init(label: String, focalLength: Int) {
        self.label = label
        self.focalLength = focalLength
    }
}

typealias Hashmap = [Int: [Lens]]

extension Hashmap {
    static func new() -> Hashmap {
        var map = Hashmap(minimumCapacity: 256)
        for index in 0...255 {
            map[index] = []
        }
        return map
    }
    
    mutating func runLensRule(rule: String) {
        if rule.contains("=") {
            let parts = rule.split(separator: "=")
            let label = String(parts[0])
            let focalLength = Int(parts[1])!
            
            let boxNumber = aocHash(label)
            
            if let currentLens = self[boxNumber]?.first(where: { $0.label == label }) {
                currentLens.focalLength = focalLength
            } else {
                self[boxNumber]!.append(Lens(label: label, focalLength: focalLength))
            }
        } else {
            // assume "-"
            let label = rule.replacing("-", with: "")
            let boxNumer = aocHash(label)
            
            if let index = self[boxNumer]!.firstIndex(where: { $0.label == label }) {
                self[boxNumer]!.remove(at: index)
            }
        }
    }
    
    mutating func runAllRules(_ input: String) {
        for rule in input.split(separator: ",") {
            self.runLensRule(rule: String(rule))
        }
    }
    
    func getFocusingPower() -> Int {
        var totalPower = 0
        
        for (index, box) in self {
            for (slot, lens) in box.enumerated() {
                totalPower += (index+1) * (slot+1) * lens.focalLength
            }
        }
        return totalPower
    }
    
    func printBoxes() {
        for (index, box) in self {
            if box.isEmpty { continue }
            let boxLine = box.map({ "[\($0.label) \($0.focalLength)]"}).joined(separator: " ")
            print("Box \(index): \(boxLine)")
        }
    }
}
