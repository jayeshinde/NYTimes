//
//  Theme.swift
//  NYTimes
//
//  Created by Jayesh Shinde on 8/16/19.
//  Copyright © 2019 Jayesh Shinde. All rights reserved.
//

import UIKit
import Foundation

struct Theme {

  enum Colors {
    case backgroundLight
    case white

    var color: UIColor {
      switch self {
      case .backgroundLight: return UIColor(red: 250 / 255, green: 250 / 255, blue: 250 / 255, alpha: 1.0)
      case .white: return UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1.0)
      }
    }
  }
}
