//
//  UIImageVIew+Extension.swift
//  MoviesApp
//
//  Created by Artur R on 18.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//
import UIKit

extension UIImageView {
  func setImage(from path: String?) {
    guard let path = path else {
      return
    }
    ImageFetcher.shared.fetchImage(from : path) { [ weak self ] (image, error) in
      guard let image = image else {
        return
      }
      DispatchQueue.main.async {
        self?.image = image
      }
    }
  }
}

