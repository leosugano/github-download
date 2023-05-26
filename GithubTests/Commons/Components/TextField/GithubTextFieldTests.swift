//
//  StoneTextFieldTests.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import SnapshotTesting
import XCTest
@testable import Github

class GithubTextFieldTexts: XCTestCase {
  
    func testStoneTextFieldDidBeginView() {
        let textField = GithubTextFieldView(frame: CGRect(x: 0, y: 0, width: 320, height: 60))
        textField.textFieldDidBeginEditing(textField.textField)
        
        assertSnapshot(matching: textField, as: .image)
    }
    
    func testStoneTextFieldViewDidEndEditing() {
        let textField = GithubTextFieldView(frame: CGRect(x: 0, y: 0, width: 320, height: 60))
        textField.textFieldDidEndEditing(textField.textField)
        
        assertSnapshot(matching: textField, as: .image)

    }
    
    func testStoneTextFieldViewDidEndEditingWithText() {
        let textField = GithubTextFieldView(frame: CGRect(x: 0, y: 0, width: 320, height: 60))
        textField.textField.text = "Teste para ver se esta ok a imagem"
        textField.textFieldDidEndEditing(textField.textField)
        
        assertSnapshot(matching: textField, as: .image)

    }
}
