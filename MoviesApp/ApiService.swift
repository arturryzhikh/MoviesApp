//
//  NetworkService.swift
//  MoviesApp
//
//  Created by Artur R on 13.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

final class ApiService {
  let session: URLSession
  init(session: URLSession = URLSession.shared) {
     self.session = session
   }
  //MARK: Trending
  func trending(with request: TrendingRequest,
                 completion: @escaping (Result<MovieResponse,DataResponseError>) -> Void) {
   
    guard let baseURL = URL(string: request.stringURL) else {
      completion(Result.failure(.request))
      return
    }
    let urlRequest = URLRequest(url: baseURL)
    session.dataTask(with: urlRequest) { (data, response, error) in
      guard
        let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusOK,
        let data = data
        else {
          completion(Result.failure(DataResponseError.network))
          return
      }
      guard let response = self.decodeJSON(data,
                                           into: MovieResponse.self) else {
                                            completion(Result.failure(.decoding))
                                            return
      }
      completion(Result.success(response))
    }.resume()
    
  }
}





private extension ApiService {
  func decodeJSON<T:Decodable>(_ data: Data?, into model: T.Type) -> T? {
    guard
      let data = data
      else {
      print("error decoding JSON into \(model)")
      return nil
    }
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let decodedJSON = try? decoder.decode(T.self, from: data)
    return decodedJSON
  }

}
   
  
//  private let session = URLSession.shared
//  private let imageChache = NSCache<NSString,UIImage>()
//func fetchImage(from path: String, completion : @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
//   guard
//    let url = URL(string: api.imageBaseURL + path) else {
//      completion(nil,nil)
//      return
//    }
//    let imageKey = url.absoluteString as NSString
//    if let cachedImage = imageChache.object(forKey: imageKey) {
//      completion(cachedImage,nil)
//
//    } else {
//      let task = session.dataTask(with: url) { data,response,error in
//             DispatchQueue.main.async {
//                guard let data = data,
//                let response = response as? HTTPURLResponse,
//                (200 ..< 300).contains(response.statusCode),
//                error == nil, let image = UIImage(data: data) else {
//                  completion(nil, error)
//                  print("Error downloading image \(String(describing: error))")
//                  return
//                }
//               self.imageChache.setObject(image, forKey: imageKey)
//               completion(image,nil)
//             }
//           }
//           task.resume()
//        }
//      }
//  func getTrending(for mediaType: String = "movie",
//                   timeWindow: String = "week",
//                   completion: @escaping (_ searchMoviesResult: Movies?, _ error: Error?) -> Void  ) {
//
//
//    var urlComponents = URLComponents(string: api.searchMoviePath)
//    var queryItems = [URLQueryItem]()
//    queryItems.append(URLQueryItem(name: "api_key", value: api.apiKey))
//    urlComponents?.queryItems = queryItems
//    guard
//      let url = urlComponents?.url else { return }
//      var request = URLRequest(url: url)
//      request.httpMethod = "GET"
//      let task = self.session.dataTask(with: request) { (data, response , error) in
//        DispatchQueue.main.async {
//          guard
//            let data = data,
//            let response = response as? HTTPURLResponse,
//            (200 ..< 300).contains(response.statusCode),
//            error == nil
//            else {
//              completion(nil, error)
//              return
//          }
//          let movies =  self.decodeJSON(from: data, into: Movies.self)
//          completion(movies,nil)
//        }
//      }
//      task.resume()
//    }
//  func searchMovies(query: String,
//                    completion: @escaping (_ searchMoviesResult: Movies?, _ error: Error?) -> Void ) {
//    var urlComponents = URLComponents(string: api.searchMovies)
//    var queryItems = [URLQueryItem]()
//    queryItems.append(URLQueryItem(name: "api_key", value: api.apiKey))
//    queryItems.append(URLQueryItem(name: "query", value: query))
//    urlComponents?.queryItems = queryItems
//    guard
//      let url = urlComponents?.url
//      else {
//        return
//    }
//    var request = URLRequest(url: url)
//    request.httpMethod = "GET"
//    let task = self.session.dataTask(with: request) { (data, response , error) in
//      DispatchQueue.main.async {
//        guard
//          let data = data,
//          let response = response as? HTTPURLResponse,
//          (200 ..< 300).contains(response.statusCode),
//          error == nil
//          else {
//            completion(nil, error)
//            return
//        }
//        let movies =  self.decodeJSON(from: data, into: Movies.self)
//        completion(movies,nil)
//      }
//    }
//    task.resume()
//  }
//
//  init() {
//    print("NetworkService Initialized")
//  }
//  deinit {
//    print("NetworkService Deinitialized")
//  }
//
//}
//
//private extension ApiService {




