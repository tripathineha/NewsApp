//
//  Extensions.swift
//  NewsApp
//
//  Created by Neha Tripathi on 09/01/18.
//  Copyright © 2018 Neha Tripathi. All rights reserved.
//

import UIKit

//Class extension for UIImageView image download
extension UIImageView {
    
    
    /// Method for downloading image from URL for the imageView
    ///
    /// - Parameter url: URL of the image
    public func imageFromURL(url: URL) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if error != nil { return }
            DispatchQueue.main.async(execute: { () in
                if let data = data {
                    let image = UIImage(data: data)
                    self.image = image
                }
                else {
                    self.image = UIImage(named : "defaultPhoto")
                }
            })
        }).resume()
    }
}
