//
//  FilterViewControllerLayout.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import UIKit
import SnapKit

class FilterViewControllerLayout: BaseViewController {
    
    // MARK: - Outlets
    lazy var textFieldView: StoneTextFieldView = {
        let view = StoneTextFieldView()
        return view
    }()
    
    lazy var statusView: StoneStatusView = {
        let view = StoneStatusView()
        return view
    }()
    
    lazy var filterButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapFilter), for: .touchUpInside)

        button.setTitle("filterButton".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.backgroundColor = UIColor(named: "MainColor")
        return button
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
        self.view.addSubview(filterButton)
        self.view.addSubview(textFieldView)
        self.view.addSubview(statusView)
    }
      
    // MARK: - SetConstraints
    override func setConstraints() {
        super.setConstraints()
        setFilterButtonConstraint()
        setTextFieldViewConstraints()
        setStatusViewConstraints()
    }
    
    private func setFilterButtonConstraint() {
        self.filterButton.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().inset(Margin.getSafeAreas().bottom)
            make.leading.equalToSuperview().inset(Margin.getSafeAreas().left)
            make.trailing.equalToSuperview().inset(Margin.getSafeAreas().right)
            make.height.equalTo(60)
        }
    }
    
    private func setTextFieldViewConstraints() {
        self.textFieldView.snp.remakeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(Margin.normalMargin)
            make.leading.equalToSuperview().inset(Margin.getSafeAreas().left + Margin.extraMargin)
            make.trailing.equalToSuperview().inset(Margin.getSafeAreas().right + Margin.extraMargin)
        }
    }
    
    private func setStatusViewConstraints() {
        self.statusView.snp.remakeConstraints { make in
            make.top.equalTo(textFieldView.snp.bottom).offset(Margin.normalMargin)
            make.leading.equalToSuperview().inset(Margin.getSafeAreas().left + Margin.extraMargin)
            make.trailing.equalToSuperview().inset(Margin.getSafeAreas().right + Margin.extraMargin)
        }
    }
    
    override func rotated() {
        super.rotated()
        
        DispatchQueue.main.async {
            self.setConstraints()
        }
    }

    // MARK: - Actions
    @objc func didTapFilter() {}
}
