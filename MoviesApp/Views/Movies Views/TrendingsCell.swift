//
//  FavoritesCell.swift
//  MoviesApp
//
//  Created by Artur R on 24.04.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

class TrendingsCell: UICollectionViewCell {
  static var reuseID : String {
    return self.description()
  }
  //MARK: Instance properties
  private var trendingMovieViewModels = [TrendingMovieViewModel]()
  //MARK: life cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    fetchTrendingMovies()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  //MARK: Subviews
  let trendingCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 16
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.showsHorizontalScrollIndicator = false
    cv.showsVerticalScrollIndicator = false
    return cv
  }()
  private func setupView() {
    setSubviewsForAutoLayout(trendingCollectionView)
    trendingCollectionView.register(TrendingMovieCell.self,
                                    forCellWithReuseIdentifier: TrendingMovieCell.reuseID)
    trendingCollectionView.delegate = self
    trendingCollectionView.dataSource = self
    trendingCollectionView.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
    //Constraint Collection View
    NSLayoutConstraint.activate([
      trendingCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      trendingCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
      trendingCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      trendingCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
     ])
    }
 }

//MARK: Collection View Delegate & DataSource
extension TrendingsCell: UICollectionViewDelegate, UICollectionViewDataSource {
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return trendingMovieViewModels.count
  }
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingMovieCell.reuseID,
                                                  for: indexPath) as! TrendingMovieCell
    let trendingMoviewViewModel = trendingMovieViewModels[indexPath.row]
    cell.movieViewModel = trendingMoviewViewModel
    return cell
   }
 }
//MARK: Collection View Delegate Flow Layout
extension TrendingsCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (self.frame.width / 2) , height: frame.height )
  }
}

//MARK: Networking
extension TrendingsCell {
  private func fetchTrendingMovies() {
    NetworkService.shared.getTrending { [ weak self ] (result, error) in
      if let error = error {
        print("error getting trending movies \(error)")
      }
      guard let results = result?.results else { return }
      self?.trendingMovieViewModels = results.map { TrendingMovieViewModel(from: $0)}
      self?.trendingCollectionView.reloadData()
    }
  }
}
