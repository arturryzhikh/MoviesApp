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

enum DataResponseError: Error {
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


typealias ResultCallback<Value> = (Result<Value, Error>) -> Void

protocol APIClient {
 
  func send<T:APIRequest>(_ request: T,
                          completion: @escaping ResultCallback<T.Response>)
  
   
  
}

protocol APIRequest: Encodable {
  associatedtype Response: Decodable
  associatedtype Parameters: Encodable
  var endPoint: String { get }
  func url() -> URL
  
}

protocol APIResponse: Decodable {
  
}

struct TrendingRequest: APIRequest {
  typealias Parameters  = [String:String]
  typealias Response = Movies
  //Specific Parameters
  let mediaType: String
  let timeWindow: String
  var endPoint: String {
    return "https://api.themoviedb.org/3/trending"
      + mediaType
      + timeWindow
  }
  //Enums
  enum TimeWindow: String {
    case day = "/day"
    case week = "/week"
    
  }
  enum MediaType: String {
    case all = "/all"
    case movie = "/movie"
    case tv = "/tv"
    case person = "/person"
    }
  //Methods
  func url() -> URL {
    var urlComponents = URLComponents(string: endPoint)
    let queryItems = [URLQueryItem(name: "api_key", value: "be0534e846d5abd01a6b93c899d51676")]
    urlComponents?.queryItems = queryItems
    let url = urlComponents?.url
    return url!
  }
  //Initialization
  init(mediaType: MediaType, timeWindow: TimeWindow) {
    self.mediaType = mediaType.rawValue
    self.timeWindow = timeWindow.rawValue
  }
  

}


final class Client: APIClient {
  
  
  
  func send<T: APIRequest>(
      _ request: T,
      completion: @escaping ResultCallback<T.Response>) {
 
    let urlRequest = URLRequest(url: request.url())
    let session = URLSession.shared
    session.dataTask(with: urlRequest , completionHandler: { data, response, error in
      guard
        let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusOK ,
        let data = data
        else {
          completion(Result.failure(DataResponseError.network))
          return
       }
      guard let decoded = try? JSONDecoder().decode(T.Response.self, from: data) else {
        completion(Result.failure(DataResponseError.decoding))
        return
       }
      completion(Result.success(decoded))
     }).resume()
  }
}
