//
//  Endpoint.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 28/07/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

protocol Endpoint {
  var base: String { get }
  var path: String { get }
  var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
  var urlComponents: URLComponents {
    var components = URLComponents(string: base)!
    components.path = path
    components.queryItems = queryItems
    
    return components
  }
  
  var request: URLRequest {
    let url = urlComponents.url!
    return URLRequest(url: url)
  }
}


enum MovieDB {
  case genresList(apiKey: String)
  case popularPeople(apiKey: String, page: Int)
}

extension MovieDB: Endpoint {
  var base: String {
    return "https://api.themoviedb.org"
  }
  
  var path: String {
    switch self {
    case .genresList: return "/3/genre/movie/list"
    case .popularPeople: return "/3/person/popular"
    }
  }
  
  var queryItems: [URLQueryItem] {
    switch self {
    case .genresList(let apiKey):
      return [
        URLQueryItem(name: "api_key", value: apiKey)
      ]
    case .popularPeople(let apiKey, let page):
      return [
        URLQueryItem(name: "api_key", value: apiKey),
        URLQueryItem(name: "page", value: "\(page)")
      ]
    }
  }
}
