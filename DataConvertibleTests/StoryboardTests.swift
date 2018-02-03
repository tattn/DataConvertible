//
//  StoryboardTests.swift
//  DataConvertibleTests
//
//  Created by Tatsuya Tanaka on 20180203.
//  Copyright © 2018年 tattn. All rights reserved.
//

import XCTest
import DataConvertible

final class UserProfileViewController: UIViewController, Codable, DataConvertible {
    @IBOutlet weak var userNameLabel: UILabel! {
        didSet {
            userNameLabel.text = userName
        }
    }

    enum CodingKeys: CodingKey {
        case userName
    }

    var userName: String!

    static func instantiate() -> UserProfileViewController {
        let storyboard = UIStoryboard(name: "UserProfileViewController", bundle: Bundle(for: StoryboardTests.self))
        return storyboard.instantiateInitialViewController() as! UserProfileViewController
    }
}

extension Decodable where Self: UserProfileViewController {
    init(from decoder: Decoder) throws {
        self = Self.instantiate() as! Self
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userName = try container.decode(String.self, forKey: .userName)
    }
}

class StoryboardTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEncodeAndDecode() throws {
        let vc = UserProfileViewController.instantiate()
        vc.userName = "abc"
        _ = vc.view

        let data = try vc.convertToData()
        let _vc = try UserProfileViewController(data: data)
        _ = _vc.view
        XCTAssertEqual(_vc.userName, vc.userName)
        XCTAssertEqual(_vc.userNameLabel.text, vc.userNameLabel.text)
    }

    func testSaveAndLoad() throws {
        let vc = UserProfileViewController.instantiate()
        vc.userName = "abc"
        _ = vc.view

        try UserDefaults.standard.set(vc, forKey: "vc")
        let _vc = UserDefaults.standard.value(UserProfileViewController.self, forKey: "vc")!
        _ = _vc.view
        XCTAssertEqual(_vc.userName, vc.userName)
        XCTAssertEqual(_vc.userNameLabel.text, vc.userNameLabel.text)
    }
}
