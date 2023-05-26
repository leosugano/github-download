//
//  ErrorViewTests.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import SnapshotTesting
import XCTest
@testable import Github

class ErrorViewTests: XCTestCase {
  
    func testErrorViewWithoutMessage() {
        let errorView = ErrorView()
        assertSnapshot(matching: errorView, as: .image)
    }
    
    func testErrorViewWithMessageAndShowButton() {
        let errorViewWithMessageAndButton = ErrorView()

        errorViewWithMessageAndButton.setupErrorView(message: "Erro na internet por favor reconecte-se", showTryAgain: true)
        assertSnapshot(matching: errorViewWithMessageAndButton, as: .image)
    }
    
    func testErrorViewWithMessageAndDontShowButton() {
        let errorViewWithMessageAndDontShowButton = ErrorView()
        
        errorViewWithMessageAndDontShowButton.setupErrorView(message: "Erro na internet por favor reconecte-se", showTryAgain: false)
        assertSnapshot(matching: errorViewWithMessageAndDontShowButton, as: .image)

    }
}
