//
//  SearchMoviesResult.swift
//  MoviesApp
//
//  Created by Artur R on 16.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//


struct MoviesResponse: Decodable {
  let results: [Movie]?
  let page: Int?
  let totalResults: Int?
  let totalPages: Int?
}
