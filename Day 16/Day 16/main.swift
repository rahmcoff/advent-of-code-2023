let map = BeamMap(input: input)
map.runBeams()
print(map.litTiles)

let clock = ContinuousClock()

let time = clock.measure {
    map.reset()
    print(map.findMaxStart())
}
print(time)
