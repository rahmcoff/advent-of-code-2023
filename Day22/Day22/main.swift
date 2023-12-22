let pile = Pile(input)
pile.fall()
print(pile.countRedundant())

let clock = ContinuousClock()

let time = clock.measure {
    print(pile.getCascadeCount())
}
print(time)
