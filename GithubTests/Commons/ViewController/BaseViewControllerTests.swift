//
//  BaseViewControllerTests.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import SnapshotTesting
import XCTest
@testable import Github

class BaseViewControllerTests: XCTestCase {
    
    var keyWindow: UIWindow!
    var baseViewController: BaseViewController!
    var navigationController: UINavigationController!
    
    override func setUp() {
        self.keyWindow = UIApplication.shared.connectedScenes.compactMap({$0 as? UIWindowScene}).first?.windows.filter({$0.isKeyWindow}).first
    }
    
    override func tearDown() {
        self.navigationController = nil
        self.baseViewController = nil
        self.keyWindow = nil
    }
    
    func testBaseViewControllerWithLoad() {
        baseViewController = BaseViewController()
        navigationController = UINavigationController(rootViewController: self.baseViewController)
        
        baseViewController.title = "Snapshot test"
        baseViewController.showLoading(true)
        
        let expectation = self.expectation(description: "Snapshot view test")
        
        keyWindow?.rootViewController = self.navigationController
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            SnapshotTesting.assertSnapshot(matching: self.navigationController, as: .image)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testBaseViewControllerWithoutLoading() {
        baseViewController = BaseViewController()
        
        navigationController = UINavigationController(rootViewController: baseViewController)
        baseViewController.title = "Snapshot test"
        baseViewController.showLoading(false)
        
        navigationController.beginAppearanceTransition(true, animated: false)
        navigationController.endAppearanceTransition()
        
        let expectation = self.expectation(description: "Snapshot view test")
      
        keyWindow?.rootViewController = navigationController
        let snapshot = UIScreen.main.snapshotView(afterScreenUpdates: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            assertSnapshot(matching: snapshot, as: .image)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
