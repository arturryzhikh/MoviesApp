//
//  Result.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 12.09.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

enum Result<T, U: Error> {
  case success(T)
  case failure(U)
}
