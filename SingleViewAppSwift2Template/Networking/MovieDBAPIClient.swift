//
//  MovieDBAPIClient.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 28/07/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

class MovieDBAPIClient: APIClient {
  internal let session: URLSession
  
  private let apiKey = "00360b6e284010719851edbb5f299d99"
  
  init(configuration: URLSessionConfiguration) {
    self.session = URLSession(configuration: configuration)
  }
  
  convenience init() {
    self.init(configuration: .default)
  }
  
  typealias GenresListCompletionHandler = (Response<Genres?, APIError>) -> Void
  func getGenres(completion: @escaping GenresListCompletionHandler) {
    let request = MovieDB.genresList(apiKey: apiKey).request
    
    fetch(with: request, decode: { json -> Genres? in
      guard let genres = json as? Genres else { return nil }
      return genres
    }, completion: completion)
  }
  
  typealias PeopleListCompletionHandler = (Response<People?, APIError>) -> Void
  func getPeople(fromPage page: Int, completion: @escaping PeopleListCompletionHandler) {
    let request = MovieDB.popularPeople(apiKey: apiKey, page: page).request
    
    fetch(with: request, decode: { json -> People? in
      guard let people = json as? People else { return nil }
      return people
    }, completion: completion)
  }
  
  typealias MoviesListCompletionHandler = (Response<Movies?, APIError>) -> Void
  func getMovies(fromPage page: Int, peopleIds: String, genresIds: String, avgVote: String, completion: @escaping MoviesListCompletionHandler) {
    let request = MovieDB.moviesList(apiKey: apiKey, page: "\(page)", genres: genresIds, people: peopleIds, AVGVote: avgVote).request

    fetch(with: request, decode: { json -> Movies? in
      guard let movies = json as? Movies else { return nil }
      return movies
    }, completion: completion)
  }

}
