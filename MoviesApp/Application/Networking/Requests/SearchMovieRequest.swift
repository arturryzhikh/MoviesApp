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
    return "https://api.themoviedb.org/3/search/movie"
  }
  let query: String
  let page: Int
  typealias Response = Movies
  
  init(query: String, page: Int = 1) {
    self.query = query
    self.page = page
    parameters.updateValue(query, forKey: "query")
    parameters.updateValue("\(page)", forKey: "page")
  }
  
  
}
