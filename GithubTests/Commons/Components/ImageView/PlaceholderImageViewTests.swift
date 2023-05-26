//
//  PlaceholderImageViewTests.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import SnapshotTesting
import XCTest
@testable import Github

class PlaceholderImageViewTests: XCTestCase {
  
    func testPlaceholderImageViewWithouImage() {
        let imageView = PlaceholderImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        assertSnapshot(matching: imageView, as: .image)
    }
    
    func testPlaceholderImageViewWithImage() {
        let imageView = PlaceholderImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        imageView.image = UIImage(named: "ic-app")
        assertSnapshot(matching: imageView, as: .image)
    }
}
