//
//  TMDbApi.swift
//  MoviesApp
//
//  Created by Artur R on 18.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import Foundation
struct TMDbApi {
  static let apiKey = "be0534e846d5abd01a6b93c899d51676"
  static let baseURL = "https://api.themoviedb.org/3"
  static let searchMoviesEndpoint = "/search/movie"
  static let imageBaseUrl = "https://image.tmdb.org/t/p/w92"
  static let searchMovies = TMDbApi.baseURL + TMDbApi.searchMoviesEndpoint
}

