//
//  HomeService.swift
//  Github
//
//  Created by Leonardo Sugano on 03/05/23.
//

import Alamofire

protocol HomeServiceProtocol {
    func getUsers(completion: @escaping (ServiceResult<[UserResponseModel], NetworkError>) -> Void)
}

class HomeService: HomeServiceProtocol {
    
    // MARK: - Vars
    var provider: Provider
    
    // MARK: - Init
    init(provider: Provider = Provider()) {
        self.provider = provider
    }
    
    // MARK: - Func
    func getUsers(completion: @escaping (ServiceResult<[UserResponseModel], NetworkError>) -> Void) {
        let url = Url.baseUrl.rawValue + Url.genericUser.rawValue
        
        self.provider.get(url,
                          parameters: nil,
                          encoding: nil,
                          handler: completion)
        
    }   
}
