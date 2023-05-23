//
//  DetailService.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import Alamofire

protocol DetailServiceProtocol {
    func getCharacterDetail(url: String, id: Int,
                            completion: @escaping (ServiceResult<CharacterDatasResponseModel, NetworkError>) -> Void)
}

class DetailService: DetailServiceProtocol {
    
    // MARK: - Vars
    var provider: Provider
    
    // MARK: - Init
    init(provider: Provider = Provider()) {
        self.provider = provider
    }
    
    // MARK: - Func
    func getCharacterDetail(url: String,
                            id: Int,
                            completion: @escaping (ServiceResult<CharacterDatasResponseModel, NetworkError>) -> Void) {
        
        if UserDefaults.standard.bool(forKey: Keys.userDefaultNoInternet) {
            
            guard let character = DatabaseController.getCharacterById(id) else {
                let error: NetworkError = NetworkError(code: Keys.errorCodeNoDatabase, message: "noInternetError".localized)
                completion(.failure(error))
                return
            }
            completion(.success(character))
            return
        }
        
        self.provider.getProvider(url + "/\(id)",
                                  parameters: nil,
                                  encoding: nil,
                                  handler: completion)
    }
    
}
