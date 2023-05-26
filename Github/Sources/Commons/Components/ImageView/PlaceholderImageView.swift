//
//  PlaceholderImageView.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import UIKit

class PlaceholderImageView: UIImageView {
        
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tintColor = .gray
        self.image = UIImage(systemName: "photo.fill")
        self.contentMode = .scaleToFill
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.tintColor = .gray
        self.image = UIImage(systemName: "photo.fill")
        self.contentMode = .scaleToFill
    }
}
