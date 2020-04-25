//
//  FavoritesCell.swift
//  MoviesApp
//
//  Created by Artur R on 24.04.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit


class FavoritesCell: UICollectionViewCell {
  
  static var reuseID : String {
    return self.description()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  private func setupView() {
    setSubviewsForAutoLayout([horizontalCollectionView])
    //register new cell class
    horizontalCollectionView.register(HorizontalCell.self, forCellWithReuseIdentifier: HorizontalCell.reuseID)
    //Delegate and Datasource
    horizontalCollectionView.delegate = self
    horizontalCollectionView.dataSource = self
    //Constraint Collection View
    horizontalCollectionView.leadingAnchor.constraint(equalTo:
      self.leadingAnchor,constant: 8).isActive = true
    horizontalCollectionView.trailingAnchor.constraint(equalTo:
      self.trailingAnchor,constant: -8).isActive = true
    horizontalCollectionView.topAnchor.constraint(equalTo:
      self.topAnchor).isActive = true
    horizontalCollectionView.bottomAnchor.constraint(equalTo:
      self.bottomAnchor).isActive = true
    horizontalCollectionView.contentInset = UIEdgeInsets(top: 5 , left: 0, bottom: 0, right: 0)
  }
  //MARK: Subviews
  let horizontalCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.showsHorizontalScrollIndicator = false
    cv.showsVerticalScrollIndicator = false
    cv.backgroundColor = .clear
    return cv
  }()
  
  
  
}
//MARK: Collection View Delegate & DataSource
extension FavoritesCell: UICollectionViewDelegate, UICollectionViewDataSource {
 
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 100
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCell.reuseID, for: indexPath)
  }
  
  
}
//MARK: Collection View Delegate Flow Layout
extension FavoritesCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (self.frame.width / 2.5) , height: frame.height - 16)
  }
}
//MARK: Horizontal Cell
class HorizontalCell: UICollectionViewCell {
  static var reuseID : String {
    return self.description()
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  private func setupView() {
    setSubviewsForAutoLayout([colorLabel])
    self.backgroundColor = .black
    self.layer.cornerRadius = 12
    colorLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
  }
  //Subviews
  let colorLabel: UILabel = {
    let lbl = UILabel()
    lbl.backgroundColor = .green
    lbl.layer.cornerRadius = 12
    lbl.layer.masksToBounds = true
    lbl.alpha = 0.5
    return lbl
  }()
}
