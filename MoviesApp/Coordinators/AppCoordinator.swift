//
//  AppCoordinator.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 17.08.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit
class AppCoordinator: Coordinator {
  var children = [Coordinator]()
  weak var window: UIWindow?
  var navigation = UINavigationController()
  
  func start() {
    let moviesVC = SearchMovieViewController (
      collectionViewLayout: UICollectionViewFlowLayout()
    )
    moviesVC.coordinator = self
    navigation.pushViewController(moviesVC, animated: false)
    window?.rootViewController = navigation
    window?.makeKeyAndVisible()
  }
  
  func movieDetail(_ movieViewModel: SearchMovieCellVM) {
    let movieDetailVC = MovieDetailViewController()
    movieDetailVC.movieVM = movieViewModel
    navigation.show(movieDetailVC, sender: nil)
  }
  func trendingMovieDetail(_ trendingMovieVM: TrendingCellViewModel) {
    let movieDetailVC = MovieDetailViewController()
    movieDetailVC.trendingMovieVM = trendingMovieVM
    navigation.pushViewController(movieDetailVC, animated: true)
  }
  
  init(_ window: UIWindow) {
    self.window = window
  }
  init() {}
  
  
}
