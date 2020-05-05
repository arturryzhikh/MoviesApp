//
//  FeaturedCell.swift
//  MoviesApp
//
//  Created by Artur R on 05.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

//MARK: Horizontal Cell
public class MovieCell: UICollectionViewCell {
  //MARK: instance properties
  static var reuseID : String {
    return self.description()
  }
  //MARK: Life cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
   //MARK:Subviews
   
   private func setupView() {
    self.backgroundColor = .red
    self.layer.cornerRadius = 4
    
   }
}
