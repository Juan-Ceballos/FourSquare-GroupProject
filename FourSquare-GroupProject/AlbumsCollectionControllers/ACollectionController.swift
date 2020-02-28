//
//  ACollectionController.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
import DataPersistence

class ACollectionController: UIViewController {
  
  private var aCollectionView = ACollectioniView()
  
  private var dataPersistence : DataPersistence<AlbumCollection>
  
  private var savedVenues = [Venue]() {
    didSet {
      self.aCollectionView.tableView.reloadData()
    }
  }
  
  init(_ dataPersistence: DataPersistence<AlbumCollection>, venue: [Venue]) {
    self.dataPersistence = dataPersistence
    savedVenues = venue
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder: ) has not been implemented")
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
    return 0
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      deleteSavedVenue(atIndexPath: indexPath)
    }

  }
  
  private func deleteSavedVenue(atIndexPath indexPath: IndexPath) {
    // remove from saved venues array
    savedVenues.remove(at: indexPath.row)
    // remove from tableview
    aCollectionView.tableView.deleteRows(at: [indexPath], with: .fade)
  }
  
  
}
