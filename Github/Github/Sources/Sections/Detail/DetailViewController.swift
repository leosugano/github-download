//
//  DetailViewController.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import UIKit

class DetailViewController: DetailViewControllerLayout {
    
    // MARK: - Var
    var viewModel: DetailViewModelProvider?
    
    // MARK: - Constants
    let cellIdentifier = "UITableViewCell"
    let detailCellIdentifier = "DetailTableViewCell"
    let headerDetailCellIdentifier = "HeaderDetailTableViewCell"
    
    // MARK: - Init
    init(viewModel: DetailViewModelProvider = DetailViewModel()) {
        self.viewModel = viewModel
        super.init(frame: .zero)
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
        setupNavigationBar()
        setupTableView()
        getDatas()
    }
    
    private func getDatas() {
        viewModel?.getDetail()
    }
    
    private func setupNavigationBar() {
        self.navigationBar.setupNavigationBar(showLeftButton: true,
                                              showRightButton: false)
        self.navigationBar.removeBackgroundColor()
    }
    
    private func setupTableView() {
        tableView.register(HeaderDetailTableViewCell.self, forCellReuseIdentifier: headerDetailCellIdentifier)
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: detailCellIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Actions
    override func didTapLeftButton() {
        self.viewModel?.didTapLeftButton()
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.getDetailSize() ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: headerDetailCellIdentifier, for: indexPath) as? HeaderDetailTableViewCell else {
                 return UITableViewCell()
            }
            
            guard let detailCharacterResponse = viewModel?.getDetailCharacter() else {
                return UITableViewCell()
            }
            cell.backgroundColor = .white
            cell.setupCellWithCharacter(detailCharacterResponse)
            return cell
            
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: detailCellIdentifier, for: indexPath) as? DetailTableViewCell else {
             return UITableViewCell()
        }
        
        guard let detailAtIndex = viewModel?.getDetailsAtIndex(indexPath.row - 1) else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = .white
        cell.setupCellWithCharacter(detailAtIndex)
        
        return cell
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func displayDetail() {
        self.tableView.reloadData()
    }
    
    func loadView(_ load: Bool) {
        self.showLoading(load)
    }
}
