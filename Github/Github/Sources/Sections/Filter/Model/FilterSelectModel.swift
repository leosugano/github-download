//
//  FilterSelectModel.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import Foundation

struct FilterSelectModel: Encodable, Equatable {
    let status: String?
    let name: String?
    var page: Int?
    
    init(status: String? = nil, name: String? = nil, page: Int? = nil) {
        self.status = status
        self.name = name
        self.page = page
    }
}
