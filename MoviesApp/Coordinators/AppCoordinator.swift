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
    let moviesVC = MoviesViewController(collectionViewLayout: UICollectionViewFlowLayout())
    moviesVC.coordinator = self
    navigation.pushViewController(moviesVC, animated: false)
    window?.rootViewController = navigation
    window?.makeKeyAndVisible()
  }
  
  func movieDetail() {
    let movieDetailVC = MovieDetailViewController(collectionViewLayout: MovieDetailFlowLayout())
    movieDetailVC.coordinator = self
    navigation.show(movieDetailVC, sender: nil)
  }
  
  init(_ window: UIWindow) {
    self.window = window
  }
  init() {}
  
  
}
