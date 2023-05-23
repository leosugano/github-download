//
//  UIView+Extension.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import UIKit

extension UIView {
    func setDegradeBackgroundColor(invert: Bool) {
        let colorTop = invert ? UIColor.white.withAlphaComponent(0.05).cgColor : UIColor.black.withAlphaComponent(0.3).cgColor
        let colorBottom = invert ? UIColor.black.withAlphaComponent(0.3).cgColor :
        UIColor.white.withAlphaComponent(0.05).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1]
        gradientLayer.frame = self.bounds
        
        removeDegradeBackground()
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func removeDegradeBackground() {
        if (self.layer.sublayers?.first as? CAGradientLayer) != nil {
            self.layer.sublayers?.removeFirst()
        }
    }
}
