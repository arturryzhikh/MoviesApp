//
//  Request.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 12.09.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//
import Foundation

typealias Parameters = [String: String]

extension URLRequest {
  func encode(with parameters: Parameters?) -> URLRequest {
    guard let parameters = parameters else {
      return self
    }
    var encodedURLRequest = self
    if let url = self.url,
       let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
       !parameters.isEmpty {
      var newUrlComponents = urlComponents
      let queryItems = parameters.map {
        URLQueryItem(name: $0, value: $1)
      }
      newUrlComponents.queryItems = queryItems
      encodedURLRequest.url = newUrlComponents.url
      return encodedURLRequest
    } else {
      return self
    }
  }
}

