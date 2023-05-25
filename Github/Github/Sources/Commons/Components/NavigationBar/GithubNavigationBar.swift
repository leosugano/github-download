//
//  StoreNavigationBar.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import UIKit
import SnapKit

class GithubNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultNavigationStyle()
    }
    
    func defaultNavigationStyle() {
        let titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)
        ]
        
        navigationBar.barStyle = UIBarStyle.default
        navigationBar.tintColor = UIColor.white
        navigationBar.barTintColor = .black

        self.navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = titleTextAttributes

        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for: UIBarMetrics.default)

    }
}
