//
//  StoneStatusView.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import UIKit
import SnapKit

protocol StoneStatusViewDelegate: AnyObject {
    func updateValue(_ value: FilterTypeViewModel?)
}

class StoneStatusView: UIView {
    
    // MARK: - Outlets
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private  lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: FontSize.normalFont, weight: .black)
        label.text = "statusLabel".localized
        return label
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    // MARK: - Vars
    weak var delegate: StoneStatusViewDelegate?

    // MARK: - Inits
    override init(frame: CGRect = .zero) {
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
        self.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(horizontalStackView)
    }
    
    private func setConstraints() {
        verticalStackView.snp.remakeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        horizontalStackView.snp.remakeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
    private func setBackgroundColor() {
        self.backgroundColor = .white
    }
    
    // MARK: - Setups
    func setupHorizontalButton(_ titles: [FilterTypeViewModel]) {
        for item in titles {
            let button = StoneSelectButton(frame: .zero, type: item)
            button.addTarget(self, action: #selector(didSelectItem(_:)), for: .touchUpInside)
            horizontalStackView.addArrangedSubview(button)
        }        
    }
    
    // MARK: - Actions
    @objc func didSelectItem(_ sender: Any) {
        self.resetButtons()
        if let button = (sender as? StoneSelectButton) {
            button.setSelectButton()
            delegate?.updateValue(button.type)
        }
    }
    
    private func resetButtons() {
        for currentView in horizontalStackView.subviews {
            if let view = currentView as? StoneSelectButton {
                view.setDeselectButton()
            }
        }
    }
  
}
