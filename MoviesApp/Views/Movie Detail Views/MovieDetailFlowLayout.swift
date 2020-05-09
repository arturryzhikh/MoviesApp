//
//  MovieDetailFlowLayout.swift
//  MoviesApp
//
//  Created by Artur R on 09.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

class MovieDetailFlowLayout: UICollectionViewFlowLayout {
 
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let layoutAttributes = super.layoutAttributesForElements(in: rect)
    layoutAttributes?.forEach({ (attributes) in
      //is there header view?
      if attributes.representedElementKind == UICollectionView.elementKindSectionHeader && attributes.indexPath.section == 0 {
        //is there collection view managed by this class?
        guard let collectionView = collectionView else { return }
        let contentOffsetY = collectionView.contentOffset.y
        guard contentOffsetY < 0 else { return }
        let width = collectionView.frame.width
        let height = attributes.frame.height - contentOffsetY
        //header
        //resize header
        attributes.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
        
      }
    })
    return layoutAttributes
  }
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
}
