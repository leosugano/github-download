//
//  CharacterResponseModel.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import Foundation

struct CharacterResponseModel: Codable {
    let info: CharacterInfoResponseModel?
    let characters: [CharacterDatasResponseModel]?
    
    enum CodingKeys: String, CodingKey {
        case info
        case characters = "results"
    }
}

struct CharacterInfoResponseModel: Codable {
    
    let count: Int?
    let pages: Int?
    let nextPage: String?
    let previousPage: String?
  
    enum CodingKeys: String, CodingKey {
        case count, pages
        case previousPage = "prev"
        case nextPage = "next"
    }
}

struct CharacterDatasResponseModel: Codable, Equatable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: OriginCaracterResponseModel?
    let location: OriginCaracterResponseModel?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, species, type, gender, origin, location, image, episode, url, created
    }
}

struct OriginCaracterResponseModel: Codable, Equatable {
    let name: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name, url
    }
}
