//
//  AlamofireRequests.swift
//  Github
//
//  Created by Leonardo Sugano on 03/05/23.
//

import Alamofire

class Provider {
    
    // MARK: - Constants
    
    func get<T: Codable>(_ url: String,
                         parameters: Parameters?,
                         encoding: ParameterEncoding?,
                         handler: @escaping (ServiceResult<T, NetworkError>) -> Void) {
                
        Network.send(url: url, method: .get, parameters: parameters, encoding: encoding) { data in
            ResultMapper.resultMap(data: data, handler: handler)
            
        } errorHandler: { error in
            ResultMapper.resultFailure(error: error, failure: { failure in
                handler(.failure(failure))
            })
        }
    }
}
