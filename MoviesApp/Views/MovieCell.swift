//
//  FavoritesCell.swift
//  MoviesApp
//
//  Created by Artur R on 24.04.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit


class MovieCell: UICollectionViewCell {
  //MARK: Instance properties
  
  static var reuseID : String {
    return self.description()
  }
  //MARK: Subviews
   let featuredCollectionView: UICollectionView = {
     let layout = UICollectionViewFlowLayout()
     layout.scrollDirection = .horizontal
     let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
     cv.showsHorizontalScrollIndicator = false
     cv.showsVerticalScrollIndicator = false
     cv.backgroundColor = .clear
     return cv
   }()
  //MARK: life cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  //Instance Methods
  private func setupView() {
    setSubviewsForAutoLayout([featuredCollectionView])
    featuredCollectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseID)
    featuredCollectionView.delegate = self
    featuredCollectionView.dataSource = self
    //Constraint Collection View
    featuredCollectionView.leadingAnchor.constraint(equalTo:
      self.leadingAnchor,constant: 8).isActive = true
    featuredCollectionView.trailingAnchor.constraint(equalTo:
      self.trailingAnchor,constant: -8).isActive = true
    featuredCollectionView.topAnchor.constraint(equalTo:
      self.topAnchor).isActive = true
    featuredCollectionView.bottomAnchor.constraint(equalTo:
      self.bottomAnchor).isActive = true
    featuredCollectionView.contentInset = UIEdgeInsets(top: 5 , left: 0, bottom: 0, right: 0)
    
  }
 
  
  
  
}
//MARK: Collection View Delegate & DataSource
extension MovieCell: UICollectionViewDelegate, UICollectionViewDataSource {
 
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 100
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedCell.reuseID, for: indexPath)
  }
  
  
}
//MARK: Collection View Delegate Flow Layout
extension MovieCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (self.frame.width / 2.5) , height: frame.height - 16)
  }
}

