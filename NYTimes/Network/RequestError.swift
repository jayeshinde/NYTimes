//
//  RequestError.swift
//  NYTimes
//
//  Created by Jayesh Shinde on 8/16/19.
//  Copyright © 2019 Jayesh Shinde. All rights reserved.
//

enum RequestError {
  case noAuthorized
  case notFound
  case timeOut
  case invalidUrl
  case invalidResponse
  case invalidApiKey

  var code: Int {
    switch self {
    case .noAuthorized: return 403
    case .notFound: return 404
    case .timeOut: return 504
    default: return 0
    }
  }

  var description: String {
    switch self {
    case .noAuthorized: return "You are Not autorized"
    case .notFound: return "Resource Not Found"
    case .timeOut: return "Request TimeOut"
    case .invalidUrl: return "Invalid URL"
    case .invalidResponse: return "Invalid Response"
    case .invalidApiKey: return "Invalid Api Key"
    }
  }

  init(code: Int) {
    switch code {
    case 403: self = .noAuthorized
    case 404: self = .notFound
    case 504: self = .timeOut
    default: self = .invalidApiKey
    }
}
}
