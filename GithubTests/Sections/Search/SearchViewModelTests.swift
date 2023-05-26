//
//  FilterViewModelTests.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import Nimble
import Quick
import UIKit
@testable import Github

class SearchViewModelTests: QuickSpec {
    
    var viewModel: SearchViewModel!
    var coordinatorStub: CoordinatorStub!

    let nav = UINavigationController()

    override func spec() {
        describe("SearchViewModelTests") {
            beforeEach {
                self.coordinatorStub = CoordinatorStub(navigationController: self.nav)
                self.viewModel = SearchViewModel()
                self.viewModel.setCoordinator(coordinator: self.coordinatorStub)
            }
            
            afterEach {
                self.coordinatorStub = nil
                self.viewModel = nil
            }
            
            context("Search View Model Routing") {
                it("Did tap Search Button") {
                    self.viewModel.didTapSearch(userName: "")
                    
                    expect(self.coordinatorStub.calledGoToDetailViewController).to(beFalse())
                }
                
                it("Did tap search with correct fields") {
                    self.viewModel.didTapSearch(userName: "leosugano")
                    
                    expect(self.coordinatorStub.calledGoToDetailViewController).to(beTrue())
                }
                
                it("Did tap search without name field") {
                    self.viewModel.didTapSearch(userName: "")
                    
                    expect(self.coordinatorStub.calledShowAlert).to(beTrue())
                    expect(self.coordinatorStub.alertMessage).to(equal("Preencha o campo userName, ele é obrigatório"))
                }
            }
        }
    }
}
