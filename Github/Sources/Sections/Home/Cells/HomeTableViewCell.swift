//
//  HomeTableViewCell.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import UIKit
import SnapKit

protocol HomeTableViewCellDelegate: AnyObject {
    func didSelectOpenUrl(userUrl: String?)
}

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    private lazy var characterImageView: PlaceholderImageView = {
        let imageView = PlaceholderImageView(frame: .zero)
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: FontSize.normalFont)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private lazy var linkUserLabel: UILabel = {
        let label = UILabel()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLinkUser))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: FontSize.boldFont)
        label.textColor = .blue
        return label
    }()
    
    // MARK: - Vars
    private var postImageURL: String?
    private var user: UserResponseModel?
    private var delegate: HomeTableViewCellDelegate?
    
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
        self.contentView.addSubview(characterImageView)
        self.contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(linkUserLabel)
    }
    
    func addConstraints() {
        addCharacterImageViewConstraints()
        addVerticalStackViewConstraints()
    }
    
    private func addCharacterImageViewConstraints() {
        characterImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.leading.bottom.equalToSuperview().inset(Margin.normalMargin)
            make.height.width.equalTo(60)
        }
    }
    
    private func addVerticalStackViewConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(Margin.normalMargin)
            make.leading.equalTo(characterImageView.snp.trailing).offset(Margin.normalMargin)
        }
    }
    
    // MARK: - Func
    func setupDelegate(delegate: HomeTableViewCellDelegate) {
        self.delegate = delegate
    }
    
    func setupCell(_ user: UserResponseModel) {
        self.user = user
        nameLabel.text = L10n.username + (user.login ?? "")
        linkUserLabel.text = L10n.github + (user.htmlUrl ?? "")
        postImageURL = user.avatarUrl
        
        UIImage.loadImageUsingCacheWithUrlString(user.avatarUrl ?? "") { [weak self] image in
            guard let self = self else { return }
            if user.avatarUrl == self.postImageURL {
                self.characterImageView.image = image
            }
        }
    }
    
    // MARK: - Actions
    @objc func tapLinkUser() {
        delegate?.didSelectOpenUrl(userUrl: user?.htmlUrl)
    }
}
