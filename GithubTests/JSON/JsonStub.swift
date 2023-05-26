//
//  JsonStub.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

@testable import Github
import Foundation
import XCTest

class JSONStub {
    
    var currentClass: AnyClass?
    
    init(_ currentClass: AnyClass) {
        self.currentClass = currentClass
    }
    
    func getJson<T: Codable>(_ ofType: T.Type, fileName: String) -> T? {
        guard let currentClass = currentClass else {
            print("Passar a current Class no init para pegar o Bundle!")
            return nil
        }
        
        let bundle = Bundle(for: currentClass.self)
        if let url = bundle.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url) {
                let decoder = JSONDecoder()
                if let jsonData = try? decoder.decode(T.self, from: data) {
                    return jsonData
                }
            }
        
        return nil
    }
}
