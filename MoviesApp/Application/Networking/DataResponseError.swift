//
//  DataResponseError.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 12.09.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//
import Foundation
enum DataResponseError: Error {
  case network
  case decoding
  case request
  var reason: String {
    switch self {
    case .network:
      return "Error Fetching Data"
    case .decoding:
      return "Error Decoding Data"
    case .request:
      return "Error constructing URLRequest"
    }
  }
}

