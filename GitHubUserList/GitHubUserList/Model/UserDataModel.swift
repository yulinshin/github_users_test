//
//  UserDataModel.swift
//  GitHubUserList
//
//  Created by yulin on 2022/1/7.
//

import Foundation

struct User: Codable {

    let login: String
    let id: Int
    let nodeId: String
    let avatarUrl: String
    let gravatarId: String
    let url: String
    let htmlUrl: String
    let followersUrl: String
    let followingUrl: String
    let gistsUrl: String
    let starredUrl: String
    let subscriptionsUrl: String
    let organizationsUrl: String
    let reposUrl: String
    let eventsUrl: String
    let receivedEventsUrl: String
    let type: String
    let siteAdmin: Bool

    // for UserDetail
    let userName: String?
    let userEmail: String?
    let userBio: String?
    let publicRepos: Int?
    let publicGists: Int?
    let followers: Int?
    let following: Int?

    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case url
        case htmlUrl = "html_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case starredUrl = "starred_url"
        case subscriptionsUrl = "subscriptions_url"
        case organizationsUrl = "organizations_url"
        case reposUrl = "repos_url"
        case eventsUrl = "events_url"
        case receivedEventsUrl = "received_events_url"
        case type
        case siteAdmin = "site_admin"

        // for UserDetail
        case userName = "name"
        case userEmail = "email"
        case userBio = "bio"
        case publicRepos = "public_Repos"
        case publicGists = "public_Gists"
        case followers
        case following

    }
}
