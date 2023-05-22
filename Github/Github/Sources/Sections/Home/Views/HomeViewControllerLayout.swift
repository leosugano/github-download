//
//  HomeViewControllerLayout.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import SnapKit
import UIKit

class HomeViewControllerLayout: BaseViewController {
    
    // MARK: - Outlets
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = UIColor(named: "MainColor")
        refresh.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        return refresh
    }()
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = UIColor(named: "MainColor")
        return indicator
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        setConstraints()
    }
    
    // MARK: - Set SubView
    override func addSubviews() {
        super.addSubviews()
        self.view.addSubview(tableView)
    }
    
    // MARK: - SetConstraints
    override func setConstraints() {
        super.setConstraints()
        setTableViewConstraints()
    }
    
    private func setTableViewConstraints() {
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.equalToSuperview().inset(Margin.getSafeAreas().left)
            make.trailing.equalToSuperview().inset(Margin.getSafeAreas().right)
            make.bottom.equalToSuperview().inset(Margin.getSafeAreas().bottom)
        }
    }
    
    override func rotated() {
        super.rotated()
        
        DispatchQueue.main.async {
            self.setTableViewConstraints()
        }
    }
    
    // MARK: - Actions
    @objc func didRefresh() {}
}
