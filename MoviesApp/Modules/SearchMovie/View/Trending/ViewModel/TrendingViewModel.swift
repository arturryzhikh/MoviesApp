//
//  TrendingViewModel.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 30.08.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//
import UIKit
class TrendingViewModel {
  private let apiService: APIClient
  
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
  var count: Int {
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
  
  init(apiService: APIClient = Client()) {
    self.apiService = apiService
    getTrending()
   }
  
    
  private func getTrending() {
    guard !isLoading else {
       return
     }
    self.isLoading = true
    apiService.request(TrendingRequest()) { [weak self] result in
      switch result {
      case .failure(let error):
        self?.isLoading = false
        self?.alertMessage = error.reason
      case.success(let response):
        self?.isLoading = false
        if let movies = response.results {
          self?.cellViewModels = movies.map { movie in
            MovieViewModel (movie: movie)
          }
        }
      }
    }
  }

    func cellViewModel( for indexPath: IndexPath ) -> MovieViewModel {
        return cellViewModels[indexPath.row]
  }
}
