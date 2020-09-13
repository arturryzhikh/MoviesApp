//
//  TrendingRequest.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 13.09.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import Foundation
struct TrendingRequest: APIRequest {
  typealias Response = Movies
  var endPoint: String {
    return "https://api.themoviedb.org/3/trending/movie/week"
  }
 
  func url() -> URL {
    var urlComponents = URLComponents(string: endPoint)
    let queryItems = [URLQueryItem(name: "api_key", value: API.apiKeyStatic)]
    urlComponents?.queryItems = queryItems
    let url = urlComponents?.url
    return url!
  }
 
}

extension APIRequest {
  func url() -> URL {
    var urlComponents = URLComponents(string: endPoint)
    let queryItems = [URLQueryItem(name: "api_key", value: API.apiKeyStatic)]
    urlComponents?.queryItems = queryItems
    let url = urlComponents?.url
    return url!
  }
}

struct OGm: APIRequest {
  var endPoint: String
  typealias Response = Movies
  
  
}
