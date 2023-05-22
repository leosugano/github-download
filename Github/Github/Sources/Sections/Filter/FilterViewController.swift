//
//  FilterViewController.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import UIKit

class FilterViewController: FilterViewControllerLayout {
    
    // MARK: - Var
    var viewModel: FilterViewModelProvider?
    
    // MARK: - Constants
    
    // MARK: - Init
    init(viewModel: FilterViewModelProvider = FilterViewModel()) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: - Setup
    private func setup() {
        setupDelegate()
        setupNavigationBar()
        getDatas()
    }
    
    private func setupDelegate() {
        self.viewModel?.delegate = self
        self.statusView.delegate = self
        self.textFieldView.delegate = self
    }
    
    private func setupNavigationBar() {
        self.navigationBar.setupNavigationBar("filterTitle".localized,
                                              showLeftButton: true,
                                              showRightButton: false)
    }
    
    private func getDatas() {
        viewModel?.getStatusButtons()
    }
    
    // MARK: - Actions
    override func didTapLeftButton() {
        viewModel?.didTapLeftButton()
    }
    
    override func didTapFilter() {
        view.endEditing(true)
        viewModel?.didTapFilter()
    }
}

extension FilterViewController: FilterViewModelDelegate {
    func updateStatusViewWithStatus(status: [FilterTypeViewModel]) {
        self.statusView.setupHorizontalButton(status)
        self.view.layoutSubviews()
    }
}

extension FilterViewController: StoneStatusViewDelegate {
    func updateValue(_ value: FilterTypeViewModel?) {
        viewModel?.updateTypeSelect(currentType: value)
    }
}

extension FilterViewController: StoneTextFieldViewDelegate {
    func updateNameValue(name: String) {
        viewModel?.updateNameSelect(currentName: name)
    }
}
