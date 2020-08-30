//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by Artur R on 17.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit


class SearchMovieViewModel {
  
  private var cellViewModels  = [SearchMovieCellVM]() {
        didSet {
            self.reloadDataClosure?()
        }
    }
  var isLoading: Bool = false {
        didSet {
            self.updateLoadingClousure?()
        }
    }
  var numberOfItemsInSection: Int {
        return cellViewModels.count
    }
  var alertMessage: String? {
      didSet {
          self.showAlertClosure?()
      }
  }
    

  var reloadDataClosure: (()-> Void)?
  var updateLoadingClousure: (()-> Void)?
  var showAlertClosure: (() -> Void)?
  
  init() { }
    
  func searchMovies(searchText: String) {
    self.isLoading = true
    NetworkService.shared.searchMovies(query: searchText) { [ weak self ] (movies, error) in
      self?.isLoading = false
      if let error = error {
        print(error.localizedDescription)
        self?.alertMessage = "Error"
        
      } else {
        if let movies = movies?.results {
          self?.cellViewModels = movies.map { SearchMovieCellVM(movie: $0) }
        }
      }
      
    }
    
  }

    func cellViewModel( for indexPath: IndexPath ) -> SearchMovieCellVM {
        return cellViewModels[indexPath.row]
  }
    
}
