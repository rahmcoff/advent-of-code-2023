enum Category: Character, CaseIterable {
    case x = "x"
    case m = "m"
    case a = "a"
    case s = "s"
}

typealias Part = [Category: Int]

extension Part {
    static func parse(_ input: String) -> [Part] {
        var parts = [Part]()
        for line in input.split(separator: "\n") {
            var linePart: Part = [:]
            for section in line.replacing("{", with: "").replacing("}", with: "").split(separator: ",") {
                let cat = Category(rawValue: section[section.startIndex])!
                let index = section.index(section.startIndex, offsetBy: 2)
                let value = Int(section[index...])!
                linePart[cat] = value
            }
            parts.append(linePart)
        }
        return parts
    }
}


class Rule {
    let cat: Category
    let comp: Character
    let val: Int
    let result: String
    
    init(_ input: String) {
        cat = Category(rawValue: input[input.startIndex])!
        let secondIndex = input.index(after: input.startIndex)
        comp = input[secondIndex]
        let parts = input[input.index(after: secondIndex)...].split(separator: ":")
        val = Int(parts[0])!
        result = String(parts[1])
    }
    
    func test(_ part: Part)->String? {
        if comp == "<" && part[cat]! < val {
            return result
        }
        if comp == ">" && part[cat]! > val {
            return result
        }
        return nil
    }
}

class Workflow {
    var rules: [Rule]
    var defaul: String
    
    init(_ input: String) {
        var ruleInput = input.replacing("{", with: "").replacing("}", with: "").split(separator: ",")
        defaul = String(ruleInput.removeLast())
        rules = ruleInput.map{ Rule(String($0)) }
    }
    
    func test(_ part: Part) -> String {
        for r in rules {
            if let result = r.test(part){
                return result
            }
        }
        return defaul
    }
}

typealias System = [String: Workflow]

extension System {
    init(_ input: String) {
        self = [:]
        for line in input.split(separator: "\n") {
            let parts = line.split(separator: "{", maxSplits: 2)
            self[String(parts[0])] = Workflow(String(parts[1]))
        }
    }
    
    func test(_ part: Part) -> Bool {
        var workflow = self["in"]!
        
        while true {
            let result = workflow.test(part)
            if result == "A" {
                return true
            } else if result == "R" {
                return false
            } else {
                workflow = self[result]!
            }
        }
    }
    
    func getPossibleDistinctParts() -> [Category: [Int]] {
        var distinct = Category.allCases.reduce(into: [Category: [Int]]()) { $0[$1] = [] }
        for work in self.values {
            for r in work.rules {
                let val = r.comp == "<" ? r.val - 1 : r.val
                distinct[r.cat]?.append(val)
            }
        }
        return distinct
    }
    
    typealias XmasRange = [Category: ClosedRange<Int>]
    
    func getSuccessfulRanges() -> [XmasRange] {
        let firstRange = [
            Category.x: 1...4000,
            Category.m: 1...4000,
            Category.a: 1...4000,
            Category.s: 1...4000,
        ]
        var workingRanges = [(firstRange, "in")]
        var successes = [XmasRange]()
        
        while !workingRanges.isEmpty {
            var (xrange, workName) = workingRanges.removeFirst()
            if workName == "A" {
                successes.append(xrange)
                continue
            } else if workName == "R" {
                continue
            }
            
            let work = self[workName]!
            var useDefaul = true
            for rule in work.rules {
                let range = xrange[rule.cat]!
                if range.contains(rule.val) {
                    var newRange = xrange
                    if rule.comp == "<" {
                        newRange[rule.cat] = range.lowerBound...rule.val - 1
                        xrange[rule.cat] = rule.val...range.upperBound
                    } else {
                        newRange[rule.cat] = rule.val + 1...range.upperBound
                        xrange[rule.cat] = range.lowerBound...rule.val
                    }
                    workingRanges.append((newRange, rule.result))
                } else if (range.upperBound < rule.val && rule.comp == "<") || (range.lowerBound > rule.val && rule.comp == ">") {
                    workingRanges.append((xrange, rule.result))
                    useDefaul = false
                    break
                }
            }
            if useDefaul {
                workingRanges.append((xrange, work.defaul))
            }
        }
        
        return successes
    }
}

