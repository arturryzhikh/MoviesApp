//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by Artur R on 17.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

class SearchMovieViewModel {
  //MARK: TODO: add reachibility service
  private var cellViewModels  = [SearchMovieCellViewModel]() {
        didSet {
            self.reloadDataClosure?()
        }
    }
  var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
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
  var updateLoadingStatus: (()-> Void)?
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
          self?.cellViewModels = movies.map { SearchMovieCellViewModel(movie: $0) }
        }
      }
      
    }
    
  }

    func cellViewModel( for indexPath: IndexPath ) -> SearchMovieCellViewModel {
        return cellViewModels[indexPath.row]
  }
    
}


//extension SearchMovieViewModel {
//    func userPressed( at indexPath: IndexPath ) {
//        let photo = self.photos[indexPath.row]
//        if photo.for_sale {
//            self.isAllowSegue = true
//            self.selectedPhoto = photo
//        }else {
//            self.isAllowSegue = false
//            self.selectedPhoto = nil
//            self.alertMessage = "This item is not for sale"
//        }
//
//    }
//}
