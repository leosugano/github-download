//
//  HomeViewController.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import UIKit
import UIScrollView_InfiniteScroll

class HomeViewController: HomeViewControllerLayout {
    
    // MARK: - Var
    var viewModel: HomeViewModelProvider?
    
    // MARK: - Constants
    let cellIdentifier = "UITableViewCell"
    let homeCellIdentifier = "HomeTableViewCell"

    // MARK: - Init
    init(frame: CGRect = .zero, viewModel: HomeViewModelProvider = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(frame: frame)
        self.viewModel?.delegate = self
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
        setNavigationBar(hasFilter: false)
        setupTableView()
        getDatas()
    }
    
    private func getDatas() {
        viewModel?.getDatas()
    }
    
    private func setupTableView() {
        registerTableViewCell()
        registerTableViewDelegates()
        setTableViewReload()
    }
    
    private func registerTableViewCell() {
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: homeCellIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func registerTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setTableViewReload() {
        tableView.refreshControl = self.refreshControl
                
        tableView.infiniteScrollIndicatorView = self.indicatorView
        tableView.addInfiniteScroll { [weak self] (tableView) -> Void in
            guard let self = self else { return }
            self.viewModel?.updatePagination()
            if !(self.viewModel?.isLastPage() ?? true) {
                self.viewModel?.getDatas()
            } else {
                tableView.finishInfiniteScroll()
                self.viewModel?.showLastPageAlert()
            }
        }
    }
    
    // MARK: - Actions
    override func didTapRightButton() {
        viewModel?.didTapRightButton()
    }
    
    override func didRefresh() {
        viewModel?.resetPagination()
        getDatas()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getCharacterSize() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.description(), for: indexPath) as? HomeTableViewCell else {
             return UITableViewCell()
        }
        
        guard let character = viewModel?.getCharacterByIndex(indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .gray
        cell.backgroundColor = .white
        cell.postImageURL = character.image
        cell.setupCellWithCharacter(character)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.didSelectCharaterByIndex(indexPath.row)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    
    func displayDatas() {
        self.refreshControl.endRefreshing()
        self.tableView.finishInfiniteScroll()
        self.tableView.reloadData()
    }
    
    func loadView(_ load: Bool) {
        self.showLoading(load)
    }
    
    func setNavigationBar(hasFilter: Bool) {
        let icon = hasFilter ? UIImage(named: "ic-clear-filter") : UIImage(named: "ic-filter")
        
        self.navigationBar.setupNavigationBar("characterTitle".localized,
                                              showLeftButton: false,
                                              showRightButton: true,
                                              rightIcon: icon)
    }
}
