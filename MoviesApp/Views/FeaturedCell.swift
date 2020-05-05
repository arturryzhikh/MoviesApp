//
//  FeaturedCell.swift
//  MoviesApp
//
//  Created by Artur R on 05.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

//MARK: Horizontal Cell
class FeaturedCell: UICollectionViewCell {
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
  let colorLabel: UILabel = {
    let lbl = UILabel()
    lbl.backgroundColor = .green
    lbl.layer.cornerRadius = 12
    lbl.layer.masksToBounds = true
    lbl.alpha = 0.5
    return lbl
  }()
  private func setupView() {
    setSubviewsForAutoLayout([colorLabel])
    self.backgroundColor = .black
    self.layer.cornerRadius = 12
    colorLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
  }
}
