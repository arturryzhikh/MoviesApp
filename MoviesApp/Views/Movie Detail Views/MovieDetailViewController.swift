//
//  MovieDetailViewController.swift
//  MoviesApp
//
//  Created by Artur R on 08.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit



class MovieDetailViewController: UICollectionViewController {
//MARK: instance properties
  var movieVM: SearchMovieCellViewModel?
  var trendingMovieVM: TrendingMovieVM?
  private let reuseID = "cell" // create custom cells
  private let padding: CGFloat = 8
//MARK: life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNavigationBar()
    setupCollectionView()
    setupCollectionViewLayout(with: padding)
  }
  
  
  //MARK: Subview
  private func setupNavigationBar() {
    navigationController?.navigationBar.isTranslucent = true
    //make bar transparent
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    //make bar separator transparent
    navigationController?.navigationBar.shadowImage = UIImage()
    //color of bar button items
    navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    
  }
  private func setupCollectionViewLayout(with padding: CGFloat) {
    if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
      layout.sectionInset = UIEdgeInsets(top: padding,
                                         left: padding,
                                         bottom: padding,
                                         right: padding)
    
    }
  }
  private func setupCollectionView() {
    collectionView.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
    collectionView.register(UICollectionViewCell.self,
                            forCellWithReuseIdentifier: reuseID)
    collectionView.register(MovieHeader.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: MovieHeader.reuseID)
    if #available(iOS 11.0, *) {
      collectionView.contentInsetAdjustmentBehavior = .never // pin collection view to top of view
    } else {
      self.automaticallyAdjustsScrollViewInsets = false
    }
  }
  
    
}
//MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension MovieDetailViewController {
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return 100
  }
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID,
                                                  for: indexPath)
    cell.backgroundColor = .blue
    
    return cell
  }
  override func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MovieHeader.reuseID,
                                                                 for: indexPath) as! MovieHeader
    header.movieVM = movieVM
    header.trendingMovieVM = trendingMovieVM
    return header
  }
  
}

//MARK: UICollectionViewDelegateFlowLayout
extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width - padding * 2, height: 50 )

  }
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.width, height: view.frame.height / 3)
  }
  
}
