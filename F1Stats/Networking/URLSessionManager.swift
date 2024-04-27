//
//  URLSessionManager.swift
//  F1Wiki
//
//  Created by Guilherme Carvalho on 26/04/2024.
//

import Foundation

class URLSessionManager {

  static let urlSession: URLSession = {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 5
    configuration.timeoutIntervalForResource = 5
    return URLSession(configuration: configuration)
  }()
}