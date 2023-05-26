//
//  UIAlert+Extension.swift
//  Github
//
//  Created by Leonardo Sugano on 05/05/23.
//

import UIKit

extension UIAlertController {
    
    class func createAlert(message: String,
                           titlePositiveButton: String,
                           completion: (() -> Void)? = nil) -> UIAlertController {
        
        let alert = UIAlertController(title: L10n.opsTitle, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .white
        
        alert.addAction(UIAlertAction(title: titlePositiveButton,
                                           style: .default,
                                      handler: { _ in
            alert.dismiss(animated: true) {
                completion?()
            }
        }))
        
        return alert
    }
}
