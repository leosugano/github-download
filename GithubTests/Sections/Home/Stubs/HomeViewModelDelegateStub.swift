//
//  HomeViewModelDelegateStub.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import SnapshotTesting
import XCTest
@testable import Github

class HomeViewModelDelegateStub: HomeViewModelDelegate {
    
    var calledDiplayDatas: Bool = false
    var calledSetNavigationBar: Bool = false
    var hasFilter: Bool = false
    var calledLoadView: Bool = false
    var loadView: Bool = false
    
    func displayDatas() {
        self.calledDiplayDatas = true
    }
    
    func setNavigationBar(hasFilter: Bool) {
        self.calledSetNavigationBar = true
        self.hasFilter = hasFilter
    }
    
    func loadView(_ load: Bool) {
        self.calledLoadView = true
        self.loadView = load
    }
}
