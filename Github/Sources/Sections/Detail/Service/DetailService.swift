//
//  DetailService.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import Alamofire

protocol DetailServiceProtocol {
    func getUserDetail(userName: String,
                       completion: @escaping (ServiceResult<UserResponseModel, NetworkError>) -> Void)
    func getUserRepos(userName: String,
                      completion: @escaping (ServiceResult<[UserRepositoryResponseViewModel], NetworkError>) -> Void)
}

class DetailService: DetailServiceProtocol {
    
    // MARK: - Vars
    var provider: Provider
    
    // MARK: - Init
    init(provider: Provider = Provider()) {
        self.provider = provider
    }
    
    // MARK: - Func
    func getUserDetail(userName: String,
                       completion: @escaping (ServiceResult<UserResponseModel, NetworkError>) -> Void) {
        
        let url = Url.baseUrl.rawValue + Url.genericUser.rawValue + "/" + userName
        
        self.provider.get(url,
                          parameters: nil,
                          encoding: nil,
                          handler: completion)
    }
    
    func getUserRepos(userName: String,
                      completion: @escaping (ServiceResult<[UserRepositoryResponseViewModel], NetworkError>) -> Void) {
        
        let url = Url.baseUrl.rawValue + Url.genericUser.rawValue + "/" + userName + Url.repo.rawValue
        
        self.provider.get(url,
                          parameters: nil,
                          encoding: nil,
                          handler: completion)
    }
}
