//
//  ResponseError.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 13.09.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import Foundation
enum ResponseError: Error {
  case network
  case decoding

  var reason: String {
    switch self {
    case .network:
      return "An error occurred while fetching data "
    case .decoding:
      return "An error occurred while decoding data"
    }
  }
}
