//
//  Date+Extension.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 06/04/23.
//

import UIKit

extension Date {
    
    func convertToString(format: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.locale = Locale(identifier: "pt_BR")
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
    }
}
