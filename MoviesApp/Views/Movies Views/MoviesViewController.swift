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
  weak var coordinator: AppCoordinator?
  private var searchBar: UISearchBar!
  private var movieViewModels = [MovieViewModel]()
  //MARK: life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
    collectionView.register(TrendingsCell.self, forCellWithReuseIdentifier: TrendingsCell.reuseID)
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
//MARK: UICollectionViewDataSource

extension MoviesViewController {
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    default:
      return movieViewModels.count
    }
  }
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.section {
    case 0:
      let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: TrendingsCell.reuseID,
                                                     for: indexPath) as! TrendingsCell
      return cell
    default:
      let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
      let movieViewModel = movieViewModels[indexPath.row]
      cell.movieViewModel = movieViewModel
      return cell
    }
  }
//MARK: UICollectionViewDelegate
  
  override func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
    let movie = movieViewModels[indexPath.row]
    coordinator?.movieDetail(movie)
    
    //send movie object here
    
    
  }
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
  }
  
  
}
//MARK: UISearchBar Delegate
extension MoviesViewController: UISearchBarDelegate {
  private func fetchMovies(text: String) {
    NetworkService.shared.searchMovies(query: text) { (result, error) in
      if let error = error {
        print("error searching courses,\(error)")
      }
      if let results = result?.results {
        self.movieViewModels = results.map { MovieViewModel(from: $0) }
        self.collectionView.reloadData()
      }
    }
  }
  
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
   
    fetchMovies(text: searchText + " ")
  }
}
