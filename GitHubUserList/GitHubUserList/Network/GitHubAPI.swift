//
//  GitHubAPI.swift
//  GitHubUserList
//
//  Created by yulin on 2022/1/7.
//

import Foundation

protocol GitHubAPIProtocol {
    var host: String { get }
    var basePath: String { get }
    var additionalPath: String { get }
    var url: URL { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var body: Data? { get }

    func makeRequest() -> URLRequest
}


extension GitHubAPIProtocol {

    var host: String {
        return "https://api.github.com"
    }

    var url: URL {
        return URL(string: "\(host)\(basePath)\(additionalPath)")!
    }

    func makeRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        return request
    }
}


enum UsersAPI: GitHubAPIProtocol {

    case list(since: Int)
    case search(user: String)

    var basePath: String {
        return "/users"
    }

    var additionalPath: String {
        switch self {
        case let .list(since: since):
            return "?since=\(since)&per_page=20"
        case let .search(user: user):
            return "/\(user)"
        }
    }

    var method: String {
        switch self {
        case .list, .search:
            return "GET"
        }
    }

    var headers: [String: String]? {
        switch self {
        case .list, .search:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .list, .search:
            return nil
        }
    }
}
