//
//  ViewController.swift
//  MoviesApp
//
//  Created by Artur R on 24.04.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

class MoviesViewController: UICollectionViewController {
 //MARK: Instance properties
  private var searchBar: UISearchBar!
  private var networkService : NetworkService!
  private var searchMovieResults: SearchMoviesResult?
 //MARK: life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    networkService = NetworkService.shared
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNavigationBar()
    searchBar = makeSearchBar()
    setupCollectionView()
  }
}

//MARK: Subviews
extension MoviesViewController {
  private func setupCollectionView() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
    collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
    collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
     ])
    collectionView.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
    collectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseID)
    collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
    collectionView.delegate = self
    collectionView.dataSource = self
    self.automaticallyAdjustsScrollViewInsets = false
  }
  private func makeSearchBar() -> UISearchBar {
    let sb = UISearchBar(frame: .zero)
    sb.delegate = self //DELEGATE
    //TODO:- make global color management
    sb.barTintColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
    if #available(iOS 13.0, *) {
      sb.searchTextField.backgroundColor = #colorLiteral(red: 0.0967803864, green: 0.2796525564, blue: 0.4792720376, alpha: 1)
      sb.searchTextField.textColor = .white
    } else {
      sb.textField.backgroundColor = #colorLiteral(red: 0.0967803864, green: 0.2796525564, blue: 0.4792720376, alpha: 1)
      sb.textField.textColor = .white
    }
    sb.tintColor = .white
    sb.showsCancelButton = true
    sb.searchBarStyle = .default
    sb.enablesReturnKeyAutomatically = true
    self.view.setSubviewsForAutoLayout(sb)
      if #available(iOS 11.0, *) {
       NSLayoutConstraint.activate([
        sb.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        sb.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        sb.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)])
       
     } else {
       NSLayoutConstraint.activate([
        sb.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
        sb.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        sb.trailingAnchor.constraint(equalTo: view.trailingAnchor)
       ])
     }
    return sb
    }
  
   private func setupNavigationBar() {
    //FIXME: navigation controoller bar tin color appears as window background color while returning from movie detail vc
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)  //TODO:- make global color management
    navigationController?.navigationBar.tintColor = .white  //color of bar button items
    let attrs = [ //color and font of title
      NSAttributedString.Key.foregroundColor: UIColor.white,
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .bold)
     ]
    navigationController?.navigationBar.titleTextAttributes = attrs
    navigationItem.title = "TMDb"
   }
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
 func collectionView(_ collectionView: UICollectionView,
                     layout collectionViewLayout: UICollectionViewLayout,
                     sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: view.frame.height / 6)
  }
  
}
//MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension MoviesViewController {
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return searchMovieResults?.results?.count ?? 0
  }
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
    
      return cell
    
  }
  override func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
    navigationController?.show(MovieDetailViewController(collectionViewLayout: MovieDetailFlowLayout()), sender: nil)
    //send movie object here
    
    
  }
}
//MARK: UISearchBar Delegate
extension MoviesViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    networkService.searchMovies(query: searchText) { (results, error) in
      
    }
  }
}
