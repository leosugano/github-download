//
//  ResultMapper.swift
//  Github
//
//  Created by Leonardo Sugano on 03/05/23.
//

import Alamofire

public enum ServiceResult<Success, Failure> where Failure: Error {
    case success(Success)
    case failure(Failure)
}

class ResultMapper {
    
    static func resultMap<T: Codable>(data: Data,      
                                      handler: (ServiceResult<T, NetworkError>) -> Void) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            let jsonArray = try JSONSerialization.jsonObject(with: data) as? [[String: Any]]
            var jsonData: Data?
            
            if let jsonObject = jsonObject {
                jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            }
            
            if let jsonArray = jsonArray {
                jsonData = try? JSONSerialization.data(withJSONObject: jsonArray, options: .prettyPrinted)
            }
            
            guard let jsonData = jsonData else {
                handler(.failure(NetworkError(code: "500",
                                              message: L10n.unexpectError)))
                return
            }
            
            let json = try JSONDecoder().decode(T.self, from: jsonData)
            handler(.success(json))
            
        } catch {
            handler(.failure(NetworkError(code: "500",
                                          message: L10n.unexpectError)))
            return
        }
    }
    
    static func resultFailure(error: AFError, failure: (NetworkError) -> Void) {
        failure(NetworkError(code: "\(error.responseCode ?? 0)",
                             message: error.errorDescription))
    }
}
