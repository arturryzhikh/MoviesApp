//
//  ViewController.swift
//  MoviesApp
//
//  Created by Artur R on 24.04.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

class SearchMovieViewController: UICollectionViewController {
 
 //MARK: Instance properties
  weak var coordinator: AppCoordinator?
  private var searchBar: UISearchBar!
  private var viewModel : SearchMovieViewModel?
  private var activityIndicator: UIActivityIndicatorView!
  private var searchText: String = "" {
    willSet {
      let request = SearchMovieRequest(query: newValue)
      viewModel = SearchMovieViewModel(request: request, delegate: self)
    }
  }
  //MARK: life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
    setupNavigationBar()
    searchBar = makeSearchBar()
    setupCollectionView()
  }
}
//MARK:UICollectionViewDelegateFlowLayout

extension SearchMovieViewController: UICollectionViewDelegateFlowLayout {
 func collectionView(_ collectionView: UICollectionView,
                     layout collectionViewLayout: UICollectionViewLayout,
                     sizeForItemAt indexPath: IndexPath) -> CGSize {
  return CGSize(width: view.frame.width, height: view.frame.height / 8)
  }
  
}
//MARK: UICollectionViewDataSource

extension SearchMovieViewController {
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    default:
      guard let viewModel = self.viewModel else {
        return 0
      }
      return viewModel.totalCount
    }
  }
 
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.section {
    case 0:
      let cell =  collectionView
        .dequeueReusableCell(
          withReuseIdentifier: TrendingCell.reuseID,
          for: indexPath) as! TrendingCell
      
      cell.cellDelegate = self
      return cell
    default:
      let cell = collectionView
        .dequeueReusableCell(
          withReuseIdentifier: SearchMovieCell.reuseID,
          for: indexPath) as! SearchMovieCell
      if isLoadingCell(for: indexPath) {
        cell.populate(with: .none)
      } else {
        let cellVM = viewModel?.movieViewModel(at: indexPath)
        cell.populate(with: cellVM)
      }
      return cell
     
    }
    
  }

//MARK: UICollectionViewDelegate
  
  override func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
    let searchMovieCellVM = viewModel?.movieViewModel(at: indexPath)
    coordinator?.movieDetail(searchMovieCellVM!) //Fix me
  }
}

//MARK: UISearchBar Delegate
extension SearchMovieViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    self.searchText = searchText
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    viewModel?.fetchMovies()
  }
  
}

//MARK: CollectionView Cell Delegate
extension SearchMovieViewController: CollectionViewCellDelegate {
  func collectionView(didSelectItemWith moviewViewModel: MovieViewModel) {
    coordinator?.movieDetail(moviewViewModel)
  }
}

private extension SearchMovieViewController {
  
  func isLoadingCell(for indexPath: IndexPath) -> Bool {
    if let viewModel = self.viewModel {
      return indexPath.row >= viewModel.currentCount
    } else {
      return false
    }
  }
  
  
  func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
    let indexPathsForVisibleRows = collectionView.indexPathsForVisibleItems
    let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
    return Array(indexPathsIntersection)
  }

}


extension SearchMovieViewController : SearchMovieViewModelDelegate {
  func isFetching() {
    DispatchQueue.main.async {
      self.activityIndicator.isHidden = false
      self.activityIndicator.startAnimating()
    }
    
  }
  
  func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
    guard let newIndexPathsToReload = newIndexPathsToReload else {
      activityIndicator.stopAnimating()
      collectionView.isHidden = false
      collectionView.reloadData()
      return
    }
   let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
    collectionView.reloadItems(at: indexPathsToReload)
  }
  
  func onFetchFailed(with reason: String) {
    activityIndicator.stopAnimating()
    showAlert("Fetching Failed")
  }
  
  
}
//MARK: UI Collection View Data Source Prefetching
extension SearchMovieViewController: UICollectionViewDataSourcePrefetching {
  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    guard let viewModel = self.viewModel else {
      return
    }
    if indexPaths.contains(where: isLoadingCell) {
        viewModel.fetchMovies()
      }
  }
  
  
}
//MARK: Subviews
extension SearchMovieViewController {
  private func setupCollectionView() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
    collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
    collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
     ])
    collectionView.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
    collectionView
      .register(TrendingCell.self, forCellWithReuseIdentifier: TrendingCell.reuseID)
    collectionView
      .register(SearchMovieCell.self, forCellWithReuseIdentifier: SearchMovieCell.reuseID)
  collectionView.delegate = self
  collectionView.dataSource = self
    collectionView.prefetchDataSource = self
  }
  private func makeSearchBar() -> UISearchBar {
    let sb = UISearchBar(frame: .zero)
    sb.delegate = self
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
    navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
    navigationController?.navigationBar.tintColor = .white  //color of bar button items
    let attrs = [ //color and font of title
      NSAttributedString.Key.foregroundColor: UIColor.white,
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .bold)
     ]
    navigationController?.navigationBar.titleTextAttributes = attrs
    navigationItem.title = "TMDb"
    //Add activity indicator
    activityIndicator = UIActivityIndicatorView(style: .white)
    activityIndicator.hidesWhenStopped = true
    let rightBarButton = UIBarButtonItem(customView: activityIndicator)
    self.navigationItem.rightBarButtonItem = rightBarButton
    
   }
  
  //MARK: Alert
  func showAlert( _ message: String ) {
      let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
      alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
      self.present(alert, animated: true, completion: nil)
  }
  
}
