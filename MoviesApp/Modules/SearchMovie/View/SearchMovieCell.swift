//
//  FeaturedCell.swift
//  MoviesApp
//
//  Created by Artur R on 05.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit



class SearchMovieCell: UICollectionViewCell {
  
  static var reuseID: String {
    return self.description()
  }
  //MARK: instance properties
  var viewModel: MovieViewModel?
  //MARK: Life cycle
  override func prepareForReuse() {
    super.prepareForReuse()
    populate(with: .none)
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
   //MARK:Subviews
 private let posterImageView: CustomImageView = {
    let iv = CustomImageView()
    iv.contentMode = .scaleAspectFill
    iv.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
    iv.clipsToBounds = true
    iv.layer.cornerRadius = 4
    return iv
  }()
  private let titleLabel: UILabel = {
    let lbl = UILabel()
    lbl.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
    lbl.numberOfLines = 0
    lbl.textAlignment = .natural
    lbl.lineBreakMode = .byWordWrapping
    lbl.font = UIFont.boldSystemFont(ofSize: 16)
    lbl.textColor = .white
    return lbl
  }()
  private let yearLabel: UILabel = {
    let lbl = UILabel()
    lbl.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
    lbl.numberOfLines = 0
    lbl.textAlignment = .left
    lbl.font = UIFont.systemFont(ofSize: 12)
    lbl.textColor = .white
    return lbl
  }()
  private let overviewLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont.systemFont(ofSize: 14)
    lbl.textColor = .white
    lbl.numberOfLines = 0
    lbl.lineBreakMode = .byWordWrapping
    lbl.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
    return lbl
  }()
  func populate(with viewModel: MovieViewModel?) {
    if var viewModel = viewModel {
      titleLabel.text = viewModel.title
      yearLabel.text = viewModel.year
      overviewLabel.text = viewModel.overview
      if let urlString = viewModel.posterURLString {
        posterImageView.loadImage(urlStr: urlString)
      }
    }
  }
  private func setupView() {
    self.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
   //add subviews
   self.setSubviewsForAutoLayout(posterImageView,
                                 titleLabel,
                                 yearLabel,
                                 overviewLabel)
   NSLayoutConstraint.activate([
    //constraint poster image view
     posterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5),
     posterImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: 5),
     posterImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
     posterImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant:  -5),
  //constraint title
     titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 5),
     titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor,constant: 8),
     titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
     titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.25),
     //constraint year label
    yearLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor,multiplier: 0.3),
    yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
    yearLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
    yearLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor,multiplier: 0.15),
    // constraint description label
    overviewLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 1),
    overviewLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -5),
    overviewLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
    overviewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5)
    ])
  }
}
