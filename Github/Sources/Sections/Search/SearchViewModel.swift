//
//  FilterViewModel.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import Foundation

protocol SearchViewModelProvider: AnyObject {
    func setCoordinator(coordinator: AppCoordinator)
    func didTapSearch(userName: String?)
}

class SearchViewModel: SearchViewModelProvider {
        
    // MARK: - Var
    private weak var coordinator: AppCoordinator?
        
    // MARK: - SearchViewModelProvider - Sets
    func setCoordinator(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Routing
    func didTapSearch(userName: String?) {
        if userName?.isEmpty ?? true {
            let messageError = L10n.fillNameFieldError
            self.coordinator?.showAlert(message: messageError,
                                        titlePositiveButton: L10n.ok)
        } else {
            coordinator?.goToDetailsViewController(userName)
        }
    }
}
