//
//  TrendingViewModel.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 30.08.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//
import UIKit
class TrendingViewModel {
  
  private var cellViewModels  = [TrendingCellViewModel]() {
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
  
  init() {
    getTrending()
  }
    
  func getTrending() {
    self.isLoading = true
    NetworkService.shared.getTrending() { [ weak self ] (movies, error) in
      self?.isLoading = false
      if let error = error {
        print(error.localizedDescription)
        self?.alertMessage = "Error"
        
      } else {
        if let movies = movies?.results {
          self?.cellViewModels = movies.map { TrendingCellViewModel(from: $0) }
        }
      }
      
    }
    
  }

    func cellViewModel( for indexPath: IndexPath ) -> TrendingCellViewModel {
        return cellViewModels[indexPath.row]
  }
}
