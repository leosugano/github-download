//
//  HomeViewModel.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func displayDatas()
    func loadView(_ load: Bool)
}

protocol HomeViewModelProvider: AnyObject {
    func getDatas()
    func getUser(indexPath: IndexPath) -> UserResponseModel?
    func getUserSize() -> Int
    func setDelegate(delegate: HomeViewModelDelegate)
    func setCoordinator(coordinator: AppCoordinator)
    func didTapSearchButton()
    func didSelectUser(_ indexPath: IndexPath)
    func didTapUrl(_ url: String?)
}

class HomeViewModel: HomeViewModelProvider {
    
    // MARK: - Constants
    
    // MARK: - Vars
    private var currentPage: Int = 1
    private var service: HomeServiceProtocol?
    private var users: [UserResponseModel] = []
    private weak var delegate: HomeViewModelDelegate?
    private weak var coordinator: AppCoordinator?
    
    // MARK: - Init
    init(homeService: HomeServiceProtocol = HomeService()) {
        self.service = homeService
    }
    
    // MARK: - Gets
    func getDatas() {
        self.delegate?.loadView(true)
        self.service?.getUsers(completion: { [weak self] result in
            guard let self = self else { return }
            self.delegate?.loadView(false)
            switch result {
            case .success(let response):
                self.coordinator?.dismissErrorView()
                self.successResponse(response)
            case .failure(let error):
                self.coordinator?.showErrorView(error.message, showTryAgainButton: true, completion: {
                    self.getDatas()
                })
            }
        })
    }
    
    func getUser(indexPath: IndexPath) -> UserResponseModel? {
        users[indexPath.row]
    }
    
    func getUserSize() -> Int {
        return users.count
    }
    
    // MARK: - Sets
    func setDelegate(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
    }
    
    func setCoordinator(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Actions
    func didTapSearchButton() {
        self.coordinator?.goToSearchViewController()
    }
    
    func didSelectUser(_ indexPath: IndexPath) {
        let user = users[indexPath.row]
        self.coordinator?.goToDetailsViewController(user.login)
    }
    
    func didTapUrl(_ url: String?) {
        self.coordinator?.openUserURL(url: url)
    }
    
    // MARK: - Request API
    private func successResponse(_ response: [UserResponseModel]) {
        users.removeAll()
        users.append(contentsOf: response)
        self.delegate?.displayDatas()
    }
}
