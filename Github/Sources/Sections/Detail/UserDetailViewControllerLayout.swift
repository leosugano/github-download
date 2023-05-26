//
//  DetailViewControllerLayout.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import UIKit
import SnapKit

class UserDetailViewControllerLayout: UIView {
    
    // MARK: - Outlets
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
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
    private func addSubviews() {
        addSubview(tableView)
    }
    
    // MARK: - SetConstraints
    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Margin.extraMargin)
            make.trailing.leading.equalToSuperview().inset(Margin.extraMargin)
            make.bottom.equalToSuperview().inset(Margin.getSafeAreas().bottom)
        }
    }
    
    private func setupBackground() {
        backgroundColor = .white
    }
    
    // MARK: - Public Func
    func setupTableView(delegate: UITableViewDelegate,
                        datasource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = datasource
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}
