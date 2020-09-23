//
//  DataSource.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 23.09.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import Foundation
protocol DataSourceDelegate: class {
  func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
  func onFetchFailed(with reason: String)
  func isFetching()
}
 protocol DataSource {
  associatedtype Request: APIRequest
  var delegate: DataSourceDelegate? { get }
  var apiClient: APIClient { get }
  var cellViewModels: [MovieViewModel] { get }
  var currentPage: Int { get }
  var isFetching: Bool { get }
  var request: Request { get }
  var total: Int { get }
  var totalCount: Int { get }
  var currentCount: Int { get }
  func cellViewModel(at IndexPath: IndexPath) -> MovieViewModel
  func calculateIndexPathsToReload(from newCellViewModels: [MovieViewModel]) -> [IndexPath]
  func fetch()
  init(apiClient: APIClient,request: Request, delegate: DataSourceDelegate)
}

final class ExperimentalSearchMovieViewModel: DataSource {
  typealias Request = SearchMovieRequest
  weak var delegate: DataSourceDelegate?
  var apiClient: APIClient
  var cellViewModels: [MovieViewModel] = []
  var currentPage: Int = 1
  var isFetching: Bool = false
  var request: Request
  var total = 1
  var totalCount: Int {
    return total
  }
  var currentCount: Int {
    return cellViewModels.count
  }
  func cellViewModel(at IndexPath: IndexPath) -> MovieViewModel {
    return cellViewModels[IndexPath.row]
  }
  
  func calculateIndexPathsToReload(from newCellViewModels: [MovieViewModel]) -> [IndexPath] {
    let startIndex = cellViewModels.count - newCellViewModels.count
    let endIndex = startIndex + newCellViewModels.count
    return (startIndex..<endIndex).map { IndexPath(row: $0, section: 1) }
  }
  
  init(apiClient: APIClient = Client(), request: SearchMovieRequest, delegate: DataSourceDelegate) {
    self.apiClient = apiClient
    self.request = request
    self.delegate = delegate
  }
  
 
    
  
  
}

extension ExperimentalSearchMovieViewModel {
  func fetch() {
    guard !isFetching else {
        return
      }
      isFetching = true
    apiClient.request(request) { (result) in
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
              self.cellViewModels.append(contentsOf: newCellViewModels)
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
