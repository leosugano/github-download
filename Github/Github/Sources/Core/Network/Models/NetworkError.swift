//
//  NetworkError.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import Foundation

struct NetworkError: Error {
    var code: String?
    var message: String?
}
