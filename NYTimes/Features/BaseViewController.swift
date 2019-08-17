//
//  BaseViewController.swift
//  NYTimes
//
//  Created by Jayesh Shinde on 8/16/19.
//  Copyright © 2019 Jayesh Shinde. All rights reserved.
//

import UIKit
import Foundation

@objc
class BaseVC: UIViewController, UIScrollViewDelegate {
  var baseScrollView: UIScrollView?
  var titleText: String?
  var centerTitleText: String?
  var noContentText: String?
  var secondTitleText: String?
  var viewBackgroundColor = Theme.Colors.white.color

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    view.backgroundColor = viewBackgroundColor
    self.navigationController?.setNavigationBarHidden(false, animated: false)
  }
}
