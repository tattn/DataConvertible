//
//  UserDefaults+.swift
//  DataConvertible
//
//  Created by Tatsuya Tanaka on 20180203.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

public extension UserDefaults {
    func set(_ value: DataConvertible, forKey key: String) throws {
        let data = try value.convertToData()
        set(data, forKey: key)
    }

    func value<T: DataConvertible>(_ type: T.Type = T.self, forKey key: String) -> T? {
        let data = self.data(forKey: key)
        let value: T?? = try? data.map(T.init)
        return value.flatMap { $0 }
    }
}
