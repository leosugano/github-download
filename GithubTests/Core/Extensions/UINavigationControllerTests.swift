//
//  UINavigationControllerTests.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import XCTest
import UIKit
import SnapshotTesting
@testable import Github

class UINavigationControllerTests: XCTestCase {
    
    var navigationController: GithubNavigationViewController!
    var firstViewController: UIViewController!

    override func setUp() {
        super.setUp()
        self.firstViewController = UIViewController()
        self.firstViewController.title = "teste snapshot"
        self.navigationController = GithubNavigationViewController(rootViewController: self.firstViewController)
    }
    
    override func tearDown() {
        super.tearDown()
        self.navigationController = nil
        self.firstViewController = nil
    }
    
    func testNavigationController() {
        assertSnapshot(matching: self.navigationController, as: .image)
    }
    
}
