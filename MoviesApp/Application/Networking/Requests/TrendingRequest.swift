//
//  TrendingRequest.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 13.09.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import Foundation
struct TrendingRequest: APIRequest {
  typealias Parameters  = [String:String]
  typealias Response = Movies
  //Specific Parameters
  let mediaType: String
  let timeWindow: String
  var endPoint: String {
    return "https://api.themoviedb.org/3/trending"
      + mediaType
      + timeWindow
  }
  //Enums
  enum TimeWindow: String {
    case day = "/day"
    case week = "/week"
    
  }
  enum MediaType: String {
    case all = "/all"
    case movie = "/movie"
    case tv = "/tv"
    case person = "/person"
    }
  //Methods
  func url() -> URL {
    var urlComponents = URLComponents(string: endPoint)
    let queryItems = [URLQueryItem(name: "api_key", value: API.apiKeyStatic)]
    urlComponents?.queryItems = queryItems
    let url = urlComponents?.url
    return url!
  }
  //Initialization
  init(mediaType: MediaType, timeWindow: TimeWindow) {
    self.mediaType = mediaType.rawValue
    self.timeWindow = timeWindow.rawValue
  }
  

}
