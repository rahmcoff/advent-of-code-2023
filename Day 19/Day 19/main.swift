let clock = ContinuousClock()

let sections = input.split(separator: "\n\n")

let sys = System(String(sections[0]))
let parts = Part.parse(String(sections[1]))

let sum = parts.filter(sys.test).map({ $0.values.reduce(0, +) }).reduce(0, +)

print(sum)

let part2Time = clock.measure {
    let possibilities = sys.getPossibleDistinctParts()
    print(possibilities.values.map({$0.count}).reduce(1, *))
    
    let successfulRanges = sys.getSuccessfulRanges()
    let totalSuccesses = successfulRanges.map({
        $0.values.map({
            $0.upperBound - $0.lowerBound + 1
        }).reduce(1, *)
    }).reduce(0, +)
    print("successes \(totalSuccesses)")
}
print(part2Time)
