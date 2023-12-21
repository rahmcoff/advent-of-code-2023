enum ModuleType {
    case flipFlop
    case conjuct
}

class Module {
    let type: ModuleType
    let output: [String]
    var ffMemory: Bool = false
    var conjMemory: [String: Bool] = [:]
    
    init(type: ModuleType, output: [String]) {
        self.type = type
        self.output = output
    }
    
    func trigger(_ input: Pulse) -> [Pulse] {
        switch self.type {
        case .flipFlop:
            if input.high {
                return []
            }
            ffMemory = !ffMemory
            return output.map{ (from: input.to, to: $0, high: ffMemory) }
        case .conjuct:
            conjMemory[input.from] = input.high
            ffMemory = conjMemory.values.contains(true)
            let pulseStrengh = conjMemory.values.contains(false)
            return output.map{ (from: input.to, to: $0, high: pulseStrengh) }
        }
    }
}

typealias Pulse = (from: String, to: String, high: Bool)

class Network {
    var modules: [String: Module]
    var broadcast: [String]
    
    init(_ input: String) {
        modules = [:]
        broadcast = []
        
        var modulesInput = [String: [String]]()
        
        let moduleParse = /^(.)(.+) -> (.+)$/
        for line in input.split(separator: "\n") {
            if line.starts(with: "broadcaster") {
                broadcast = line.split(separator: "-> ")[1].split(separator: ",").map{ String($0.replacing(" ", with: "")) }
                for mod in broadcast {
                    modulesInput[mod, default: []].append("broadcast")
                }
                continue
            }
            
            if let match = try! moduleParse.wholeMatch(in: line) {
                let output = match.3.split(separator: ",").map{ String($0.replacing(" ", with: "")) }
                let name = String(match.2)
                modules[name] = Module(type: match.1 == "%" ? .flipFlop : .conjuct, output: output)
                for mod in output {
                    modulesInput[mod, default: []].append(name)
                }
            } else {
                print("What is \(line)?")
            }
        }
        
        for (name, mod) in modules {
            if mod.type == .conjuct {
                for inputMod in modulesInput[name]! {
                    mod.conjMemory[inputMod] = false
                }
            }
        }
    }
    
    func pushTestButton() -> [Bool] {
        var pulseQueue: [Pulse] = broadcast.map{ (from: "broadcast", to: $0, high: false) }
        
        var output: [Bool] = []
        
        while !pulseQueue.isEmpty {
            let pulse = pulseQueue.removeFirst()
            if let module = modules[pulse.to] {
                for pulse in module.trigger(pulse) {
                    pulseQueue.append(pulse)
                }
            } else {
                output.append(pulse.high)
            }
        }
        return output
    }
    
    func isBackToBeginning() -> Bool {
        return !modules.values.contains(where: { $0.ffMemory })
    }
    
    func pulseCount(pushes: Int) -> Int {
        var lowPulses = 0
        var highPulses = 0
        
        var loopCount = 0
        
        let pushButton = { [self] in
            var pulseQueue: [Pulse] = broadcast.map{ (from: "broadcast", to: $0, high: false) }
            lowPulses += 1 // The inital button
            
            while !pulseQueue.isEmpty {
                let pulse = pulseQueue.removeFirst()
                if pulse.high {
                    highPulses += 1
                } else {
                    lowPulses += 1
                }
                if let module = modules[pulse.to] {
                    for pulse in module.trigger(pulse) {
                        pulseQueue.append(pulse)
                    }
                }
            }
        }
        
        for _ in 0..<pushes {
            pushButton()
            
            loopCount += 1
            if isBackToBeginning() {
                print("Found loop after \(loopCount) tries. low \(lowPulses) high \(highPulses)")
                lowPulses *= (pushes / loopCount)
                highPulses *= (pushes / loopCount)
                break
            }
        }
        
        for _ in 0..<(pushes % loopCount) {
            pushButton()
        }

        return lowPulses * highPulses
    }
    
    func findPressesToSendLow(to: String) -> Int {
        var loopCount = 0
        
        while true {
            var pulseQueue: [Pulse] = broadcast.map{ (from: "broadcast", to: $0, high: false) }
            loopCount += 1
            
            while !pulseQueue.isEmpty {
                let pulse = pulseQueue.removeFirst()
                if pulse.to == to && !pulse.high {
                    return loopCount
                }

                if let module = modules[pulse.to] {
                    for pulse in module.trigger(pulse) {
                        pulseQueue.append(pulse)
                    }
                }
            }
        }
    }
}
