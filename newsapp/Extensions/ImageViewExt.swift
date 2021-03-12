//
//  ImageViewExt.swift
//  newsapp
//
//  Created by Arnold Mitricã on 10.03.2021.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImage(at url: URL) {
        UIImageLoader.loader.load(url, for: self)
    }
    
    func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
    
    
    func load(url: URL, completion: @escaping (UIImage?) -> ()){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        completion(image)
                    }
                }
            }
        }
    }
    
    func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {
        
        if self.image == nil{
            self.image = PlaceHolderImage
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}
