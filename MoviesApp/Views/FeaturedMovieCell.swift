//
//  FeaturedMovieCell.swift
//  MoviesApp
//
//  Created by Artur R on 05.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

class FeaturedMovieCell: UICollectionViewCell {
  
  static var reuseID : String {
    return self.description()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.layer.cornerRadius = 4
    backgroundColor = .blue
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
