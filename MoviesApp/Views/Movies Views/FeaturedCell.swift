//
//  FavoritesCell.swift
//  MoviesApp
//
//  Created by Artur R on 24.04.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

class FeaturedCell: UICollectionViewCell {
  //MARK: Instance properties
  
  static var reuseID : String {
    return self.description()
  }
  //MARK: life cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  //MARK: Subviews
  let featuredCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.showsHorizontalScrollIndicator = false
    cv.showsVerticalScrollIndicator = false
    return cv
  }()
  private func setupView() {
    setSubviewsForAutoLayout(featuredCollectionView)
    featuredCollectionView.register(FeaturedMovieCell.self,
                                    forCellWithReuseIdentifier: FeaturedMovieCell.reuseID)
    featuredCollectionView.delegate = self
    featuredCollectionView.dataSource = self
    featuredCollectionView.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
    //Constraint Collection View
    NSLayoutConstraint.activate([
      featuredCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      featuredCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
      featuredCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      featuredCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
     ])
  }
 }
//MARK: Collection View Delegate & DataSource
extension FeaturedCell: UICollectionViewDelegate, UICollectionViewDataSource {
 
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 100
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedMovieCell.reuseID, for: indexPath)
  }
  
  
}
//MARK: Collection View Delegate Flow Layout
extension FeaturedCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (self.frame.width / 2.5) , height: frame.height - 16)
  }
}

