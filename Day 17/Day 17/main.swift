print("Hello World")

let clock = ContinuousClock()

let city = City(input: input)

let time1 = clock.measure {
    print(city.findShortestPath(ultra: true))
}
print(time1)
