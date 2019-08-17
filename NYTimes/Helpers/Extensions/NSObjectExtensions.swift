//
//  NSObjectExtensions.swift
//  NYTimes
//
//  Created by Jayesh Shinde on 8/16/19.
//  Copyright © 2019 Jayesh Shinde. All rights reserved.
//

import Foundation

extension Encodable {

  var toDictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}

extension Decodable {

  static func decode(from data: Data) throws -> Self? {
    do {
      let decoder = JSONDecoder()
      return try decoder.decode(Self.self, from: data)
    } catch let error as DecodingError {
      print("error : ", error)
      return nil
    }
  }

  static func decode(from data: Data, keyPath: String) throws -> Self? {
    let toplevel = try JSONSerialization.jsonObject(with: data)
    if let nestedJson = (toplevel as AnyObject).value(forKeyPath: keyPath) {
      let nestedJsonData = try JSONSerialization.data(withJSONObject: nestedJson)
      return try decode(from: nestedJsonData)
    } else {
      throw GenericErrorType.conversionFailure
    }
  }

}

enum GenericErrorType: Error {

  case requestFailed
  case conversionFailure
  case invalidData
  case unsuccessfulStatusCode(code: Int)
  case parsingFailure

  var localizedDescription: String {
    return "Teknik bir nedenle işleminiz şuan gerçekleştiremiyoruz."
    //        switch self {

    //        case .requestFailed: return "Request Failed"
    //        case .invalidData: return "Invalid Data"
    //        case .unsuccessfulStatusCode: return "Response Unsuccessful"
    //        case .parsingFailure: return "Parsing Failure"
    //        case .conversionFailure: return "Conversion Failure"
    //        }
  }

  var message: String {
    return String(format: "%@(%d)", "error occoured", code)
  }

  var code: Int {
    switch self {
    case .requestFailed:
      return 10101
    case .conversionFailure:
      return 10102
    case .parsingFailure:
      return 10103
    case .invalidData:
      return 10105
    case .unsuccessfulStatusCode(let code):
      return code
    }
  }
}
