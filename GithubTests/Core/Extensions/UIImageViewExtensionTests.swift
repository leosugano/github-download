//
//  UIImageViewExtensionTests.swift
//  GithubTests
//
//  Created by Leonardo Sugano on 25/05/23.
//

import Nimble
import Quick
import UIKit
@testable import Github

class UIImageViewExtensionTests: QuickSpec {
    
    var stub: URLSessionStub!
    var imageCache: NSCache<NSString, AnyObject>!
    let imageStringTest = "testString"
    
    override func spec() {
        let imageTest = UIImage(named: "ic-app")

        describe("UIImageView Extension Unit Tests") {
            
            beforeEach {
                self.stub = URLSessionStub()
                self.imageCache = NSCache<NSString, AnyObject>()
            }
            
            afterEach {
                self.imageCache = nil
                self.stub = nil
            }
            
            context("Tests in Extension") {
                
                it("Test Image Cached") {
                    // Given:
                    self.imageCache.setObject(imageTest!, forKey: self.imageStringTest as NSString)
                                        
                    // When
                    UIImage.loadImageUsingCacheWithUrlString(self.imageStringTest, session: self.stub) { image in
                        expect(image).to(equal(imageTest!))
                    }
                }
                
                it("Test URL request are being created") {
                    // Given:
                    self.stub.success = true
                    
                    // When
                    UIImage.loadImageUsingCacheWithUrlString(self.imageStringTest, session: self.stub) { _ in
                        expect(self.stub.request).toNot(beNil())
                        expect(self.stub.request).to(equal(URL(string: self.imageStringTest)))
                    }
                }
                
                it("Test image are being created and saved") {
                    // Given:
                    self.stub.success = true
                    
                    // When
                    UIImage.loadImageUsingCacheWithUrlString(self.imageStringTest, session: self.stub) { _ in
                        expect(self.stub.urlSessionTaskStub.calledResume).to(beTrue())
                        expect(self.imageCache.object(forKey: self.imageStringTest as NSString) as? UIImage).toNot(beNil())
                    }
                }
                
                it("Test not safe image when download get error") {
                    // Given:
                    self.stub.success = false
                    
                    // When
                    UIImage.loadImageUsingCacheWithUrlString(self.imageStringTest, session: self.stub) { _ in
                        expect(self.stub.urlSessionTaskStub.calledResume).to(beTrue())
                        expect(self.imageCache.object(forKey: self.imageStringTest as NSString) as? UIImage).to(beNil())
                    }
                }
            }
        }
    }
}
