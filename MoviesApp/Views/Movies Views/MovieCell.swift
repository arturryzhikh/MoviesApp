//
//  FeaturedCell.swift
//  MoviesApp
//
//  Created by Artur R on 05.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit


//MARK: Horizontal Cell
class MovieCell: UICollectionViewCell {
  
  var resultViewModel: ResultViewModel! {
    didSet {
      titleLabel.text = resultViewModel.title
      yearLabel.text = String(resultViewModel.releaseDate?.prefix(4) ?? "Year")
      overviewLabel.text = resultViewModel.overview
      posterIV.image = resultViewModel.backdropImage
    }
  }
  
  
  static var reuseID: String {
    return self.description()
  }
  
  //MARK: instance properties
  
  //MARK: Life cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
   //MARK:Subviews
  private let posterIV: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
    return iv
  }()
  private let titleLabel: UILabel = {
    let lbl = UILabel()
    lbl.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.7058823529, blue: 0.8941176471, alpha: 1)
    lbl.numberOfLines = 0
    lbl.textAlignment = .natural
    lbl.lineBreakMode = .byCharWrapping
    lbl.font = UIFont.boldSystemFont(ofSize: 12)
    lbl.textColor = .white
    lbl.text = "Загадочная история Бенжамина Баттона"
    return lbl
  }()
  private let yearLabel: UILabel = {
    let lbl = UILabel()
    lbl.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.7058823529, blue: 0.8941176471, alpha: 1)
    lbl.numberOfLines = 0
    lbl.textAlignment = .center
    lbl.lineBreakMode = .byCharWrapping
    lbl.font = UIFont.systemFont(ofSize: 10)
    lbl.textColor = .black
    lbl.text = "1998"
    return lbl
  }()
  private let overviewLabel: UILabel = {
    let tv = UILabel()
    tv.font = UIFont.systemFont(ofSize: 10)
    tv.textColor = .white
    tv.numberOfLines = 0
    tv.lineBreakMode = .byCharWrapping
    tv.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.7058823529, blue: 0.8941176471, alpha: 1)
    return tv
  }()
   private func setupView() {
    self.layer.cornerRadius = 4 
    self.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.7058823529, blue: 0.8941176471, alpha: 1)
   //add subviews
   self.setSubviewsForAutoLayout(posterIV,titleLabel,yearLabel,overviewLabel)
   NSLayoutConstraint.activate([
    //constraint poster image view
     posterIV.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5),
     posterIV.topAnchor.constraint(equalTo: self.topAnchor,constant: 5),
     posterIV.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
     posterIV.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant:  -5),
    //constraint title
     titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 5),
     titleLabel.leadingAnchor.constraint(equalTo: posterIV.trailingAnchor,constant: 8),
     titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
     titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.25),
     //constraint year label
    yearLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor,multiplier: 0.25),
    yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
    yearLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
    yearLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor,multiplier: 0.15),
    // constraint description label
    overviewLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 1),
    overviewLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -5),
    overviewLabel.leadingAnchor.constraint(equalTo: posterIV.trailingAnchor, constant: 8),
    overviewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5)
    
  ])
  }
}
