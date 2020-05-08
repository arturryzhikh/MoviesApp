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
  //MARK: Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
   
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  //MARK: Subviews
  private let posterIV: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.backgroundColor = .yellow
    return iv
  }()
  //MARK: Initial setup
  private func setupView() {
    self.layer.cornerRadius = 4 
    //add subviews
    self.setSubviewsForAutoLayout(posterIV)
    //constraint poster image view
    NSLayoutConstraint.activate ([
      posterIV.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      posterIV.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      posterIV.topAnchor.constraint(equalTo: self.topAnchor),
      posterIV.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
  
}
