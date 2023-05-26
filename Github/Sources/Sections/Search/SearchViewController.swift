//
//  FilterViewController.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import UIKit

class SearchViewController: BaseViewController {
    
    // MARK: - Var
    private var layout: SearchViewControllerLayout?
    private var viewModel: SearchViewModelProvider?
    
    // MARK: - Constants
    
    // MARK: - Init
    init(viewModel: SearchViewModelProvider = SearchViewModel()) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.viewModel = SearchViewModel()
    }
    
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        layout = SearchViewControllerLayout(frame: view.frame)
        layout?.setupDelegate(delegate: self)
        guard let layout = layout else { return }
        view = layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: - Setup
    private func setup() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.title = L10n.search
    }
}

extension SearchViewController: SearchViewControllerLayoutDelegate {
    func didTapSearchUser(userName: String?) {
        view.endEditing(true)
        viewModel?.didTapSearch(userName: userName)
    }
}
