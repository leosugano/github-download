//
//  UserResponseModel.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import Foundation

struct UserResponseModel: Codable {
    
    let login: String?
    let id: Int?
    let nodeId: String?
    let avatarUrl: String?
    let gravatarId: String?
    let url: String?
    let htmlUrl: String?
    let followersUrl: String?
    let followingUrl: String?
    let starredUrl: String?
    let subscriptionsUrl: String?
    let organizationsUrl: String?
    let reposUrl: String?
    let eventsUrl: String?
    let receivedEventsUrl: String?
    let type: String?
    let siteAdmin: Bool?
    let name: String?
    let company: String?
    let blog: String?
    let location: String?
    let email: String?
    let hireable: String?
    let bio: String?
    let twitterUsername: String?
    let publicRepos: Int?
    let publicGists: Int?
    let followers: Int?
    let following: Int?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case login, id, url, type, name, company, blog, location, email, hireable, bio, followers, following
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case htmlUrl = "html_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case starredUrl = "starred_url"
        case subscriptionsUrl = "subscriptions_url"
        case organizationsUrl = "organizations_url"
        case reposUrl = "repos_url"
        case eventsUrl = "events_url"
        case receivedEventsUrl = "received_events_url"
        case siteAdmin = "site_admin"
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
