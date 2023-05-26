//
//  UserResponseModel.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import Foundation

struct UserResponseModel: Codable, Equatable {
    
    let login: String?
    let avatarUrl: String?
    let url: String?
    let htmlUrl: String?
    let reposUrl: String?
    let name: String?
    let company: String?
    let blog: String?
    let location: String?
    let email: String?
    let bio: String?
    let twitterUsername: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case login, url, name, company, blog, location, email, bio
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case reposUrl = "repos_url"
        case twitterUsername = "twitter_username"
        case createdAt = "created_at"
    }
}
