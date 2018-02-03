//
//  DataConvertibleTests.swift
//  DataConvertibleTests
//
//  Created by Tatsuya Tanaka on 20180203.
//  Copyright © 2018年 tattn. All rights reserved.
//

import XCTest
import DataConvertible

class DataConvertibleTests: XCTestCase {

    struct Model: Codable, DataConvertible {
        let string: String
        let int: Int
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEncodeAndDecode() throws {
        let model = Model(string: "abc", int: 123)
        let data = try model.convertToData()
        let decoded = try Model(data: data)
        XCTAssertEqual(decoded.string, decoded.string)
        XCTAssertEqual(decoded.int, decoded.int)
    }
    
}
