//
//  HomeViewController.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: - Var
    private var layout: HomeViewControllerLayout?
    private var viewModel: HomeViewModelProvider?
    
    // MARK: - Constants

    // MARK: - Init
    init(viewModel: HomeViewModelProvider = HomeViewModel()) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel?.setDelegate(delegate: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.viewModel = HomeViewModel()
    }
    
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        layout = HomeViewControllerLayout(frame: view.frame)
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
        setupTableView()
        setupNavigationBar()
        viewModel?.getDatas()
    }
    
    private func setupTableView() {
        layout?.setupTableView(tableViewDelegate: self,
                               tableViewDataSource: self)
    }
    
    private func setupNavigationBar() {
        title = L10n.home
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc func searchTapped() {
        viewModel?.didTapSearchButton()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getUserSize() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: HomeTableViewCell.self, indexPath: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        
        guard let user = viewModel?.getUser(indexPath: indexPath) else {
            return cell
        }
        
        cell.setupDelegate(delegate: self)
        cell.setupCell(user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.didSelectUser(indexPath)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    
    func displayDatas() {
        layout?.reloadData()
    }
    
    func loadView(_ load: Bool) {
        self.showLoading(load)
        layout?.stopLoading()
    }
}

extension HomeViewController: HomeTableViewCellDelegate {
    func didSelectOpenUrl(userUrl: String?) {
        viewModel?.didTapUrl(userUrl)
    }
}

extension HomeViewController: HomeViewControllerLayoutDelegate {
    func didTapRefresh() {
        viewModel?.getDatas()
    }
}
