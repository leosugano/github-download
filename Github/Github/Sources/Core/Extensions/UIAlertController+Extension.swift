//
//  UIAlert+Extension.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 05/04/23.
//

import UIKit

extension UIAlertController {
    
    class func createAlert(message: String,
                           showPositiveButton: Bool = true,
                           titlePositiveButton: String,
                           showNegativeButton: Bool = true,
                           completion: (() -> Void)? = nil) -> UIAlertController {
        
        let alert = UIAlertController(title: "alertTitle".localized, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .white
        
        if showNegativeButton {
            alert.addAction(UIAlertAction(title: "alertNo".localized,
                                               style: .destructive,
                                          handler: { _ in
                alert.dismiss(animated: true)
            }))
        }
       
        if showPositiveButton {
            alert.addAction(UIAlertAction(title: titlePositiveButton,
                                               style: .default,
                                          handler: { _ in
                alert.dismiss(animated: true) {
                    completion?()
                }
            }))
        }
        
        return alert
    }
}
