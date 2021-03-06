//
//  MovieHeader.swift
//  MoviesApp
//
//  Created by Artur R on 08.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

class MovieHeader: UICollectionReusableView {
  static var reuseID: String {
    return self.description()
  }
  var movieVM: SearchMovieCellVM? {
    didSet {
      posterIV.setImage(from: movieVM?.posterPath)
    }
  }
  var trendingMovieVM: TrendingCellViewModel? {
    didSet {
      posterIV.setImage(from: trendingMovieVM?.backdropPath)
    }
  }
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
    iv.contentMode = .scaleAspectFill
    return iv
   }()
  private func setupView() {
    setSubviewsForAutoLayout(posterIV)
    self.contentMode = .scaleAspectFill
    //Constraint poster image view
    NSLayoutConstraint.activate ([
      posterIV.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      posterIV.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      posterIV.topAnchor.constraint(equalTo: self.topAnchor),
      posterIV.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
}
