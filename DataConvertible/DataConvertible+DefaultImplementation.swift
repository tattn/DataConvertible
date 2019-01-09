func _getJSON<T>(_ val: T, _ json: String = "", _ indent: Int = 1) -> String {
    var json = json
    json.append("{")
    let mirror = Mirror(reflecting: val)
    for child in mirror.children {
        guard let key = child.label else { continue }
        json.append("\n")
        json.append(contentsOf: repeatElement("\t", count: indent))
        if let string = child.value as? String {
            json.append("\"\(key)\":\"\(string)\"")
        } else if let int = child.value as? Int {
            json.append("\"\(key)\":\(int)")
        } else if child.value is LosslessStringConvertible {
            json.append("\"\(key)\":\"\(child.value)\"")
        } else {
            json.append("\"\(key)\":\(_getJSON(child.value, "", indent + 1))")
        }
    }
    json.append("\n\(String(repeating: "\t", count: indent - 1))}")
    return json
}

public extension Data {
  enum ConvertingError {
    case couldNotFormUTF8
  }
}


public extension DataConvertible {
  public func convertToData() throws -> Data {
    guard let data = _getJSON(self).data(using: .utf8) else {
      throw Data.ConvertingError.couldNotFormUTF8
    }
    return data
  }
}
