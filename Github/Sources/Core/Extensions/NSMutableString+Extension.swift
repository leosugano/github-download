//
//  NSMutableString+Extension.swift
//  Github
//
//  Created by Leonardo Sugano on 25/05/23.
//

import UIKit

extension NSMutableAttributedString {
    
    func bold(_ value: String, _ color: UIColor? = nil, size: CGFloat? = 16) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: getBoldFont(fontSize: size),
            .foregroundColor: color ?? .black
        ]
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
    
    func normal(_ value: String, _ color: UIColor? = nil, size: CGFloat? = 16) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: getNormalFont(fontSize: size),
            .foregroundColor: color ?? .black
        ]
        
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
    
    private func getNormalFont(fontSize: CGFloat?) -> UIFont {
        guard let fontSize = fontSize else {
            return UIFont.systemFont(ofSize: 16, weight: .regular)
        }
        return UIFont.systemFont(ofSize: fontSize, weight: .regular)
    }
    
    private func getBoldFont(fontSize: CGFloat?) -> UIFont {
        guard let fontSize = fontSize else {
            return UIFont.systemFont(ofSize: 16, weight: .bold)
        }
        return UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
}
