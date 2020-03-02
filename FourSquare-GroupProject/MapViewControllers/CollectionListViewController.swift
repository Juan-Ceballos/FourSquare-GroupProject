//
//  CollectionListViewController.swift
//  FourSquare-GroupProject
//
//  Created by Eric Davenport on 3/2/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
import DataPersistence

class CollectionListViewController: UIViewController {
  
  private var listView = CollectionSelectionView()
  
  private let venue : Venue!
  
  public var categories = [AlbumCollection]() {
    didSet {
      DispatchQueue.main.async {
        self.listView.tableView.reloadData()
      }
    }
  }
  
  let dataPersist : DataPersistence<AlbumCollection>
  
  init(_ dataPersistence: DataPersistence<AlbumCollection>, venue: Venue) {
    self.dataPersist = dataPersistence
    self.venue = venue
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("unable to load")
  }
  

  
  override func loadView() {
    view = listView
  }

    override func viewDidLoad() {
        super.viewDidLoad()
      listView.tableView.delegate = self
      listView.tableView.dataSource = self
      loadList()
      listView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "listCell")
        // Do any additional setup after loading the view.
    }
  
  func loadList() {
    do {
      categories = try dataPersist.loadItems()
      print(categories.count)
    } catch {
     print("unable to load categories")
    }
  }
    


}

extension CollectionListViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
    let category = categories[indexPath.row]
    cell.backgroundColor = .orange
    cell.textLabel?.text = category.title
    return cell
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories.count
  }
  
}

extension CollectionListViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("item added")
//    let dataP = DataPersistence<Venue>(filename: "collections.plist")
    let collection = categories[indexPath.row]
    var category = categories[indexPath.row].arrVenues
    category.append(venue)
    print(category)
    var newCollection = AlbumCollection(title: collection.title, arrVenues: category, image: nil)

    
    do {
        try dataPersist.update(collection, with: newCollection)
    print("success")
      } catch {
        print("fail")
      }
  }
}
