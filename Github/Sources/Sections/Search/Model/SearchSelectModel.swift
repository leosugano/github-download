//
//  FilterSelectModel.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import Foundation

struct FilterSelectModel: Encodable, Equatable {
    let name: String?
    
    init(name: String? = nil) {
        self.name = name
    }
}
