let net = Network(input)

print(net.pulseCount(pushes: 1000))

let net2 = Network(input)

let clock = ContinuousClock()
let time = clock.measure {
    print(net.findPressesToSendLow(to: "rx"))
}
print(time)
