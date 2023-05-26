//
//  UserDetailViewModelDelegateStub.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import Nimble
import Quick
import UIKit
@testable import Github

class UserDetailViewModelDelegateStub: UserDetailViewModelDelegate {
    
    var calledDisplayDetail: Bool = false
    var calledLoadView: Bool = false
    var showLoad: Bool = false
        
    func displayDetail() {
        self.calledDisplayDetail = true
    }
    
    func loadView(_ load: Bool) {
        self.calledLoadView = true
        self.showLoad = load
    }
    
}
