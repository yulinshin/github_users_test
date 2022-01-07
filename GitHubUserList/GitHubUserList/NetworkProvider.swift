//
//  NetworkProvider.swift
//  GitHubUserList
//
//  Created by yulin on 2022/1/7.
//

import Foundation

class NetworkProvider {
    enum Error: Swift.Error {
        case notHTTPResponse
        case redirecting
        case clientError
        case serverError
        case unexpectedStatusCode
        case selfNotExist
    }

    private let urlSession: URLSession = .shared
    private let currentPage: Int = 0

    func fetchObject<Object>(api: GitHubAPIProtocol, type: Object.Type, completion: @escaping (Result<Object, Error>) -> Void) where Object: Decodable {
        fetchData(api: api) { result in
            switch result {
            case let .success(data):
                let object = try! JSONDecoder().decode(Object.self, from: data)
                completion(.success(object))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func fetchData(api: GitHubAPIProtocol, completion: @escaping (Result<Data, Error>) -> Void) {
        urlSession.dataTask(with: api.makeRequest(), completionHandler: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.notHTTPResponse))
                return
            }
            switch httpResponse.statusCode {
            case 200..<300:
                completion(.success(data!))
            case 300..<400:
                completion(.failure(.redirecting))
            case 400..<500:
                completion(.failure(.clientError))
            case 500..<600:
                completion(.failure(.serverError))
            default:
                completion(.failure(.unexpectedStatusCode))
            }
        }).resume()
    }


}
