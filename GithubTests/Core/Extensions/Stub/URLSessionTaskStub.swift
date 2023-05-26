//
//  URLSessionTaskStub.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import Nimble
import Quick
import UIKit
@testable import Github

class URLSessionTaskStub: URLSessionDataTask {
    
    var calledResume: Bool = false
    
    override func resume() {
        self.calledResume = true
    }
}
