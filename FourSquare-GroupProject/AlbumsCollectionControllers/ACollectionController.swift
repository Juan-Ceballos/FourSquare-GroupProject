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
  
  override func loadView() {
    view = aCollectionView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    aCollectionView.tableView.dataSource = self
    aCollectionView.tableView.register(ACollectionTableCell.self, forCellReuseIdentifier: "aCollectionCell")
    
  }
  

  
}

extension ACollectionController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "aCollectionCell", for: indexPath)
    
    cell.backgroundColor = .systemPurple
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
}
