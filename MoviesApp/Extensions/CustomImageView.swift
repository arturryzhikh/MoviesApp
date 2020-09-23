//
//  UIImageVIew+Extension.swift
//  MoviesApp
//
//  Created by Artur R on 18.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//
import UIKit


let imageCache = NSCache<NSString, UIImage>()
final class CustomImageView: UIImageView {
    private var imageUrl: String?
    func loadImage(urlStr: String) {
      imageUrl = urlStr
        image = UIImage()
        if let img = imageCache.object(forKey: NSString(string: imageUrl!)) {
            image = img
            return
        }
        guard let url = URL(string: urlStr) else {return}
        imageUrl = urlStr
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            else if let data = data {
                DispatchQueue.main.async {
                    let tempImg = UIImage(data: data)
                    if self.imageUrl == urlStr {
                        self.image = tempImg
                    }
                    imageCache.setObject(tempImg!, forKey: NSString(string: urlStr))
                }
            }
        }.resume()
    }
}
