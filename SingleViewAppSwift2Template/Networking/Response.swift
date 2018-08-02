//
//  Result.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 28/07/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

enum Response<T, U> where U: Error {
  case success(T)
  case failure(U)
}
