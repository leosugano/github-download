//
//  URLSessionStub.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import Nimble
import Quick
import UIKit
@testable import Github

enum StubError: Error {
    case stubError
}

class URLSessionStub: URLSession {
    
    var request: URL?
    var success: Bool = false
    var urlSessionTaskStub = URLSessionTaskStub()
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.request = url
        
        if success {
            completionHandler(Data(), nil, nil)
        } else {
            completionHandler(nil, nil, StubError.stubError)
        }

        return urlSessionTaskStub
    }
}
