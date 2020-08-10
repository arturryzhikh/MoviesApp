//
//  FeaturedMovieCell.swift
//  MoviesApp
//
//  Created by Artur R on 05.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

class TrendingMovieCell: UICollectionViewCell {
  
  var movieViewModel: TrendingMovieViewModel! {
    didSet {
      backdropImageView.setImage(from: movieViewModel.backdropPath)
    }
   }
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
  private let backdropImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.7058823529, blue: 0.8941176471, alpha: 1)
    iv.clipsToBounds = true
    iv.layer.cornerRadius = 4
    return iv
  }()
  //MARK: Initial setup
  private func setupView() {
    //add subviews
    self.layer.cornerRadius = 4
    self.clipsToBounds = true
    self.setSubviewsForAutoLayout(backdropImageView)
    //fill super view constraints
    NSLayoutConstraint.activate ([
      backdropImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      backdropImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      backdropImageView.topAnchor.constraint(equalTo: self.topAnchor),
      backdropImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
  
}
