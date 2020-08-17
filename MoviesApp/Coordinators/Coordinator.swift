//
//  Coordinator.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 17.08.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//
import UIKit
protocol Coordinator {
  var children: [Coordinator] { get set }
  var navigation: UINavigationController { get set }
  func start()
}

