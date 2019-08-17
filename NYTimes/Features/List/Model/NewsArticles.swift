//
//  NewsArticles.swift
//  NYTimes
//
//  Created by Jayesh Shinde on 8/16/19.
//  Copyright © 2019 Jayesh Shinde. All rights reserved.
//

import Foundation

struct FetchedResponse: Codable {
  let status, copyright: String
  let numResults: Int
  let results: [Article]

  enum CodingKeys: String, CodingKey {
    case status, copyright
    case numResults = "num_results"
    case results
  }
}
