//
//  DetailViewControllerTests.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import UIKit
import XCTest
import SnapshotTesting
@testable import Github

class UserDetailViewControllerTests: XCTestCase {

    var keyWindow: UIWindow!
    var navigationController: UINavigationController!
    var viewController: UserDetailViewController!
    var viewModel: UserDetailViewModel!
    var detailStub: DetailServiceStub!
    var coordinator: AppCoordinator!
    var user: UserResponseModel!
    
    override func setUp() {
        UIImage.imageCache.removeAllObjects()
        keyWindow = UIApplication.shared.connectedScenes.compactMap({$0 as? UIWindowScene}).first?.windows.filter({$0.isKeyWindow}).first
        
        navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        coordinator = AppCoordinator(navigationController: navigationController)
    }
    
    override func tearDown() {
        viewModel = nil
        detailStub = nil
        user = nil
        navigationController = nil
        keyWindow = nil
        coordinator = nil
    }
    
    func testDetailViewControllerUI() {
        detailStub = DetailServiceStub()
        detailStub.success = true
        viewModel = UserDetailViewModel(homeService: detailStub)
        viewModel.setCoordinator(coordinator: coordinator)
        viewController = UserDetailViewController(viewModel: viewModel)
        
        navigationController.setViewControllers([viewController], animated: false)
        
        XCTAssertNotNil(navigationController.topViewController)
        
        viewController.viewDidLoad()
        let expectation = expectation(description: "Snapshot view test")
                
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            SnapshotTesting.assertSnapshot(matching: self.navigationController, as: .image)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDetailWithData() {
        detailStub = DetailServiceStub()
        detailStub.success = true
        viewModel = UserDetailViewModel(homeService: detailStub)
        viewModel.setCoordinator(coordinator: coordinator)
        viewController = UserDetailViewController(viewModel: viewModel)
        
        navigationController.setViewControllers([viewController], animated: false)
        
        XCTAssertNotNil(navigationController.topViewController)
        
        viewModel.getDetail()
        let expectation = expectation(description: "Snapshot view test")
                
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            SnapshotTesting.assertSnapshot(matching: self.navigationController, as: .image)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 8, handler: nil)
    }
    
    func testDetailWithError() {
        detailStub = DetailServiceStub()
        detailStub.success = false
        user = JSONStub(UserDetailViewControllerTests.self).getJson(UserResponseModel.self, fileName: "UserDetailResponse")
        
        viewModel = UserDetailViewModel(homeService: detailStub)
        viewModel.setCoordinator(coordinator: coordinator)
        viewController = UserDetailViewController(viewModel: viewModel)
        
        navigationController.setViewControllers([viewController], animated: false)
        
        XCTAssertNotNil(navigationController.topViewController)
        
        viewController.viewDidLoad()
        let expectation = expectation(description: "Snapshot view test")
                
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            SnapshotTesting.assertSnapshot(matching: self.navigationController, as: .image)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
