//
//  String+Extension.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import Foundation

extension String {
    func getFormattedDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = Keys.ptDateFormat
        return dateFormat.string(from: date ?? Date())
    }
}
