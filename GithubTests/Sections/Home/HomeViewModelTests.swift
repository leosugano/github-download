//
//  HomeViewControllerTests.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import Nimble
import Quick
import UIKit
@testable import Github

class HomeViewModelTests: QuickSpec {
    
    var viewModel: HomeViewModel!
    var service: HomeServiceStub!
    var delegate: HomeViewModelDelegateStub!
    var coordinatorStub: CoordinatorStub!
    let nav: UINavigationController = UINavigationController()

    override func spec() {
        describe("HomeViewModelTests") {
            
            beforeEach {
                self.coordinatorStub = CoordinatorStub(navigationController: self.nav)
                self.delegate = HomeViewModelDelegateStub()
                self.service = HomeServiceStub()
                self.viewModel = HomeViewModel(homeService: self.service)
                self.viewModel.setCoordinator(coordinator: self.coordinatorStub)
                self.viewModel.setDelegate(delegate: self.delegate)
            }
            
            afterEach {
                self.coordinatorStub = nil
                self.delegate = nil
                self.service = nil
                self.viewModel = nil
            }
            
            context("Test Get Data Request") {
                it("Test Get Data") {
                    // Given:
                    self.service.success = true
                    
                    // When:
                    self.viewModel.getDatas()
                    
                    // Expected:
                    expect(self.coordinatorStub.calledDismissErrorView).to(beTrue())
                    expect(self.delegate.calledLoadView).to(beTrue())
                    expect(self.delegate.calledDiplayDatas).to(beTrue())
                }
                
                it("Test Get Data with Error") {
                    // Given:
                    self.service.success = false
                    
                    // When:
                    self.viewModel.getDatas()

                    // Then:
                    expect(self.coordinatorStub.calledShowErrorView).to(beTrue())
                    expect(self.coordinatorStub.errorMessage).to(equal("Error mock"))
                    expect(self.coordinatorStub.showedTryAgainButton).to(beTrue())
                }
            }
            
            context("Testing routing") {
                it("Test didSelect character by id") {
                    // Given:
                    self.service.success = true
                    let json = JSONStub(HomeViewModelTests.self)
                    let first = json.getJson([UserResponseModel].self, fileName: "UserHomeResponse")?.first
                    
                    // When:
                    self.viewModel.getDatas()
                    self.viewModel.didSelectUser(IndexPath(row: 0, section: 0))
                    
                    // Expect:
                    expect(self.coordinatorStub.calledGoToDetailViewController).to(beTrue())
                    expect(self.coordinatorStub.userName).to(equal(first?.login))
                }
            }
        }
    }
}
