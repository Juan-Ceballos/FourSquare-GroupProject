//
//  ACollectionController.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class ACollectionController: UIViewController {
  
  private var aCollectionView = ACollectioniView()
  
  private var savedVenues = [Venue]() {
    didSet {
      self.aCollectionView.tableView.reloadData()
    }
  }
  
  private var refreshController: UIRefreshControl!
  
  override func loadView() {
    view = aCollectionView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    aCollectionView.tableView.dataSource = self
    aCollectionView.tableView.register(ACollectionTableCell.self, forCellReuseIdentifier: "aCollectionCell")
    configureRefreshController()
  }
  
  private func configureRefreshController() {
    refreshController = UIRefreshControl()
    aCollectionView.tableView.refreshControl = refreshController
    refreshController.addTarget(self, action: #selector(reloadTableView), for: .valueChanged)
  }
  
  @objc private func reloadTableView() {
    DispatchQueue.main.async {
      self.aCollectionView.tableView.reloadData()
      self.refreshController.endRefreshing()
    }
  }

  
}

extension ACollectionController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "aCollectionCell", for: indexPath) as? ACollectionTableCell else {
      fatalError("Unable to downcast as ACollectionTableCell")
    }
    let venue = savedVenues[indexPath.row]
    cell.configCell(venue: venue)
    cell.backgroundColor = .systemPurple
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
}
