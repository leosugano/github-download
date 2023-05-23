//
//  UIImage+Extension.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 05/04/23.
//

import UIKit

extension UIImage {
        
    static func loadImageUsingCacheWithUrlString(_ urlString: String,
                                                 session: URLSession? = URLSession.shared,
                                                 completion: @escaping (UIImage) -> Void) {
        if let cachedImage = DatabaseController.imageCache.object(forKey: urlString as NSString) as? UIImage {
            completion(cachedImage)
        }
        
        guard let url = URL(string: urlString) else { return }
        session?.dataTask(with: url, completionHandler: { (data, _, error) in
            if error != nil {
                return
            }
            
            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!) {
                    DatabaseController.imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    completion(downloadedImage)
                }
            })
            
        }).resume()
    }
}
