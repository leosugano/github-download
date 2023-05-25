//
//  UINavigationController+Extension.swift
//  Github
//
//  Created by Leonardo Sugano on 05/05/23.
//

import UIKit

extension UINavigationController {
 
    func popViewControllerWithHandler(_ completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: true)
        CATransaction.commit()
    }
}
