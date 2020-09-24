//
//  UIImageVIew+Extension.swift
//  MoviesApp
//
//  Created by Artur R on 18.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//
import UIKit

//FIXME: remove exclamation marks
let imageCache = NSCache<NSString, UIImage>()
final class CustomImageView: UIImageView {
    private var imageUrl: String?
    func loadImage(urlString: String) {
      imageUrl = urlString
        image = UIImage()
        if let img = imageCache.object(forKey: NSString(string: imageUrl!)) {
            image = img
            return
        }
        guard let url = URL(string: urlString) else { return }
        imageUrl = urlString
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            else if let data = data {
                DispatchQueue.main.async {
                    let tempImg = UIImage(data: data)
                    if self.imageUrl == urlString {
                        self.image = tempImg
                    }
                    imageCache.setObject(tempImg!, forKey: NSString(string: urlString))
                }
            }
        }.resume()
    }
}
