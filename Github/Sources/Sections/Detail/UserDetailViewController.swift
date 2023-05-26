//
//  DetailViewController.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import UIKit

class UserDetailViewController: BaseViewController {
    
    // MARK: - Var
    private var layout: UserDetailViewControllerLayout?
    private var viewModel: UserDetailViewModelProvider?
    
    // MARK: - Init
    init(viewModel: UserDetailViewModelProvider = UserDetailViewModel()) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel?.setDelegate(delegate: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        layout = UserDetailViewControllerLayout(frame: view.frame)
        layout?.setupTableView(delegate: self,
                               datasource: self)
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
        getDatas()
    }
    
    private func getDatas() {
        viewModel?.getDetail()
    }
    
    private func setupNavigationBar() {
        self.title = L10n.detailUser
    }
}

extension UserDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.getDetailSize() ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let user = viewModel?.getDetailUser() else {
            let cell = tableView.dequeueReusableCell(for: UITableViewCell.self, indexPath: indexPath)
            return cell
        }
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(for: HeaderDetailTableViewCell.self, indexPath: indexPath)
            cell.backgroundColor = .white
            cell.setupCellWithCharacter(delegate: self, user: user)
            return cell
        }
         
        guard let repo = viewModel?.getUserRepository(indexPath.row - 1) else {
            let cell = tableView.dequeueReusableCell(for: UITableViewCell.self, indexPath: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(for: DetailTableViewCell.self, indexPath: indexPath)
        cell.backgroundColor = .white
        cell.setupCellWithDetails(repo: repo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            viewModel?.didTapUserUrl(viewModel?.getUserRepository(indexPath.row - 1).svnUrl)
        }        
    }
}

extension UserDetailViewController: HeaderDetailTableViewCellDelegate {
    func didTapUserUrl(url: String?) {
        viewModel?.didTapUserUrl(url)
    }
}

extension UserDetailViewController: UserDetailViewModelDelegate {
    func displayDetail() {
        layout?.reloadData()
    }
    
    func loadView(_ load: Bool) {
        self.showLoading(load)
    }
}
