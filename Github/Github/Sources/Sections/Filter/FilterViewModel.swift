//
//  FilterViewModel.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import Foundation

protocol FilterViewModelDelegate: AnyObject {
    func updateStatusViewWithStatus(status: [FilterTypeViewModel])
}

protocol FilterViewModelProvider: AnyObject {
    var delegate: FilterViewModelDelegate? { get set }
    func getStatusButtons()
    func updateTypeSelect(currentType: FilterTypeViewModel?)
    func updateNameSelect(currentName: String)
    func didTapFilter()
    func didTapLeftButton()
}

class FilterViewModel: FilterViewModelProvider {
        
    // MARK: - Var
    weak var delegate: FilterViewModelDelegate?
    weak var coordinator: AppCoordinator?
    private var selectType: FilterTypeViewModel?
    private var selectName: String = ""
    
    // MARK: - Gets
    func getStatusButtons() {
        var status: [FilterTypeViewModel] = []
        let titles = ["alive".localized, "dead".localized, "unknown".localized]
        
        for title in titles {
            status.append(FilterTypeViewModel(title: title))
        }
        
        delegate?.updateStatusViewWithStatus(status: status)
    }
    
    // MARK: - Validation
    func isValidFields() -> Bool {
        return !self.selectName.isEmpty && !(self.selectType == nil)
    }
    
    func getFields() -> FilterSelectModel {
        return FilterSelectModel(status: self.selectType?.title,
                                 name: self.selectName)
    }
    
    // MARK: - Update
    func updateNameSelect(currentName: String) {
        self.selectName = currentName
    }
    
    func updateTypeSelect(currentType: FilterTypeViewModel?) {
        self.selectType = currentType
    }
    
    // MARK: - Routing
    func didTapLeftButton() {
        coordinator?.popViewController()
    }
    
    func didTapFilter() {
        var messageError: String = ""
        
        if self.isValidFields() {
            coordinator?.popFilterViewWithValues(values: self.getFields())
            return
        }
        
        if self.selectName.isEmpty && self.selectType == nil {
            messageError = "fillFieldsError".localized
            
        } else if self.selectName.isEmpty {
            messageError = "fillNameFieldError".localized
            
        } else {
            messageError = "statusFieldError".localized
        }
        
        self.coordinator?.showAlert(message: messageError,
                                    showPositiveButton: true,
                                    titlePositiveButton: "ok".localized,
                                    showNegativeButton: false)
    }
}
