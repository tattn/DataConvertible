DataConvertible
===

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift Version](https://img.shields.io/badge/Swift-4-F16D39.svg)](https://developer.apple.com/swift)

DataConvertible is a support library for converting models to `Data`.

# How to use

## Encode / Decode

```swift
struct Model: Codable, DataConvertible {
    let string: String
    let int: Int
}

let model = Model(string: "abc", int: 123)
let data: Data = try model.convertToData()
let decoded: Model = try Model(data: data)
```

## Save to UserDefaults / Get from UserDefaults

```swift
let model = Model(string: "abc", int: 123)
try userDefaults.set(model, forKey: "model")
let saved: Model? = userDefaults.value(Model.self, forKey: "model")
```

## Adapt to other data store type

```swift
// e.g. Keychain
struct Keychain { /* implementation */ }

extension Keychain: DataConvertibleStore {
    public func set(_ value: DataConvertible, forKey key: String) throws {
        // store the value
    }

    public func value<T: DataConvertible>(_ type: T.Type = T.self, forKey key: String) -> T? {
        // get the value by the key
    }

}
```


## Conform to DataConvertible

```swift
extension YourClass: DataConvertible {
    init(data: Data) throws {
        // initialize form Data
    }
    
    func convertToData() throws -> Data {
        // convert to data
    }
}
```

If your class conforms to Codable, the class can conform to DataConvertible without any additional implementation.

# Installation

## Carthage

```ruby
github "tattn/DataConvertible"
```

# Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

# License

DataConvertible is released under the MIT license. See LICENSE for details.
