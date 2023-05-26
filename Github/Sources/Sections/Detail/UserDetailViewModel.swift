//
//  DetailViewModel.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import Foundation

protocol UserDetailViewModelDelegate: AnyObject {
    func displayDetail()
    func loadView(_ load: Bool)
}

protocol UserDetailViewModelProvider: AnyObject {
    func getDetail()
    func getDetailUser() -> UserResponseModel?
    func getUserRepository(_ index: Int) -> UserRepositoryResponseViewModel
    func getDetailSize() -> Int
    func setDelegate(delegate: UserDetailViewModelDelegate?)
    func setUserName(userName: String?)
    func setCoordinator(coordinator: AppCoordinator)
    func didTapUserUrl(_ url: String?)
}

class UserDetailViewModel: UserDetailViewModelProvider {
    
    // MARK: - Constants
    
    // MARK: - Vars
    private var user: UserResponseModel?
    private var userName: String?
    private var service: DetailServiceProtocol?
    private var userRepository: [UserRepositoryResponseViewModel] = []
    private weak var delegate: UserDetailViewModelDelegate?
    private var coordinator: AppCoordinator?
    private var errorCalled: Bool = false
    
    // MARK: - Init
    init(homeService: DetailServiceProtocol = DetailService()) {
        self.service = homeService
    }
    
    // MARK: - DetailViewModel Provider - Get
    func getDetail() {
        let group = DispatchGroup()

        coordinator?.dismissErrorView()
        delegate?.loadView(true)
        
        group.enter()
        getUserDetail {
            group.leave()
        }
        
        group.enter()
        getUserRepos {
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            if !self.errorCalled {
                self.delegate?.loadView(false)
                self.delegate?.displayDetail()
            }
        }
    }
    
    private func getUserDetail(completion: @escaping () -> Void) {
        service?.getUserDetail(userName: userName ?? "", completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.user = response
                completion()
            case .failure(let error):
                if !self.errorCalled {
                    self.getErrorWithDetail(error)
                }
                completion()
            }
        })
    }
    
    private func getUserRepos(completion: @escaping () -> Void) {
        service?.getUserRepos(userName: userName ?? "", completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.userRepository = response
                completion()
            case .failure(let error):
                if !self.errorCalled {
                    self.getErrorWithDetail(error)
                }
                completion()
            }
        })
    }
    
    private func getErrorWithDetail(_ error: NetworkError) {
        self.errorCalled = true
        coordinator?.showErrorView(error.message, showTryAgainButton: true, completion: {
            self.getDetail()
        })
    }
    
    func getDetailUser() -> UserResponseModel? {
        return user
    }
    
    func getUserRepository(_ index: Int) -> UserRepositoryResponseViewModel {
        return userRepository[index]
    }
    
    func getDetailSize() -> Int {
        return userRepository.count + 1
    }
    
    // MARK: - DetailViewModel Provider - Sets
    func setDelegate(delegate: UserDetailViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func setUserName(userName: String?) {
        self.userName = userName
    }
    
    func setCoordinator(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }

    // MARK: - DetailViewModel Provider - Actions
    func didTapUserUrl(_ url: String?) {
        coordinator?.openUserURL(url: url)
    }
}
