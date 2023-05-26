//
//  HeaderDetail.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import UIKit
import SnapKit

protocol HeaderDetailTableViewCellDelegate: AnyObject {
    func didTapUserUrl(url: String?)
}

class HeaderDetailTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    private lazy var userImageView: PlaceholderImageView = {
        let imageView = PlaceholderImageView(frame: .zero)
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var githubLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: FontSize.regularFont)
        label.textColor = .black
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: FontSize.regularFont)
        label.textColor = .black
        return label
    }()
    
    private lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: FontSize.regularFont)
        label.textColor = .black
        return label
    }()
    
    private lazy var blogLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: FontSize.regularFont)
        label.textColor = .black
        return label
    }()
    
    private lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: FontSize.regularFont)
        label.textColor = .black
        return label
    }()
    
    private lazy var createdLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: FontSize.regularFont)
        label.textColor = .black
        return label
    }()
    
    private lazy var urlUserLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapUserUrl))
        label.isUserInteractionEnabled = true
        label.font = UIFont.boldSystemFont(ofSize: FontSize.boldFont)
        label.addGestureRecognizer(tap)
        label.textColor = .blue
        return label
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
    
    // MARK: - Setup
    private func setupCell() {
        self.selectionStyle = .none
        self.addSubviews()
        self.addConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(userImageView)
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(githubLabel)
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(bioLabel)
        verticalStackView.addArrangedSubview(blogLabel)
        verticalStackView.addArrangedSubview(companyLabel)
        verticalStackView.addArrangedSubview(createdLabel)
        verticalStackView.addArrangedSubview(urlUserLabel)
    }
    
    private func addConstraints() {
        addCharacterImageViewConstraints()
        addVerticalStackViewConstraints()
    }
    
    private func addCharacterImageViewConstraints() {
        self.userImageView.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(8)
            make.height.width.equalTo(50)
        }
    }
    
    private func addVerticalStackViewConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalTo(userImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(-8)
        }
    }
    
    // MARK: - Vars
    private weak var delegate: HeaderDetailTableViewCellDelegate?
    private var user: UserResponseModel?
    
    // MARK: - Func
    func setupCellWithCharacter(delegate: HeaderDetailTableViewCellDelegate,
                                user: UserResponseModel) {
        self.setupLabel(label: githubLabel, text: user.login, subText: L10n.user)
        self.setupLabel(label: nameLabel, text: user.name, subText: L10n.name)
        self.setupLabel(label: bioLabel, text: user.bio, subText: L10n.bio)
        self.setupLabel(label: blogLabel, text: user.blog, subText: L10n.blog)
        self.setupLabel(label: companyLabel, text: user.company, subText: L10n.company)
        self.setupLabel(label: createdLabel, text: user.createdAt?.getFormattedDate(format: Keys.isoDateFormat), subText: L10n.createAt)
        self.setupLabel(label: urlUserLabel, text: user.htmlUrl, subText: L10n.github)
        
        self.user = user
        self.delegate = delegate
        
        UIImage.loadImageUsingCacheWithUrlString(user.avatarUrl ?? "") { [weak self] image in
            guard let self = self else { return }
            self.userImageView.image = image
        }
    }
    
    private func setupLabel(label: UILabel,
                            text: String?,
                            subText: String) {
        guard let text = text, !text.isEmpty else {
            label.isHidden = true
            return
        }
        
        label.text = subText + text
        
    }
    
    @objc func didTapUserUrl() {
        delegate?.didTapUserUrl(url: user?.htmlUrl)
    }
}
