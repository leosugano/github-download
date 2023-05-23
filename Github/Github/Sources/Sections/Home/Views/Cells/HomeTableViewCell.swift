//
//  HomeTableViewCell.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import UIKit
import SnapKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    private lazy var characterImageView: PlaceholderImageView = {
        let imageView = PlaceholderImageView(frame: .zero)
        return imageView
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: FontSize.boldFont)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Vars
    var postImageURL: String?
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setupCell() {
        self.addSubviews()
        self.addConstraints()
    }
    
    func addSubviews() {
        self.addSubview(characterImageView)
        self.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(nameLabel)
    }
    
    func addConstraints() {
        addCharacterImageViewConstraints()
        addVerticalStackViewConstraints()
    }
    
    private func addCharacterImageViewConstraints() {
        characterImageView.snp.remakeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(Margin.normalMargin)
            make.height.width.equalTo(60)
        }
    }
    
    private func addVerticalStackViewConstraints() {
        verticalStackView.snp.remakeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(Margin.normalMargin)
            make.leading.equalTo(characterImageView.snp.trailing).offset(Margin.normalMargin)
        }
    }
    
    // MARK: - Func
    func setupCellWithCharacter(_ character: CharacterDatasResponseModel) {
        nameLabel.text = character.name
        
        UIImage.loadImageUsingCacheWithUrlString(character.image ?? "") { [weak self] image in
            guard let self = self else { return }
            if character.image == self.postImageURL {
                self.characterImageView.image = image
            }
        }
    }
}
