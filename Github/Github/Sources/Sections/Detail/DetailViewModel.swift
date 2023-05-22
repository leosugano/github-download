//
//  DetailViewModel.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//


import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func displayDetail()
    func loadView(_ load: Bool)
}

protocol DetailViewModelProvider: AnyObject {
    var delegate: DetailViewModelDelegate? { get set }
    func getDetail()
    func getDetailCharacter() -> CharacterDatasResponseModel?
    func getDetailsAtIndex(_ index: Int) -> DetailViewModelResponse?
    func getDetailSize() -> Int
    func didTapLeftButton()
    func setCharacter(_ character: CharacterDatasResponseModel?)
}

class DetailViewModel: DetailViewModelProvider {
    
    // MARK: - Constants
    
    // MARK: - Vars
    private var character: CharacterDatasResponseModel?
    private var service: DetailServiceProtocol?
    private var detailCharacterModel: CharacterDatasResponseModel?
    private var detailsCharacter: [DetailViewModelResponse] = []
    weak var delegate: DetailViewModelDelegate?
    var coordinator: AppCoordinator?
    
    // MARK: - Init
    init(homeService: DetailServiceProtocol = DetailService()) {
        self.service = homeService
    }
    
    // MARK: - Gets
    func getDetail() {
        self.coordinator?.dismissErrorView()
        self.delegate?.loadView(true)
        self.service?.getCharacterDetail(url: Keys.caractersURL, id: self.character?.id ?? 0, completion: { [weak self] result in
            guard let self = self else { return }
            self.delegate?.loadView(false)
            switch result {
            
            case .success(let response):
                self.getSuccessWithDetail(response)
            
            case .failure(let error):
                self.getErrorWithDetail(error)
            }
        })
    }
    
    private func getSuccessWithDetail(_ response: CharacterDatasResponseModel) {
        self.detailCharacterModel = response
        self.createArrayWithDetails(response)
        self.delegate?.displayDetail()
    }
    
    private func getErrorWithDetail(_ error: NetworkError) {
        let showTryAgain = error.code == Keys.errorCodeNoDatabase ? false : true
        self.coordinator?.showErrorView(error.message, showTryAgainButton: showTryAgain, completion: {
            self.getDetail()
        })
    }
    
    func getDetailCharacter() -> CharacterDatasResponseModel? {
        return self.detailCharacterModel
    }
    
    func getDetailsAtIndex(_ index: Int) -> DetailViewModelResponse? {
        return index < detailsCharacter.count ? detailsCharacter[index] : nil
    }
    
    func getDetailSize() -> Int {
        return detailsCharacter.count
    }
    
    func setCharacter(_ character: CharacterDatasResponseModel?) {
        self.character = character
    }
    
    // MARK: - Private functions
    private func createArrayWithDetails(_ detail: CharacterDatasResponseModel) {
        self.detailsCharacter.removeAll()
        
        putFieldInDetails(nameField: "statusTitle".localized, field: detail.status)
        putFieldInDetails(nameField: "specieTitle".localized, field: detail.species)
        putFieldInDetails(nameField: "typeTitle".localized, field: detail.type)
        putFieldInDetails(nameField: "genderTitle".localized, field: detail.gender)
        putFieldInDetails(nameField: "origeTitle".localized, field: detail.origin?.name)
        putFieldInDetails(nameField: "localizationTitle".localized, field: detail.location?.name)
        putFieldInDetails(nameField: "createdTitle".localized, field: maskDate(detail.created))
    }
    
    private func putFieldInDetails(nameField: String, field: String?) {
        if let field = field, !field.isEmpty {
            let newElement = DetailViewModelResponse(title: nameField, value: field)
            detailsCharacter.append(newElement)
        }
    }
    
    private func maskDate(_ date: String?) -> String {
        guard let date = date,
              let newDate = date.getDate(format: Keys.isoDateFormat) else {
            return Date().convertToString(format: Keys.ptDateFormat)
        }
        
        return newDate.convertToString(format: Keys.ptDateFormat)
    }
    
    // MARK: - Actions
    func didTapLeftButton() {
        coordinator?.popViewController()
    }
}
