//
//  DetailViewControllerLayout.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import UIKit
import SnapKit

class DetailViewControllerLayout: BaseViewController {
    
    // MARK: - Outlets
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
        bringNavigationToFront()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        setConstraints()
        bringNavigationToFront()
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
            make.top.equalToSuperview().inset(Margin.getSafeAreas().top)
            make.trailing.equalToSuperview().inset(Margin.getSafeAreas().right)
            make.leading.equalToSuperview().inset(Margin.getSafeAreas().left)
            make.bottom.equalToSuperview().inset(Margin.getSafeAreas().bottom)
        }
    }
    
    private func bringNavigationToFront() {
        self.view.bringSubviewToFront(self.navigationBar)
    }
    
    override func rotated() {
        super.rotated()
        
        DispatchQueue.main.async {
            self.setTableViewConstraints()
        }
    }
}
