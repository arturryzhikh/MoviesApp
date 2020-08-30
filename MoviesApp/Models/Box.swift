//
//  Box.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 30.08.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

class Box<T> {
  typealias Observer = (T) -> Void
  var observer: Observer?
  var value: T {
    didSet {
      observer?(value)
    }
  }
  
  init(_ value: T) {
    self.value = value
  }
  
  func bind(observer: Observer?) {
    self.observer = observer
    observer?(value)
  }
}
