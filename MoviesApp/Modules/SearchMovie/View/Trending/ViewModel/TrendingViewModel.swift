//
//  TrendingViewModel.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 30.08.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//
import UIKit
class TrendingViewModel {
  private let apiService: ApiService
  
  private var cellViewModels  = [MovieViewModel]() {
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
    
  //MARK: Binding Closures
  var reloadDataClosure: (()-> Void)?
  var updateLoadingClousure: (()-> Void)?
  var showAlertClosure: (() -> Void)?
  
  init(apiService: ApiService = ApiService()) {
    self.apiService = apiService
    getTrending()
   }
  
    
  private func getTrending() {
    self.isLoading = true
    apiService.trending(with: TrendingRequest.trending) { [unowned self] result in
      self.isLoading = false
      switch result {
      
      }
    }
    
      self?.isLoading = false
      if let error = error {
        print(error.localizedDescription)
        self?.alertMessage = "Error"
        
      } else {
        if let movies = movies?.results {
          self?.cellViewModels = movies.map { MovieViewModel(movie: $0) }
        }
      }
      
    }
    
  }

    func cellViewModel( for indexPath: IndexPath ) -> MovieViewModel {
        return cellViewModels[indexPath.row]
  }
}
