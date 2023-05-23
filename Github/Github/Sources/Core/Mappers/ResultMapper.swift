//
//  ResultMapper.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 03/04/23.
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
            guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                handler(.failure(NetworkError(code: "500",
                                              message: "unexpectedError".localized)))
                return
            }
            
            let json = try JSONDecoder().decode(T.self, from: jsonData)
            handler(.success(json))
            
        } catch {
            handler(.failure(NetworkError(code: "500",
                                          message: "unexpectedError".localized)))
            return
        }
    }
    
    static func resultFailure(error: AFError, failure: (NetworkError) -> Void) {
        failure(NetworkError(code: "\(error.responseCode ?? 0)",
                             message: error.errorDescription))
    }
}
