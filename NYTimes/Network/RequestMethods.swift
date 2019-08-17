//
//  RequestMethods.swift
//  NYTimes
//
//  Created by Jayesh Shinde on 8/16/19.
//  Copyright © 2019 Jayesh Shinde. All rights reserved.
//

enum RequestMethod {
  case get
  case post
  case put
  case delete

  var value: String {
    switch self {
    case .get: return "GET"
    case .post: return "POST"
    case .put: return "PUT"
    case .delete: return "DELETE"
    }
  }
}
