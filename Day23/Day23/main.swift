let mz = Maze(input)

let distances = mz.findPathDistances()

print(distances.sorted())

let clock = ContinuousClock()

let time1 = clock.measure {
    for (start, end) in mz.getNodeDistances() {
        print("(\(start.r), \(start.c)): ", terminator: "")
        print(end.map({ "(\($0.0.r), \($0.0.c))" }).joined(separator: "  "))
    }
}
print (time1)

let time = clock.measure {
    print(mz.findDryDistance())
}
print(time)
