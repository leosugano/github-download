//
//  DetailTableViewCell.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import SnapKit
import UIKit

class DetailTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    private lazy var detailTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: FontSize.normalFont)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private lazy var detailValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize.normalFont, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
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
    
    // MARK: - Reuse
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setupCell() {
        self.selectionStyle = .none
        self.addSubviews()
        self.addConstraints()
    }
    
    func addSubviews() {
        self.addSubview(detailTitleLabel)
        self.addSubview(detailValueLabel)
    }
    
    func addConstraints() {
        addTitleLabelConstraints()
        addValueLabelConstraints()
    }
    
    private func addTitleLabelConstraints() {
        detailTitleLabel.snp.remakeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(Margin.normalMargin)
        }
    }
    
    private func addValueLabelConstraints() {
        detailValueLabel.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Margin.normalMargin)
            make.trailing.greaterThanOrEqualTo(self.snp.trailing).offset(Margin.normalMargin)
            make.leading.equalTo(detailTitleLabel.snp.trailing).offset(Margin.miniMargin)
        }
    }
    
   
    // MARK: - Func
    func setupCellWithCharacter(_ detail: DetailViewModelResponse) {
        detailTitleLabel.text = detail.title
        detailValueLabel.text = detail.value
    }
}
