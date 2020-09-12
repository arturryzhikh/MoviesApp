//
//  TMDbApi.swift
//  MoviesApp
//
//  Created by Artur R on 18.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//



enum Api {
  static let apiKey = "be0534e846d5abd01a6b93c899d51676"
  static let baseURL = "https://api.themoviedb.org/3"
  static let imageBaseURL = "https:/k/image.tmdb.org/t/p/w780"
  static let searchMoviePath = "/search/movie"
  private static let trendingPath = "/trending"
  static var trending: String {
    return Api.baseURL + Api.trendingPath
  }
  static var searchMovie: String {
    Api.baseURL + Api.searchMoviePath
  }
  
}

