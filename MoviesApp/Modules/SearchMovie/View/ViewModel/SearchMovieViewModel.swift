//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by Artur R on 17.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit
protocol SearchMovieViewModelDelegate: class {
  func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
  func onFetchFailed(with reason: String)
  func isFetching()
}

final class SearchMovieViewModel {
  
  private weak var delegate: SearchMovieViewModelDelegate?
  
  private var movieViewModels : [MovieViewModel] = []
  private var currentPage = 1
  private var total = 0
  private var isFetching = false {
    didSet {
      if isFetching {
        delegate?.isFetching()
      }
    }
  }
  var totalCount: Int {
    return total
  }
  
  var currentCount: Int {
    return movieViewModels.count
  }
  private let apiService : APIClient
  let request: SearchMovieRequest
  
  init(apiService: APIClient = Client() ,request: SearchMovieRequest,
       delegate: SearchMovieViewModelDelegate) {
    self.request = request
    self.delegate = delegate
    self.apiService = apiService
  }
  
 
  
  func movieViewModel(at indexPath: IndexPath) -> MovieViewModel {
    return movieViewModels[indexPath.row]
  }
  private func calculateIndexPathsToReload(from newMovieViewModels: [MovieViewModel]) -> [IndexPath] {
    let startIndex = movieViewModels.count - newMovieViewModels.count
    let endIndex = startIndex + newMovieViewModels.count
    return (startIndex..<endIndex).map { IndexPath(row: $0, section: 1) }
  }
  func fetchMovies() {
    guard !isFetching else {
      return
    }
    isFetching = true
    apiService.request(request) { (result) in
      switch result {
      case .failure(let error):
        DispatchQueue.main.async {
          self.isFetching = false
          self.delegate?.onFetchFailed(with: error.reason)
        }
      case .success(let response):
        DispatchQueue.main.async {
          self.currentPage += 1
          self.isFetching = false
          if let totalResults = response.totalResults {
            self.total = totalResults
          }
          if let movies = response.results {
            let newCellViewModels = movies.map {MovieViewModel(movie: $0)}
            self.movieViewModels.append(contentsOf: newCellViewModels)
            if let page = response.page,
               page > 1 {
              let indexPathsToReload = self.calculateIndexPathsToReload(from: newCellViewModels)
              self.delegate?.onFetchCompleted(with: indexPathsToReload)
            } else {
              self.delegate?.onFetchCompleted(with: .none)
            }
          }
        }
      }
    }
  }
}
