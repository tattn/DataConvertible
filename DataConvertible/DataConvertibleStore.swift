//
//  DataConvertibleStore.swift
//  DataConvertible
//
//  Created by Tatsuya Tanaka on 20180301.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

public protocol DataConvertibleStore {
    func set(_ value: DataConvertible, forKey key: String) throws
    func value<T: DataConvertible>(_ type: T.Type, forKey key: String) -> T?
}
