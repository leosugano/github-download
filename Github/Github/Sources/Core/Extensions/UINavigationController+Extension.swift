//
//  UINavigationController+Extension.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 05/04/23.
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
