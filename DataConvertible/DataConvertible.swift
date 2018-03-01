//
//  DataConvertible.swift
//  DataConvertible
//
//  Created by Tatsuya Tanaka on 20180203.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

public protocol DataConvertible {
    init(data: Data) throws
    func convertToData() throws -> Data
}

public extension DataConvertible where Self: Decodable {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: data)
    }
}

public extension DataConvertible where Self: Encodable {
    func convertToData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}

