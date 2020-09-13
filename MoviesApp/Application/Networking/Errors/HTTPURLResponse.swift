//
//  Networking.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 13.09.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import Foundation
/*
 APIRequest: value types that will create the JSON request.
 APIResponse: value types that will be created from the JSON response.
 APIClient: will receive requests, send them to the server and then notify the caller via a callback.
 */
//

extension HTTPURLResponse {
  var statusOK: Bool {
    return (200...299).contains(statusCode)
  }
}









