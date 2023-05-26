//
//  GithubTextField.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import UIKit
import SnapKit

protocol GithubTextFieldViewDelegate: AnyObject {
    func updateNameValue(name: String)
}

class GithubTextFieldView: UIView, UITextFieldDelegate {
    
    // MARK: - Outlets
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = L10n.username
        label.textColor = .lightGray
        return label
    }()
    
    lazy var textField: UITextField = {
        let field = UITextField()
        field.delegate = self
        field.textColor = .black
        return field
    }()
    
    private lazy var selectLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: FontSize.boldFont, weight: .bold)
        label.text = L10n.obligatefield
        return label
    }()
    
    // MARK: - Constants
    var middleTextfieldHeight: CGFloat = 31
    
    // MARK: Vars
    weak var delegate: GithubTextFieldViewDelegate?

    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
        setBackground()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        setConstraints()
        setBackground()
    }
    
    // MARK: - Set Constraints
    private func addSubviews() {
        self.addSubview(titleLabel)
        self.addSubview(textField)
        self.addSubview(selectLineView)
        self.addSubview(errorLabel)
    }
    
    private func setConstraints() {
        setTextfieldConstraints()
        setTitleLabelConstraints()
        setSelectLineConstraints()
        setErrorLabelConstraints()
    }
    
    private func setTextfieldConstraints() {
        textField.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(Margin.largeMargin)
            make.height.equalTo(40)
        }
    }
    
    private func setTitleLabelConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(middleTextfieldHeight)
            make.height.equalTo(22)
        }
    }
    
    private func setSelectLineConstraints() {
        selectLineView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(textField.snp.bottom).inset(Margin.miniMargin)
            make.height.equalTo(1)
        }
    }
    
    private func setErrorLabelConstraints() {
        errorLabel.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(Margin.miniMargin)
            make.top.equalTo(selectLineView.snp.bottom).offset(Margin.miniMargin)
        }
    }
    
    private func setBackground() {
        self.backgroundColor = .white
    }

    // MARK: - TextField Delegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        
        updateTitleLabel(text.isEmpty)
        showErrorLabel(text.isEmpty)
        updateSelectView(false)
        
        delegate?.updateNameValue(name: text)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateTitleLabel(false)
        showErrorLabel(false)
        updateSelectView(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Update View
    private func updateTitleLabel(_ itsEmpty: Bool) {
        middleTextfieldHeight = itsEmpty ? 31 : 0
        UIView.animate(withDuration: 0.3) {
            self.setTitleLabelConstraints()
        }
    }
    
    private func updateSelectView(_ itsSelected: Bool) {
        let color: UIColor = itsSelected ? .black : .gray
        self.selectLineView.backgroundColor = color
    }
    
    private func showErrorLabel(_ show: Bool) {
        errorLabel.isHidden = !show
    }
}
