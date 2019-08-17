//
//  DetailNewsViewController.swift
//  NYTimes
//
//  Created by Jayesh Shinde on 8/16/19.
//  Copyright © 2019 Jayesh Shinde. All rights reserved.
//

import UIKit

class ArticleDetailVC: BaseVC {

  @IBOutlet weak var articleTitle: UILabel!
  @IBOutlet weak var imgArticle: UIImageView!
  @IBOutlet weak var author: UILabel!
  @IBOutlet weak var abstractText: UILabel!

  var model: Article? {
    didSet {
      updateUI()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  fileprivate func updateUI() {
    if model != nil && articleTitle != nil {
      setAuthor(_author: model?.byline)
      setArticleTitle(title: model?.title)
      setArticleImage(imgUrlStr: model?.media[0].mediaMetadata[0].url)
    }
  }

  @IBAction func full(_ sender: Any) {
      UIApplication.shared.open(URL.init(string: model!.url)!, options: [:]) { (_) in
    }
  }

  func setArticleTitle(title: String?) {
    if let titleStr = title {
      articleTitle.text = titleStr
    }
  }

  func setAuthor(_author: String?) {
    if let authorStr = _author {
      author.text = authorStr
    }
  }

  func setArticleImage(imgUrlStr: String?) {
    guard let urlStr = imgUrlStr else {
      return
    }
    let _url = URL(string: urlStr)!
    loadImage(url: _url)
  }

  func loadImage(url: URL) {
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self?.imgArticle.image = image
          }
        }
      }
    }
  }

}

extension ArticleDetailVC: StoryboardInstantiable {
  static var storyboardName: String { return "Main" }
  static var storyboardIdentifier: String? { return "ArticleDetailVC" }
}
