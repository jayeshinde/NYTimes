//
//  UINavigationBarExtension.swift
//  NYTimes
//
//  Created by Jayesh Shinde on 8/16/19.
//  Copyright © 2019 Jayesh Shinde. All rights reserved.
//

import UIKit
import Foundation

extension UINavigationBar {

  func setBarColor(_ barColor: UIColor?) {
    if let color = barColor {
      if color.cgColor.alpha == 0 {
        self.setBackgroundImage(UIImage(), for: .default)
        self.hideShadow(true)
      } else {
        self.setBackgroundImage(self.image(with: color), for: .default)
        self.hideShadow(true)
      }
    } else {
      self.setBackgroundImage(nil, for: .default)
      self.hideShadow(false)
    }
  }

  func hideShadow(_ hide: Bool) {
    self.shadowImage = hide ? UIImage() : nil
  }

  func image(with color: UIColor) -> UIImage {
    let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
    UIGraphicsBeginImageContext(rect.size)
    if let context = UIGraphicsGetCurrentContext() {
      context.setFillColor(color.cgColor)
      context.fill(rect)
    }
    let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
}
