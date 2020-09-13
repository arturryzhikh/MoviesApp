//
//  TMDbApi.swift
//  MoviesApp
//
//  Created by Artur R on 18.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//



struct API {
  static let apiKeyStatic = "be0534e846d5abd01a6b93c899d51676"
  let apiKey: String
  private let baseURL = "https://api.themoviedb.org/3"
  private let searchMoviesEndpoint = "/search/movie"
  let imageBaseUrl = "https://image.tmdb.org/t/p/w780"
  let trendingBaseUrl = "https://api.themoviedb.org/3/trending/movie/week"
  var searchMovies: String {
    baseURL + searchMoviesEndpoint
  }
  init(key: String) {
    self.apiKey = key
   }
}

