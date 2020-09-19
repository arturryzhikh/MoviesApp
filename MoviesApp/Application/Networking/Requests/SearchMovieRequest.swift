//
//  SearchMovieRequest.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 13.09.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import Foundation

struct SearchMovieRequest: APIRequest {
  
  var parameters: [String : String] = [:]
  var endPoint: String {
    return API.searchEndpoint
  }
  let query: String
  let page: Int
  typealias Response = PaginatedMoviesResponse
  init(query: String, page: Int = 1) {
    self.query = query
    self.page = page
    parameters["query"] = query
    parameters["page"] =  "\(page)"
  }
}
