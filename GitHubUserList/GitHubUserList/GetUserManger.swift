//
//  GetUserManger.swift
//  GitHubUserList
//
//  Created by yulin on 2022/1/7.
//

import Foundation

class GetUserManger {

    private let networkProvider = NetworkProvider()
    private var since = 0

    func resetPaging(){
        self.since = 0
    }

    func getUserList(completion: @escaping (Result<[User], Error>) -> Void) {
        networkProvider.fetchObject(api: UsersAPI.list(since: since), type: [User].self) { result in
            switch result {
            case let .success(response):
                completion(.success(response))
                self.since = response.last?.id ?? 0
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func getUserInfo(userLogin: String, completion: @escaping (Result<User, Error>) -> Void) {
        networkProvider.fetchObject(api: UsersAPI.search(user:userLogin), type: User.self) { result in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
