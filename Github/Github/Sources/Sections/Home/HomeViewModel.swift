//
//  HomeViewModel.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func displayDatas()
    func setNavigationBar(hasFilter: Bool)
    func loadView(_ load: Bool)
}

protocol HomeViewModelProvider: AnyObject {
    var delegate: HomeViewModelDelegate? { get set }
    func getDatas()
    func getCharacterSize() -> Int
    func getCharacterByIndex(_ index: Int) -> CharacterDatasResponseModel?
    func didSelectCharaterByIndex(_ index: Int)
    func updateFilterValues(_ values: FilterSelectModel?)
    func didTapRightButton()
    func updatePagination()
    func resetPagination()
    func showLastPageAlert()
    func isLastPage() -> Bool
}

class HomeViewModel: HomeViewModelProvider {
    
    // MARK: - Constants
    
    // MARK: - Vars
    private var currentPage: Int = 1
    private var service: HomeServiceProtocol?
    private var info: CharacterInfoResponseModel?
    private var characters: [CharacterDatasResponseModel] = []
    private var saveCharacters: [CharacterDatasResponseModel] = []
    private var filter: FilterSelectModel?
    weak var delegate: HomeViewModelDelegate?
    weak var coordinator: AppCoordinator?
    
    // MARK: - Init
    init(homeService: HomeServiceProtocol = HomeService()) {
        self.service = homeService
    }
    
    // MARK: - Gets
    func getDatas() {
        if (UserDefaults.standard.bool(forKey: Keys.userDefaultNoInternet)) {
            self.resetPagination()
        }
        
        self.delegate?.setNavigationBar(hasFilter: self.filter != nil)
        
        if currentPage == 1 {
            self.delegate?.loadView(true)
        }

        if filter == nil {
            self.getCaractersDatas()
        } else {
            self.getCharactersDatasWithFilter()
        }
    }
    
    private func getCaractersDatas() {
        let parameters = FilterSelectModel(page: self.currentPage)
        
        self.service?.getCharacters(url: Keys.caractersURL, parameters: parameters, completion: { [weak self] result in
            guard let self = self else { return }
            self.delegate?.loadView(false)
            switch result {
            case .success(let response):
                self.coordinator?.dismissErrorView()
                self.info = response.info
                self.successResponse(response.characters ?? [])
            case .failure(let error):
                self.coordinator?.showErrorView(error.message, showTryAgainButton: true, completion: {
                    self.getDatas()
                })
            }
        })
    }
    
    private func getCharactersDatasWithFilter() {
        self.filter?.page = self.currentPage
        guard let filter = self.filter else { return }
        
        self.service?.getCharactersWithFilter(url: Keys.caractersURL, filter: filter, completion: { [weak self] result in
            guard let self = self else { return }
            self.delegate?.loadView(false)

            switch result {
            case .success(let response):
                self.coordinator?.dismissErrorView()
                self.info = response.info
                self.successResponse(response.characters ?? [])
              
            case .failure(let error):
                let showTryAgain = error.code == Keys.errorCodeNoDatabase ? false : true
                self.coordinator?.showErrorView(error.message, showTryAgainButton: showTryAgain, completion: {
                    self.getDatas()
                })
            }
        })
    }
    
    private func successResponse(_ response: [CharacterDatasResponseModel]) {
        self.characters.append(contentsOf: response)
        if !(UserDefaults.standard.bool(forKey: Keys.userDefaultNoInternet)) {
            DatabaseController.deleteAllDatas()
            DatabaseController.addCaracterAndLastPage(self.characters, lastPage: self.currentPage)
            DatabaseController.saveContext()
        }
        self.delegate?.displayDatas()
    }
    
    func getCharacterSize() -> Int {
        return self.characters.count
    }
    
    func getCharacterByIndex(_ index: Int) -> CharacterDatasResponseModel? {
        guard self.characters.count > 0, index < characters.count else {
            return nil
        }
        
        return characters[index]
    }
    
    func updateFilterValues(_ values: FilterSelectModel?) {
        self.resetPagination()
        self.filter = values
    }
    
    func updatePagination() {
        self.currentPage += 1
    }
    
    func resetPagination() {
        self.characters.removeAll()
        self.currentPage = 1
    }
    
    func isLastPage() -> Bool {
        return self.currentPage > (self.info?.pages ?? 0)
    }
    
    func showLastPageAlert() {
        var message: String = "lastDatasMessage".localized
        
        if (UserDefaults.standard.bool(forKey: Keys.userDefaultNoInternet)) {
            message = "turnOnInternet".localized
        }
        self.coordinator?.showAlert(message: message, titlePositiveButton: "ok".localized, showNegativeButton: false)
    }
    
    // MARK: - Actions
    func didTapRightButton() {
        if self.filter == nil {
            self.coordinator?.goToFilterViewController()

        } else {
            self.coordinator?.showAlert(message: "alertRemoveFilterTitle".localized, {
                [weak self] in
                guard let self = self else { return }
                self.filter = nil
                self.resetPagination()
                self.getDatas()
            })
        }
    }

    func didSelectCharaterByIndex(_ index: Int) {
        coordinator?.goToDetailsViewController(getCharacterByIndex(index))
    }
}
