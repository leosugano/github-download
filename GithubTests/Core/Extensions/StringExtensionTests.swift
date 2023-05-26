//
//  StringExtensionTests.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import Nimble
import Quick
import UIKit
@testable import Github

class StringExtensionTests: QuickSpec {

    override func spec() {
        describe("String Extension Unit Tests") {
            context("Tests in Extension") {
                it("Test to get Date") {
                    expect("1996-05-29T20:15:55Z".getFormattedDate(format: Keys.isoDateFormat)).to(equal("29/05/1996"))
                }
            }
        }
    }
}
