//
//  ImageLoader.swift
//  newsapp
//
//  Created by Arnold Mitricã on 10.03.2021.
//

import Foundation
import UIKit

//Code from an article of Donny Wals, as he wrote: "for production it needs some more work for memory management and possibly a disk cache".

class ImageLoader {
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    private var i = 0
    
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        
        // 1
        if let image = loadedImages[url] {
            completion(.success(image))
            return nil
        }
        
        // 2
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // 3
            defer {self.runningRequests.removeValue(forKey: uuid) }
            
            // 4
            if let data = data, let image = UIImage(data: data) {
                self.loadedImages[url] = image
                completion(.success(image))
                return
            }
            
            
            // 5
            guard let errore = error else {
                print("No Image: 2")
                completion(.success(UIImage(named: "noimage.png")!))
                // without an image or an error, we'll just ignore this for now
                // you could add your own special error cases for this scenario
                return
            }
            
            guard (errore as NSError).code == NSURLErrorCancelled else {
                print("Error, but not not an NSURLErrorCanceled")
                completion(.failure(errore))
                return
            }
            
            // the request was cancelled, no need to call the callback
        }
        task.resume()
        
        // 6
        //print("loadedImages \(loadedImages)")
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        //print("cancel Load")
       // print("loadedimages \(loadedImages)/")
      runningRequests[uuid]?.cancel()
      runningRequests.removeValue(forKey: uuid)
    }
}
