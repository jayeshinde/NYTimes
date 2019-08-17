//
//  NewsListViewController.swift
//  NYTimes
//
//  Created by Jayesh Shinde on 8/16/19.
//  Copyright © 2019 Jayesh Shinde. All rights reserved.
//

import UIKit

class NewsListVC: BaseVC {
  private let refreshControl = UIRefreshControl()
  @IBOutlet fileprivate weak var tableView: UITableView!
  @IBOutlet fileprivate weak var lblNoData: UILabel!

  var newsLoaded = {() -> Void in }

  var selectedItem = {(_ item: Article) -> Void in }

  fileprivate var nyTimesNews: FetchedResponse? {
    didSet {
      FetchedNews = nyTimesNews?.results
    }
  }

  fileprivate var FetchedNews: [Article]? {
    didSet {
      newsLoaded()
    }
  }

  func hasNews() -> Bool {
    guard let filtered = FetchedNews else { return false }
    return filtered.count != 0
  }

  deinit {
    print("NewsListVC deinit")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}

extension NewsListVC {
  fileprivate func setupUI() {
    self.viewBackgroundColor = Theme.Colors.backgroundLight.color
    self.viewBackgroundColor = Theme.Colors.backgroundLight.color
    newsLoaded = { [weak self] in
      DispatchQueue.main.async {
        self?.tableReload()
      }
    }
    selectedItem = { [weak self] (item) in
      DispatchQueue.main.async {
        let vc = ArticleDetailVC.instantiate()
        vc.model = item
        self?.navigationController?.pushViewController(vc, animated: true)
      }
    }
    setupTableView()
    loadNews()
  }

  private func tableReload() {
    DispatchQueue.main.async {
      self.lblNoData.isHidden = self.hasNews()
      self.tableView.isHidden = !self.hasNews()
      self.tableView.reloadData()
      self.refreshControl.endRefreshing()
    }
  }

  private func setupTableView() {
    tableView.backgroundColor = Theme.Colors.backgroundLight.color
    if #available(iOS 10.0, *) {
      tableView.refreshControl = refreshControl
    } else {
      tableView.addSubview(refreshControl)
    }
    refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.estimatedRowHeight = 131
    tableView.rowHeight = UITableView.automaticDimension
    let nib = UINib(nibName: "NewsItemCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: "NewsItemCell")
  }

  @objc private func refreshData(_ sender: Any) {
    loadNews()
  }

  @IBAction func continueClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
}

extension NewsListVC: StoryboardInstantiable {
  static var storyboardName: String { return "Main" }
  static var storyboardIdentifier: String? { return "NewsListVC" }
}

extension NewsListVC: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let _ = nyTimesNews else { return 0 }
    return FetchedNews!.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = FetchedNews![indexPath.row]
    let cell: NewsItemCell = tableView.dequeueReusableCell(withIdentifier: "NewsItemCell") as! NewsItemCell
    cell.update(item)
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell: NewsItemCell = tableView.cellForRow(at: indexPath) as! NewsItemCell
    selectedItem(cell.newsModel)
  }

  func reload(_ tableView: UITableView, at index: IndexPath) {
    tableView.reloadRows(at: [index], with: .automatic)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}

extension NewsListVC {

  func loadNews() {
    Network.instance.request(RequestMethod.get,
                             params: [:],
                             section: "all-sections",
                             dayType: "30",
                             onSuccess: { (response: FetchedResponse) in
                                self.nyTimesNews = response
                             })
                             { (error) in
                                print(error)
                             }
  }
}
