//
//  UIImageLoader.swift
//  newsapp
//
//  Created by Arnold Mitricã on 10.03.2021.
//

import Foundation
import UIKit


//Code from an article of Donny Wals, as he wrote: "for production it needs some more work for memory management and possibly a disk cache".

class UIImageLoader {
    static let loader = UIImageLoader()
    
    private let imageLoader = ImageLoader()
    private var uuidMap = [UIImageView: UUID]()
    
    private init() {}
    
    func load(_ url: URL, for imageView: UIImageView) {
        // 1
        let token = imageLoader.loadImage(url) { result in
            // 2
            defer { self.uuidMap.removeValue(forKey: imageView) }
            do {
                // 3
                let image = try result.get()
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } catch {
                // handle the error
                print("Failed .getting() the image from the result ")
            }
        }
        // 4
        if let token = token {
            uuidMap[imageView] = token
        }
    }
    
    func cancel(for imageView: UIImageView) {
      if let uuid = uuidMap[imageView] {
        imageLoader.cancelLoad(uuid)
        uuidMap.removeValue(forKey: imageView)
      }
    }
}
