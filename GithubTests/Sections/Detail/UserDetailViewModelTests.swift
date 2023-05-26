//
//  DetailViewModelTests.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import Nimble
import Quick
import UIKit
@testable import Github

class UserDetailViewModelTests: QuickSpec {
    
    var viewModel: UserDetailViewModel!
    var service: DetailServiceStub!
    var delegate: UserDetailViewModelDelegateStub!
    var coordinatorStub: CoordinatorStub!
    var user: UserResponseModel!
    let nav = UINavigationController()
   
    override func spec() {
        describe("UserDetailViewModelTests") {
            beforeEach {
                self.user = JSONStub(UserDetailViewModelTests.self).getJson(UserResponseModel.self, fileName: "UserDetailResponse")
                self.service = DetailServiceStub()
                self.coordinatorStub = CoordinatorStub(navigationController: self.nav)
                self.delegate = UserDetailViewModelDelegateStub()
                self.viewModel = UserDetailViewModel(homeService: self.service)
                self.viewModel.setUserName(userName: self.user.name)
                self.viewModel.setCoordinator(coordinator: self.coordinatorStub)
                self.viewModel.setDelegate(delegate: self.delegate)
            }
            
            afterEach {
                self.user = nil
                self.service = nil
                self.coordinatorStub = nil
                self.delegate = nil
                self.viewModel = nil
            }
            
            context("Detail View Model Start") {
                
                it("Test get detail") {
                    self.service.success = true
                    
                    // When:
                    self.viewModel.getDetail()
                    
                    // Expect
                    expect(self.delegate.calledDisplayDetail).to(beTrue())
                    expect(self.coordinatorStub.calledDismissErrorView).to(beTrue())
                }
                
                it("Test error get detail") {
                    self.delegate.calledDisplayDetail = false
                    self.service.success = false
                    
                    self.viewModel.getDetail()
                    
                    expect(self.delegate.calledDisplayDetail).to(beFalse())
                    expect(self.coordinatorStub.calledShowErrorView).to(beTrue())
                }
            }
            
            context("Get datas in array") {
                it("get all datas") {
                    self.service.success = true
                    
                    self.viewModel.getDetail()
                    
                    expect(self.viewModel.getDetailSize()).to(equal(5))
                    expect(self.viewModel.getDetailUser()).to(equal(self.user))
                }
            }
        }
    }
}
