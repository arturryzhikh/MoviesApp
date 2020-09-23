//
//  TrendingRequest.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 13.09.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import Foundation
struct TrendingRequest: APIRequest {

  var parameters: [String : String] = [:]
  typealias Response = MoviesResponse
  var endPoint: String {
    return API.trendingMovieEndpoint
  }
  
}


