//
//  UIImage+Extension.swift
//  Github
//
//  Created by Leonardo Sugano on 05/05/23.
//

import UIKit

extension UIImage {
        
    static let imageCache = NSCache<NSString, AnyObject>()

    static func loadImageUsingCacheWithUrlString(_ urlString: String,
                                                 session: URLSession? = URLSession.shared,
                                                 completion: @escaping (UIImage) -> Void) {
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            completion(cachedImage)
        }
        
        guard let url = URL(string: urlString) else { return }
        session?.dataTask(with: url, completionHandler: { (data, _, error) in
            if error != nil {
                return
            }
            
            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    completion(downloadedImage)
                }
            })
            
        }).resume()
    }
}
