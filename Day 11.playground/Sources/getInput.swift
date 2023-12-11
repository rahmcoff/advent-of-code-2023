import Foundation

public func getInput(fileName: String = "input") -> String {
    let filePath = Bundle.main.path(forResource: "input", ofType: "txt")!
    let contentData = FileManager.default.contents(atPath: filePath)!
    return String(data: contentData, encoding: .utf8)!
}

public func getLines(fileName: String = "input", separator: String = "\n") -> [String] {
    let content: String = getInput(fileName: fileName)
    var lines = content.split(separator: separator).map({ String($0) })
    if lines.last == "" {
        lines.removeLast()
    }
    return lines
}
