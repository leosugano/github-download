//
//  StoreNavigationBar.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import UIKit
import SnapKit

class StoneNavigationBar: UIView {
    
    // MARK: - Outlets
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(didTapRightButton), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        button.tintColor = .black
        return button
    }()
    
    // MARK: - Vars
    var actionLeftButton: (() -> Void)?
    var actionRightButton: (() -> Void)?

    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        self.addSubview(leftButton)
        self.addSubview(rightButton)
        self.addSubview(titleLabel)
    }
    
    private func setConstraints() {
        setLeftButtonConstraints()
        setRightButtonConstraints()
        setTitleLabelConstraints()
    }
    
    private func setLeftButtonConstraints() {
        leftButton.snp.remakeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.height.equalTo(NavBar.height)
        }
    }
    
    private func setTitleLabelConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(leftButton.snp.trailing)
            make.trailing.equalTo(rightButton.snp.leading)
        }
    }
    
    private func setRightButtonConstraints() {
        rightButton.snp.remakeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.width.height.equalTo(NavBar.height)
        }
    }
    
    // MARK: - Setups
    func setupNavigationBar(_ title: String? = nil,
                            showLeftButton: Bool,
                            leftIcon: UIImage? = UIImage(systemName: "chevron.left"),
                            showRightButton: Bool,
                            rightIcon: UIImage? = UIImage(named: "ic-filter")) {
        
        self.setupTitleLabel(title: title)
        self.leftButton.setImage(leftIcon, for: .normal)
        self.rightButton.setImage(rightIcon, for: .normal)
        self.leftButton.isHidden = !showLeftButton
        self.rightButton.isHidden = !showRightButton
    }
    
    func removeBackgroundColor() {
        self.backgroundColor = nil
    }
    
    private func setBackgroundColor() {
        self.backgroundColor = .white
    }
    
    private func setupTitleLabel(title: String?) {
        guard let title = title else {
            self.titleLabel.text = nil
            return
        }
        
        let titleAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: FontSize.titleFont),
            .foregroundColor: UIColor.black
        ]

        let attributeString = NSMutableAttributedString(string: title, attributes: titleAttribute)

        titleLabel.attributedText = attributeString
        titleLabel.sizeToFit()
    }
    
    // MARK: - Actions
    @objc func didTapBackButton() {
        self.actionLeftButton?()
    }
    
    @objc func didTapRightButton() {
        self.actionRightButton?()
    }
}
