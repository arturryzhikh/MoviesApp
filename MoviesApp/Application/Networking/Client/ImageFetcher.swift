//
//  NetworkService.swift
//  MoviesApp
//
//  Created by Artur R on 13.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

final class ImageFetcher {
  //properties
  private let session: URLSession
  static let shared = ImageFetcher()
  private let imageChache = NSCache<NSString,UIImage>()
  //init with session
  init(session: URLSession = URLSession.shared) {
     self.session = session
     print("NetworkService Initialized")
   }
   deinit {
     print("NetworkService Deinitialized")
   }
  
  //get image
  func fetchImage(from path: String,
                  completion : @escaping (_ image: UIImage?, _ error: ResponseError?) -> Void) {
    guard
      let url = URL(string: API.imageEndpoint + path) else {
        completion(nil,.network)
        return
        
    }
    //first try to get from cache
    let imageKey = url.absoluteString as NSString
   
    if let cachedImage = imageChache.object(forKey: imageKey) {
      print(cachedImage)
      completion(cachedImage,nil)
      //if there is no - go networking
    } else {
      let task = session.dataTask(with: url) { data,response,error in
        guard let data = data,
          let response = response as? HTTPURLResponse,
          response.statusOK,
          error == nil,
          let image = UIImage(data: data)
          else {
            completion(nil, .network)
            print("Error downloading image \(String(describing: error))")
            return
            
        }
        self.imageChache.setObject(image, forKey: imageKey)
        completion(image,nil)
        
      }
      task.resume()
    }
    
  }

  
 
  
}

