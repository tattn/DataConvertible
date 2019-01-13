import Foundation

func _getJSON<T>(_ val: T, _ indentString: String = "\t", _ indent: Int = 1) -> String {
    var json = ""
    json.append("{")
    if let description = val as? LosslessStringConvertible {
        json.append("\n\"value\":\"\(description)\"\n}")
    } else {
        let mirror = Mirror(reflecting: val)
        for child in mirror.children {
            guard let key = child.label else { continue }
            json.append("\n")
            for indent in repeatElement(indentString, count: indent) {
                json.append(indent)
            }
            if let string = child.value as? String {
                json.append("\"\(key)\":\"\(string)\"")
            } else if let int = child.value as? Int {
                json.append("\"\(key)\":\(int)")
            } else if child.value is LosslessStringConvertible {
                json.append("\"\(key)\":\"\(child.value)\"")
            } else {
                json.append("\"\(key)\":\(_getJSON(child.value, indentString, indent + 1))")
            }
        }
        json.append("\n\(String(repeating: indentString, count: indent - 1))}")
    }
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
