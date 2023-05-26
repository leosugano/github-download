//
//  FilterViewControllerLayout.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import UIKit
import SnapKit

protocol SearchViewControllerLayoutDelegate: AnyObject {
    func didTapSearchUser(userName: String?)
}

class SearchViewControllerLayout: UIView {
    
    // MARK: - Outlets
    private lazy var textFieldView: GithubTextFieldView = {
        let view = GithubTextFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        button.setTitle(L10n.search, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
        setupBackgroundColor()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        setConstraints()
        setupBackgroundColor()
    }
    
    // MARK: - Set SubView
    private func addSubviews() {
        addSubview(textFieldView)
        addSubview(searchButton)
    }
      
    // MARK: - SetConstraints
    private func setConstraints() {
        setTextFieldViewConstraints()
        setFilterButtonConstraint()
    }
    
    private func setTextFieldViewConstraints() {
        textFieldView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Margin.extraMargin)
            make.leading.trailing.equalToSuperview().inset(Margin.extraMargin)
        }
    }
    
    private func setFilterButtonConstraint() {
        searchButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(280)
            make.height.equalTo(44)
            make.top.equalTo(textFieldView.snp.bottom).offset(Margin.extraMargin)
        }
    }
    
    private func setupBackgroundColor() {
        backgroundColor = .white
    }
 
    // MARK: - Vars
    private weak var delegate: SearchViewControllerLayoutDelegate?

    // MARK: - Public funcs
    func setupDelegate(delegate: SearchViewControllerLayoutDelegate?) {
        self.delegate = delegate
    }
    
    // MARK: - Actions
    @objc func didTapSearchButton() {
        delegate?.didTapSearchUser(userName: textFieldView.textField.text)
    }
}
