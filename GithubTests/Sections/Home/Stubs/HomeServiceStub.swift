//
//  HomeServiceStub.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import SnapshotTesting
import XCTest
@testable import Github

class HomeServiceStub: HomeServiceProtocol {
    
    var success: Bool = false
    let json = JSONStub(HomeServiceStub.self)
    let error = NetworkError(code: "500", message: "Error mock")

    func getUsers(completion: @escaping (Github.ServiceResult<[Github.UserResponseModel], Github.NetworkError>) -> Void) {
        
        if success {
            guard let result = json.getJson([UserResponseModel].self, fileName: "UserHomeResponse") else {
                completion(.failure(error))
                return
            }
            completion(.success(result))
        } else {
            completion(.failure(error))
        }
    }
}
