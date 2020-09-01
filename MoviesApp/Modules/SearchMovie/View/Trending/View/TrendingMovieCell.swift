//
//  FeaturedMovieCell.swift
//  MoviesApp
//
//  Created by Artur R on 05.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

class TrendingMovieCell: UICollectionViewCell {
  
  var viewModel: MovieViewModel! {
    didSet {
      backdropImageView.setImage(from: viewModel.backdropPath)
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
    iv.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
    iv.clipsToBounds = true
    iv.layer.cornerRadius = 4
    return iv
  }()
  //MARK: Initial settings
  private func setupView() {
    //add subviews
    self.setSubviewsForAutoLayout(backdropImageView)
    //fill super view with backdrop
    NSLayoutConstraint.activate ([
      backdropImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      backdropImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      backdropImageView.topAnchor.constraint(equalTo: self.topAnchor),
      backdropImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
  
}
