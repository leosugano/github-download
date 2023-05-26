//
//  BaseNetwork.swift
//  Github
//
//  Created by Leonardo Sugano on 03/05/23.
//

import Alamofire

final class Network {
    
    static func send(url: String,
                     method: HTTPMethod,
                     parameters: Parameters? = nil,
                     encoding: ParameterEncoding? = URLEncoding.default,
                     headers: HTTPHeaders? = nil,
                     interceptor: RequestInterceptor? = nil,
                     successHandler: @escaping (Data) -> Void,
                     errorHandler: @escaping (AFError) -> Void) {
        
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   headers: headers,
                   interceptor: interceptor).validate(statusCode: 200...299).responseData { response in
            
            switch response.result {
            case .success(let data):
                successHandler(data)
               
            case .failure(let error):
                errorHandler(error)
            }
        }
    }
}
