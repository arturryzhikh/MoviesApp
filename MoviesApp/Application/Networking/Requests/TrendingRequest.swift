//
//  SearchMovieRequest.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 12.09.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import Foundation

struct TrendingRequest {
  var stringURL: String {
    return Api.trending
  }
  let parameters: Parameters
  private init(parameters: Parameters) {
    self.parameters = parameters
  }
}

extension TrendingRequest {
  static var trending : TrendingRequest {
    let parameters = ["api_key": Api.apiKey, "media_type": "movie","time_window": "week"]
    return TrendingRequest(parameters: parameters)
  }
}
