//
//  HomeViewControllerLayout.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import SnapKit
import UIKit

protocol HomeViewControllerLayoutDelegate: AnyObject {
    func didTapRefresh()
}

class HomeViewControllerLayout: UIView {
    
    // MARK: - Outlets
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = .black
        refresh.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        return refresh
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
        setupBackground()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        setConstraints()
        setupBackground()
    }
    
    // MARK: - Set SubView
    func addSubviews() {
        addSubview(tableView)
    }
    
    // MARK: - SetConstraints
    func setConstraints() {
        setTableViewConstraints()
    }
    
    private func setTableViewConstraints() {
        tableView.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Margin.extraMargin)
            make.bottom.equalToSuperview().inset(Margin.getSafeAreas().bottom)
        }
    }
    
    private func setupBackground() {
        backgroundColor = .white
    }
    
    // MARK: - Vars
    weak var delegate: HomeViewControllerLayoutDelegate?
    
    // MARK: - Public Funcs
    func setupDelegate(delegate: HomeViewControllerLayoutDelegate?) {
        self.delegate = delegate
    }
    
    func setupTableView(tableViewDelegate: UITableViewDelegate,
                        tableViewDataSource: UITableViewDataSource) {
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
        tableView.refreshControl = refreshControl
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func stopLoading() {
        refreshControl.endRefreshing()
    }
    
    @objc private func didRefresh() {
        delegate?.didTapRefresh()
    }
}
