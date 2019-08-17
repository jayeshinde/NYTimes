//
//  URLSessionRequestClient.swift
//  NYTimes
//
//  Created by Jayesh Shinde on 8/16/19.
//  Copyright © 2019 Jayesh Shinde. All rights reserved.
//

import Foundation

class Network: NSObject {

  typealias SuccessCallback<T> = (_ response: T) -> Void
  typealias FailCallback = (_ error: String) -> Void

  public static let instance = Network()

  private var session: URLSession?

  override init() {
    super.init()
    session = URLSession.init(configuration: .default, delegate: self, delegateQueue: nil)
  }

  func request<T: Decodable>(_ httpMethodType: RequestMethod = .get,
                             params: [String: Any],
                             section: String,
                             dayType: String,
                             onSuccess: @escaping SuccessCallback<T>,
                             onFailed: @escaping FailCallback ) {

    var requestString = String.init(format: Configurations.requestUrl, section, dayType)

    var urlRequest: URLRequest?

    if httpMethodType == .post {
      urlRequest = URLRequest.init(url: URL.init(string: requestString)!)
      let httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
      urlRequest!.httpBody = httpBody
    } else {
      if params.count > 0 {
        for (k, v) in params {
          requestString = "\(requestString)&\(k)=\(v)"
        }
      }
      urlRequest = URLRequest.init(url: URL.init(string: requestString)!)
    }

    urlRequest!.httpMethod = httpMethodType.value
    urlRequest!.timeoutInterval = Configurations.CONNECTION_TIMEOUT
    urlRequest!.addValue("application/json", forHTTPHeaderField: "Content-Type")
    urlRequest!.addValue("application/json", forHTTPHeaderField: "Accept")

    let dataTask = session?.dataTask(with: urlRequest!, completionHandler: { (data, response, error) in
      guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
        else {
          print("error: not a valid http response")
          return
      }

      switch (httpResponse.statusCode) {
      case 200:
        do {
          let getResponse = try JSONSerialization.jsonObject(with: receivedData, options: .allowFragments)
          print("Response : ", getResponse)
          if let obj = try T.decode(from: data!) {
            onSuccess(obj)
          }
        } catch {
          print("error serializing JSON: \(error)")
          onFailed("Error \(error.localizedDescription)")
        }
      case 400:
        onFailed("Error \(httpResponse.statusCode)")
      default:
        print("Error \(httpResponse.statusCode)")
        onFailed("Error \(httpResponse.statusCode)")
      }
    })

    dataTask?.resume()

  }

}

extension Network: URLSessionDelegate {
  func urlSession(_ session: URLSession,
                  didReceive challenge: URLAuthenticationChallenge,
                  completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {}
}
