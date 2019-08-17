//
//  DetailViewModel.swift
//  NYTimes
//
//  Created by Jayesh Shinde on 8/17/19.
//  Copyright © 2019 Jayesh Shinde. All rights reserved.
//

struct Article: Codable {
  let url: String
  let adxKeywords: String
  let column: String?
  let section, byline: String
  let type: ResultType
  let title, abstract, publishedDate: String
  let source: Source
  let id, assetID, views: Int
  let desFacet, orgFacet, perFacet, geoFacet: Facet
  let media: [Media]

  enum CodingKeys: String, CodingKey {
    case url
    case adxKeywords = "adx_keywords"
    case column, section, byline, type, title, abstract
    case publishedDate = "published_date"
    case source, id
    case assetID = "asset_id"
    case views
    case desFacet = "des_facet"
    case orgFacet = "org_facet"
    case perFacet = "per_facet"
    case geoFacet = "geo_facet"
    case media
  }
}

enum Facet: Codable {
  case string(String)
  case stringArray([String])

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let x = try? container.decode([String].self) {
      self = .stringArray(x)
      return
    }
    if let x = try? container.decode(String.self) {
      self = .string(x)
      return
    }
    throw DecodingError.typeMismatch(Facet.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Facet"))
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case .string(let x):
      try container.encode(x)
    case .stringArray(let x):
      try container.encode(x)
    }
  }
}

struct Media: Codable {
  let type: MediaType
  let subtype: Subtype
  let caption, copyright: String?
  let approvedForSyndication: Int
  let mediaMetadata: [MediaMetadatum]

  enum CodingKeys: String, CodingKey {
    case type, subtype, caption, copyright
    case approvedForSyndication = "approved_for_syndication"
    case mediaMetadata = "media-metadata"
  }
}

struct MediaMetadatum: Codable {
  let url: String
  let format: Format
  let height, width: Int
}

enum Format: String, Codable {
  case jumbo = "Jumbo"
  case large = "Large"
  case largeThumbnail = "Large Thumbnail"
  case mediumThreeByTwo210 = "mediumThreeByTwo210"
  case mediumThreeByTwo440 = "mediumThreeByTwo440"
  case normal = "Normal"
  case square320 = "square320"
  case square640 = "square640"
  case standardThumbnail = "Standard Thumbnail"
  case superJumbo = "superJumbo"
}

enum Subtype: String, Codable {
  case photo = "photo"
}

enum MediaType: String, Codable {
  case image = "image"
}

enum Source: String, Codable {
  case theNewYorkTimes = "The New York Times"
}

enum ResultType: String, Codable {
  case article = "Article"
  case interactive = "Interactive"
}
