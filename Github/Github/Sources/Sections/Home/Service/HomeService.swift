//
//  HomeService.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 03/04/23.
//

import Alamofire

protocol HomeServiceProtocol {
    func getCharacters(url: String,
                       parameters: FilterSelectModel,
                       completion: @escaping (ServiceResult<CharacterResponseModel, NetworkError>) -> Void)
    
    func getCharactersWithFilter(url: String,
                                 filter: FilterSelectModel,
                                 completion: @escaping (ServiceResult<CharacterResponseModel, NetworkError>) -> Void)
}

class HomeService: HomeServiceProtocol {
    
    // MARK: - Vars
    var provider: Provider
    
    // MARK: - Init
    init(provider: Provider = Provider()) {
        self.provider = provider
    }
    
    // MARK: - Func
    func getCharacters(url: String,
                       parameters: FilterSelectModel,
                       completion: @escaping (ServiceResult<CharacterResponseModel, NetworkError>) -> Void) {
        
        if (UserDefaults.standard.bool(forKey: Keys.userDefaultNoInternet)) {
            self.getCharacters(filter: nil, completion: completion)
            return
        }
        
        self.provider.getProvider(url,
                                  parameters: parameters.dictionary,
                                  encoding: URLEncoding.queryString,
                                  handler: completion)
    }
    
    func getCharactersWithFilter(url: String,
                                 filter: FilterSelectModel,
                                 completion: @escaping (ServiceResult<CharacterResponseModel, NetworkError>) -> Void) {
        if (UserDefaults.standard.bool(forKey: Keys.userDefaultNoInternet)) {
            self.getCharacters(filter: filter, completion: completion)
            return
        }
        
        self.provider.getProvider(url,
                                  parameters: filter.dictionary,
                                  encoding: URLEncoding.queryString,
                                  handler: completion)
    }
    
    private func getCharacters(filter: FilterSelectModel?, completion: @escaping (ServiceResult<CharacterResponseModel, NetworkError>) -> Void) {
        
        let info = CharacterInfoResponseModel(count: nil, pages: nil, nextPage: nil, previousPage: nil)
        var characters = DatabaseController.getAllCharacter()
        
        if filter != nil {
            characters = characters.filter({ value in
                value.status?.lowercased() == filter?.status?.lowercased() && (value.name?.lowercased().contains(filter?.name?.lowercased() ?? "") ?? false)
            })
        }
        
        if characters.isEmpty {
            completion(.failure(NetworkError(code: Keys.errorCodeNoDatabase, message:"noInternetError".localized)))
        }
        
        completion(.success(CharacterResponseModel(info: info, characters: characters)))
    }
}
