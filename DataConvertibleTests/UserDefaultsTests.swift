//
//  UserDefaultsTests.swift
//  DataConvertibleTests
//
//  Created by Tatsuya Tanaka on 20180203.
//  Copyright © 2018年 tattn. All rights reserved.
//

import XCTest
import DataConvertible

class UserDefaultsTests: XCTestCase {

    private let userDefaults = UserDefaults.standard

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

    func testSetAndGet() throws {
        let model = Model(string: "abc", int: 123)
        try userDefaults.set(model, forKey: "model")
        let _model = userDefaults.value(Model.self, forKey: "model")!
        XCTAssertEqual(_model.string, model.string)
        XCTAssertEqual(_model.int, model.int)
    }

}
