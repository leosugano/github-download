//
//  DetailServiceStub.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import UIKit
@testable import Github

class DetailServiceStub: DetailServiceProtocol {
    
    var success: Bool = false
    var userName: String?
    let json = JSONStub(DetailServiceStub.self)
    let error = NetworkError(code: "500", message: "Error mock")
    
    func getUserDetail(userName: String, completion: @escaping (Github.ServiceResult<Github.UserResponseModel, Github.NetworkError>) -> Void) {
        self.userName = userName
        
        if success {
            guard let response = json.getJson(UserResponseModel.self, fileName: "UserDetailResponse") else {
                completion(.failure(error))
                return
            }
            completion(.success(response))
        } else {
            completion(.failure(error))
        }
    }
    
    func getUserRepos(userName: String, completion: @escaping (Github.ServiceResult<[Github.UserRepositoryResponseViewModel], Github.NetworkError>) -> Void) {
        self.userName = userName
        if success {
            guard let response = json.getJson([UserRepositoryResponseViewModel].self, fileName: "UserReposResponse") else {
                completion(.failure(error))
                return
            }
            completion(.success(response))
        } else {
            completion(.failure(error))
        }
    }
}
