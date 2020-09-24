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
  func calculateIndexPathsToReload(from newCellViewModels: [MovieViewModel], section: Int) -> [IndexPath]
  func fetch()
  init(apiClient: APIClient,request: Request, delegate: DataSourceDelegate)
}


