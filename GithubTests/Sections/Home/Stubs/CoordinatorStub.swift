//
//  CoordinatorStub.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import SnapshotTesting
import XCTest
@testable import Github

class CoordinatorStub: AppCoordinator {
    
    // MARK: - Vars
    var userName: String? = ""
    var calledStart: Bool = false
    var calledOpenURL: Bool = false
    var calledShowAlert: Bool = false
    var calledShowErrorView: Bool = false
    var calledDismissErrorView: Bool = false
    var calledGoToHomeViewController: Bool = false
    var calledGoToDetailViewController: Bool = false
    var calledGoToSearchViewController: Bool = false
    var showedTryAgainButton: Bool = false
    var errorMessage: String? = ""
    var alertMessage: String = ""
    
    // MARK: - Routing
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        calledStart = true
    }
    
    override func goToHomeViewController(homeViewModel: HomeViewModelProvider = HomeViewModel()) {
        calledGoToHomeViewController = true
    }
    
    override func goToDetailsViewController(detailViewModel: UserDetailViewModelProvider = UserDetailViewModel(),
                                            _ userName: String?) {
        calledGoToDetailViewController = true
        self.userName = userName
    }
    
    override func goToSearchViewController(searchViewModel: SearchViewModelProvider = SearchViewModel()) {
        calledGoToSearchViewController = true
    }
    
    override func openUserURL(url: String?) {
        calledOpenURL = true
    }
    
    override func showAlert(message: String,
                            titlePositiveButton: String = "",
                            _ completion: (() -> Void)? = nil) {
        alertMessage = message
        calledShowAlert = true
    }
    
    override func showErrorView(_ message: String?,
                                showTryAgainButton: Bool,
                                completion: (() -> Void)? = nil) {
        calledShowErrorView = true
        showedTryAgainButton = showTryAgainButton
        self.errorMessage = message
    }
    
    override func dismissErrorView() {
        calledDismissErrorView = true
    }
}
