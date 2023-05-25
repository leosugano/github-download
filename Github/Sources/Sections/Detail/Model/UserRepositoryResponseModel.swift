//
//  UserRepositoryResponseModel.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import Foundation

struct UserRepositoryResponseViewModel: Codable {
    
    let idRep: Int?
    let nameRepo: String?
    let privateRep: Bool?
    let fullName: String?
    let owner: Owner?
    let desc: String?
    let fork: Bool?
    let tagsURL: String?
    let contributorsUrl: String?
    let license: License?
    let createdAt: String?
    let updatedAt: String?
    let homePage: String?
    let svnUrl: String?
    let visibility: String?
    
    enum CodingKeys: String, CodingKey {
        case owner, fork, license, visibility
        case idRep = "id"
        case nameRepo = "name"
        case privateRep = "private"
        case fullName = "full_name"
        case desc = "description"
        case tagsURL = "tags_url"
        case contributorsUrl = "contributors_url"
        case svnUrl = "svn_url"
        case homePage = "homepage"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct Owner: Codable {
    let login: String?
    let id: Int?
    let avatarUrl: String?
    let url: String?
    let htmlUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case login, id, url
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
    }
}

struct License: Codable {
    let name: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name, url
    }
}
