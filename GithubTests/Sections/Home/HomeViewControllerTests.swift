//
//  HomeViewControllerTests.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import UIKit
import XCTest
import SnapshotTesting
@testable import Github

class HomeViewControllerTests: XCTestCase {

    var viewController: HomeViewController!
    var viewModel: HomeViewModel!
    var service: HomeServiceStub!
    var delegate: HomeViewModelDelegateStub!
    var nav: UINavigationController!
    var keyWindow: UIWindow!
    var navigationController: UINavigationController!
    var coordinator: AppCoordinator!
    
    override func setUp() {
        self.keyWindow = UIApplication.shared.connectedScenes.compactMap({$0 as? UIWindowScene}).first?.windows.filter({$0.isKeyWindow}).first
        self.service = HomeServiceStub()
        self.viewModel = HomeViewModel(homeService: self.service)
        self.navigationController = UINavigationController()
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.coordinator = AppCoordinator(navigationController: self.navigationController)
    }
    
    override func tearDown() {
        self.viewController = nil
        self.navigationController = nil
        self.viewModel = nil
        self.keyWindow = nil
    }
    
    func testHomeViewControllerWithSuccess() {
        self.service.success = true
        coordinator.goToHomeViewController(homeViewModel: self.viewModel)
        
        let expectation = self.expectation(description: "Snapshot view test")
        
        keyWindow?.rootViewController = self.navigationController
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            SnapshotTesting.assertSnapshot(matching: self.navigationController, as: .image)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testHomeViewControllerWithError() {
        self.service.success = false
        self.viewModel.setCoordinator(coordinator: coordinator)
        self.viewController = HomeViewController(viewModel: self.viewModel)
            
        self.navigationController.setViewControllers([self.viewController], animated: false)
            
        XCTAssertNotNil(self.navigationController.topViewController)
            
        self.viewController.viewDidLoad()
        let expectation = self.expectation(description: "Snapshot view test")
                    
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            SnapshotTesting.assertSnapshot(matching: self.navigationController, as: .image)
            expectation.fulfill()
        }
            
        waitForExpectations(timeout: 5, handler: nil)
    }
}
