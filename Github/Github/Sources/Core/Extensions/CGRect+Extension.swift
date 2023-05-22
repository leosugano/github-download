//
//  CGRect+Extension.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 05/04/23.
//

import UIKit

extension CGRect {
    static func getRectForApp() -> CGRect {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let windows = UIApplication.shared.windows.first

        guard let windows = windows else { return .zero }

        let height = screenSize.height - (windows.safeAreaInsets.bottom + windows.safeAreaInsets.top + NavBar.height)

        return CGRect(x: 0, y: (windows.safeAreaInsets.top + NavBar.height), width: screenSize.width, height: height)
    }
}


