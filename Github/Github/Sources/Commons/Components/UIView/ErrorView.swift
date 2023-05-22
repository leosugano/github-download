//
//  ErrorView.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 05/04/23.
//

import SnapKit
import UIKit

class ErrorView: UIView {
        
    // MARK: - Outlets
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Margin.extraMargin
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.boldSystemFont(ofSize: FontSize.titleFont)
        label.text = "opsTitle".localized
        label.textAlignment = .center
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: FontSize.normalFont)
        return label
    }()
    
    private lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(named: "MainColor"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize.titleFont)
        button.setTitle("tryAgainTitle".localized, for: .normal)
        button.addTarget(self, action: #selector(didTapTryAgain), for: .touchUpInside)
        return button
    }()
        
    // MARK: - Vars
    weak var delegate: StoneStatusViewDelegate?
    var completionHandler: (()->())?
    
    // MARK: - Inits
    init() {
        super.init(frame: CGRect.getRectForApp())
        addSubviews()
        setConstraints()
        setBackgroundColor()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        setConstraints()
        setBackgroundColor()
    }
    
    // MARK: - Set Constraints
    private func addSubviews() {
        self.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(messageLabel)
        verticalStackView.addArrangedSubview(tryAgainButton)
    }
    
    private func setConstraints() {
        setVerticalStackViewConstraint()
    }
    
    private func setVerticalStackViewConstraint() {
        verticalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Margin.largeMargin)
            make.bottom.lessThanOrEqualTo(self.snp.bottom).offset(Margin.largeMargin)
            make.trailing.leading.equalToSuperview().inset(Margin.extraMargin)
        }
    }
    
    func setBackgroundColor() {
        self.backgroundColor = .white
    }
    
    // MARK: - Setups
    func setupErrorView(message: String?, showTryAgain: Bool, completionHandler: (() -> ())? = nil) {
        self.messageLabel.text = message
        self.tryAgainButton.isHidden = !showTryAgain
        self.completionHandler = completionHandler
    }
    
    // MARK: - Actions
    @objc func didTapTryAgain() {
        completionHandler?()
    }
    
}
