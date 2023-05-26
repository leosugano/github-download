//
//  SizesTests.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import XCTest
import UIKit
@testable import Github

class SizesTests: XCTestCase {
    
    var nav: UINavigationController!
    var keyWindow: UIWindow!
    
    override func setUp() {
        self.keyWindow = UIApplication.shared.connectedScenes.compactMap({$0 as? UIWindowScene}).first?.windows.filter({$0.isKeyWindow}).first
    }
    
    override func tearDown() {
        self.keyWindow = nil
    }
    
    func testSizes() {
        XCTAssertEqual(FontSize.normalFont, CGFloat(16))
        XCTAssertEqual(FontSize.boldFont, CGFloat(14))
        XCTAssertEqual(FontSize.titleFont, CGFloat(20))
        XCTAssertEqual(Margin.extraMargin, CGFloat(16))
        XCTAssertEqual(NavBar.height, CGFloat(64))
        XCTAssertEqual(Margin.miniMargin, CGFloat(4))
        XCTAssertEqual(Margin.normalMargin, CGFloat(8))
        XCTAssertEqual(Margin.extraMargin, CGFloat(16))
        XCTAssertEqual(Margin.largeMargin, CGFloat(24))
    }
    
}
