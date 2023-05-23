//
//  HeaderDetail.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import UIKit
import SnapKit

class HeaderDetailTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    private lazy var characterImageView: PlaceholderImageView = {
        let imageView = PlaceholderImageView(frame: .zero)
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: FontSize.nameHeaderFont)
        label.textColor = .red
        return label
    }()
    
    private lazy var bottomGradientView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    // MARK: - Reuse
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomGradientView.setDegradeBackgroundColor(invert: true)
    }
    
    private func setupCell() {
        self.selectionStyle = .none
        self.addSubviews()
        self.addConstraints()
    }
    
    func addSubviews() {
        self.addSubview(characterImageView)
        self.addSubview(nameLabel)
        self.addSubview(bottomGradientView)
    }
    
    func addConstraints() {
        addCharacterImageViewConstraints()
        addNameLabelConstraints()
        addBottomGradientViewConstraint()
    }
    
    private func addCharacterImageViewConstraints() {
        self.characterImageView.snp.remakeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    private func addNameLabelConstraints() {
        self.nameLabel.snp.remakeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(Margin.normalMargin)
        }
    }
    
    private func addBottomGradientViewConstraint() {
        self.bottomGradientView.snp.remakeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }

    // MARK: - Func
    func setupCellWithCharacter(_ character: CharacterDatasResponseModel) {
        nameLabel.text = character.name
        UIImage.loadImageUsingCacheWithUrlString(character.image ?? "") { [weak self] image in
            guard let self = self else { return }
            self.characterImageView.image = image
        }
    }
}
