//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by Artur R on 17.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit


class SearchMovieViewModel {
  
  private let apiService : APIClient
  
  private var cellViewModels: [MovieViewModel] = [] {
        didSet {
            self.reloadData?()
         }
    }
  var isLoading: Bool = false {
        didSet {
            self.updateLoadingClousure?()
        }
    }
  var currentCount: Int {
    return cellViewModels.count
    }
  var alertMessage: String? {
      didSet {
          self.showAlertClosure?()
      }
  }
  var newIndexPaths: [IndexPath] = [] {
    didSet {
      reloadDataOnIndexPaths?(newIndexPaths)
    }
  }
  private var currentPage: Int = 1
  var reloadData: (()-> Void)?
  var updateLoadingClousure: (() -> Void)?
  var showAlertClosure: (() -> Void)?
  var reloadDataOnIndexPaths: (([IndexPath]) -> Void)?
  init(apiService: APIClient = Client()) {
    self.apiService = apiService
  }
 
  func searchMovies(searchText: String) {
    guard !isLoading else {
      return
    }
    self.isLoading = true
    let request = SearchMovieRequest(query: searchText,page: currentPage)
    apiService.request(request) { [weak self ] result in
      guard let self = self else {
        return
      }
      switch result {
      case .failure(let error):
        self.isLoading = false
        self.alertMessage = error.localizedDescription
      case .success(let response):
        self.currentPage += 1
        self.isLoading = false
        if let movies = response.results {
          let newCellViewModels = movies.map { MovieViewModel(movie: $0) }
          self.cellViewModels.append(contentsOf: newCellViewModels)
          print("""
              Current page : \(String(describing: response.page)) /n
              Total pages; \(String(describing: response.totalPages)) /n
              Total results: \(String(describing: response.totalResults)) /n
              Results count: \(String(describing: response.results?.count)) /n
              Cell View Models Count: \(String(describing: self.cellViewModels.count))
              """)
          if self.currentPage > 1 {
            self.newIndexPaths = self.calculateIndexPathsToReload(from: newCellViewModels)
            
          }
          
          }
        
      }
    }

  }
  private func calculateIndexPathsToReload(from newCellViewModels: [MovieViewModel])  -> [IndexPath] {
    let startIndex = cellViewModels.count - newCellViewModels.count
    let endIndex = startIndex + newCellViewModels.count
    return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
  }
    func cellViewModel( for indexPath: IndexPath ) -> MovieViewModel {
        return cellViewModels[indexPath.row]
  }
    
}

