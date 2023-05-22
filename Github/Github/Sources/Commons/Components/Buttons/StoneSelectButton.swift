//
//  SelectButton.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import UIKit

class StoneSelectButton: UIButton {
    
    //MARK: - VARS
    var type: FilterTypeViewModel?
    
    // MARK: - Life cycle
    init(frame: CGRect, type: FilterTypeViewModel?) {
        super.init(frame: frame)
        self.setTitle(type?.title, for: .normal)
        self.type = type
        self.setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setTitle("", for: .normal)
        self.setupButton()
    }
    
    // MARK: - Configure Button
    func setupButton() {
        self.backgroundColor = .white
        self.setTitleColor(.gray, for: .normal)
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: FontSize.boldFont)
        self.layer.borderColor = UIColor.gray.cgColor
    }
    
    func setSelectButton() {
        self.setTitleColor(UIColor(named: "MainColor"), for: .normal)
        self.layer.borderColor = (UIColor(named: "MainColor") ?? .blue).cgColor
    }
    
    func setDeselectButton() {
        self.setTitleColor(.gray, for: .normal)
        self.layer.borderColor = UIColor.gray.cgColor
    }
    
}
