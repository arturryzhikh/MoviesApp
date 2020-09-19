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
            self.reloadDataClosure?()
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
  private var currentPage: Int = 1
  var reloadDataClosure: (()-> Void)?
  var updateLoadingClousure: (()-> Void)?
  var showAlertClosure: (() -> Void)?
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
      switch result {
      case .failure(let error):
        self?.isLoading = false
        self?.alertMessage = error.localizedDescription
      case .success(let response):
        print("""
          Current page : \(String(describing: response.page)) /n
          Total pages; \(String(describing: response.totalPages)) /n
          Total results: \(String(describing: response.totalResults)) /n
          Results count: \(String(describing: response.results?.count))
          """)
        self?.currentPage += 1
        self?.isLoading = false
        if let movies = response.results {
          self?.cellViewModels = movies.map { movie in
            MovieViewModel(movie: movie)}
        }
        
      }
    }

  }

    func cellViewModel( for indexPath: IndexPath ) -> MovieViewModel {
        return cellViewModels[indexPath.row]
  }
    
}
