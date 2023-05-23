//
//  NetworkError.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import Foundation

struct NetworkError: Error {
    var code: String?
    var message: String?
}
