//
//  FilterViewControllerTests.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import UIKit
import XCTest
import SnapshotTesting
@testable import Github

class FilterViewControllerTests: XCTestCase {

    var delegate: HomeViewModelDelegateStub!
    var nav: UINavigationController!
    var keyWindow: UIWindow!
    var navigationController: UINavigationController!
    var coordinator: AppCoordinator!
    
    override func setUp() {
        self.keyWindow = UIApplication.shared.connectedScenes.compactMap({$0 as? UIWindowScene}).first?.windows.filter({$0.isKeyWindow}).first
        
        self.navigationController = UINavigationController()
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.coordinator = AppCoordinator(navigationController: self.navigationController)
    }
    
    override func tearDown() {
        self.navigationController = nil
        self.keyWindow = nil
    }
    
    func testFilterViewControllerCalledByCoordinator() {
        coordinator.goToSearchViewController()
        
        keyWindow?.rootViewController = self.navigationController

        let expectation = self.expectation(description: "Snapshot view test")
                
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            SnapshotTesting.assertSnapshot(matching: self.navigationController, as: .image)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
