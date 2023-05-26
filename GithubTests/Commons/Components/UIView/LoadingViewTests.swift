//
//  LoadingViewTests.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import SnapshotTesting
import XCTest
@testable import Github

class LoadingViewTests: XCTestCase {
  
    func testErrorViewWithoutMessage() {
        let loadingView = LoadingView()
        loadingView.loadSpinner(true)
        assertSnapshot(matching: loadingView, as: .image)
    }
}
