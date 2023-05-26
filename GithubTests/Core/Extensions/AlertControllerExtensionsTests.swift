//
//  AlertControllerExtensionsTests.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import Nimble
import Quick
import UIKit
import SnapshotTesting
@testable import Github

class AlertControllerExtensionTests: XCTestCase {

    var alert: UIAlertController!

    override func setUp() {
        super.setUp()

        alert = UIAlertController.createAlert(message: "teste alert", titlePositiveButton: "alert error")
        alert.view.frame = CGRect(x: 0, y: 0, width: 300, height: 120)
    }
    
    override func tearDown() {
        super.tearDown()
        self.alert = nil
    }
    
    func testCreationAlert() {
        expect(self.alert.actions.count).to(equal(1))
    }
    
    func testAlertView() {
        let expectation = self.expectation(description: "Snapshot view test")
                
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            assertSnapshot(matching: self.alert, as: .image)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
    }
}
