//
//  TMDbApi.swift
//  MoviesApp
//
//  Created by Artur R on 18.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import Foundation
struct TMDbApi {
  let apiKey: String
  private let baseURL = "https://api.themoviedb.org/3"
  private let searchMoviesEndpoint = "/search/movie"
  let imageBaseUrl = "https://image.tmdb.org/t/p/w200"
  let trendingBaseUrl = "https://api.themoviedb.org/3/trending/movie/week"
  let searchMovies: String
  init(key: String) {
    self.apiKey = key
    self.searchMovies =  baseURL + searchMoviesEndpoint
  }
}

