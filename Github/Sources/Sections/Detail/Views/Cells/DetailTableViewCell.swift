//
//  DetailTableViewCell.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import SnapKit
import UIKit

class DetailTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 2
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
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
    
    private func setupCell() {
        selectionStyle = .none
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(mainView)
        mainView.addSubview(verticalStackView)
    }
    
    private func addConstraints() {
        addMainViewContraints()
        addVericalStackViewConstraints()
    }
    
    private func addMainViewContraints() {
        mainView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(4)
        }
    }
    
    private func addVericalStackViewConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(4)
            make.centerX.equalToSuperview()
        }
    }
       
    // MARK: - Vars
    private var repo: UserRepositoryResponseViewModel?
    
    // MARK: - Func
    func setupCellWithDetails(repo: UserRepositoryResponseViewModel) {
        self.repo = repo

        cleanVerticalStackView()
        createLabel(title: L10n.repoName, value: repo.nameRepo)
        createLabel(title: L10n.completeName, value: repo.fullName)
        createLabel(title: L10n.desc, value: repo.desc)
        createLabel(title: L10n.createAt, value: repo.createdAt?.getFormattedDate(format: Keys.isoDateFormat))
        createLabel(title: L10n.lisence, value: repo.license?.name)
        createLabel(title: L10n.url, value: repo.svnUrl, didTap: true)
    }
    
    private func createLabel(title: String, value: String?, didTap: Bool = false) {
        guard let value = value, !value.isEmpty else { return }
        let color: UIColor = didTap ? .blue : .black
        
        let detailLabel = UILabel()
        detailLabel.numberOfLines = 0
        detailLabel.textAlignment = .left
        
        detailLabel.attributedText = NSMutableAttributedString()
            .bold(title, color, size: FontSize.boldFont)
            .normal(value, color, size: FontSize.boldFont)
        
        verticalStackView.addArrangedSubview(detailLabel)
    }
    
    private func cleanVerticalStackView() {
        for view in verticalStackView.subviews {
            view.removeFromSuperview()
        }
    }
}
