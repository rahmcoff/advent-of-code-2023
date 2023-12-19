let digSite = DigPolygon(input: input)
print(digSite.interiorSize())

let hexDigSite = DigPolygon(input: input, parseHex: true)
print(hexDigSite.interiorSize())
