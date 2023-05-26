//
//  ConstraintsSizes.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import UIKit

class FontSize {
    static let regularFont: CGFloat = 12
    static let normalFont: CGFloat = 16
    static let boldFont: CGFloat = 14
    static let titleFont: CGFloat = 20
}

class NavBar {
    static let height: CGFloat = 64
}

class Margin {
    static let miniMargin: CGFloat = 4
    static let normalMargin: CGFloat = 8
    static let extraMargin: CGFloat = 16
    static let largeMargin: CGFloat = 24

    static func getSafeAreas() -> UIEdgeInsets {
        let window = UIApplication.shared.windows.first
        
        guard let window = window else {
            return .zero
        }
        
        return window.safeAreaInsets
    }
    
}
