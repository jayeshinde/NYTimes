//
//  StoryBoradExtensions.swift
//  NYTimes
//
//  Created by Jayesh Shinde on 8/16/19.
//  Copyright © 2019 Jayesh Shinde. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardInstantiable {

  static var storyboardName: String { get }
  static var storyboardBundle: Bundle? { get }
  static var storyboardIdentifier: String? { get }
}

extension StoryboardInstantiable {

  static var storyboardIdentifier: String? { return nil }
  static var storyboardBundle: Bundle? { return nil }

  static func instantiate() -> Self {

    let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)

    if let storyboardIdentifier = storyboardIdentifier {
      return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    } else {
      return storyboard.instantiateInitialViewController() as! Self
    }
  }
}
