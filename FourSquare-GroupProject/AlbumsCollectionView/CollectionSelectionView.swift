//
//  CollectionSelectionView.swift
//  FourSquare-GroupProject
//
//  Created by Eric Davenport on 3/2/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class CollectionSelectionView: UIView {

  public lazy var tableView : UITableView = {
    let tv = UITableView()
    tv.backgroundColor = .purple
    return tv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: UIScreen.main.bounds)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    tableConstraints()
  }
  
  private func tableConstraints() {
    addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }


}
