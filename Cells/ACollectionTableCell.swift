//
//  ACollectionCellTableViewCell.swift
//  FourSquare-GroupProject
//
//  Created by Eric Davenport on 2/27/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class ACollectionTableCell: UITableViewCell {

  public lazy var venueImage : UIImageView = {
    let iv = UIImageView()
    iv.backgroundColor = .white
    return iv
  }()
  
  public lazy var titleLabel : UILabel = {
    let label = UILabel()
    label.backgroundColor = .white
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.text = "Title Label"
    return label
  }()
  
  public lazy var addressLabel : UILabel = {
    let label = UILabel()
    label.backgroundColor = .white
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.text = "Address Label"
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }


  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    imageConstraints()
    titleLabelConstraint()
    addressLabelConstraint()
  }

  private func imageConstraints() {
    addSubview(venueImage)
    venueImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      venueImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      venueImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      venueImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
      venueImage.widthAnchor.constraint(equalToConstant: 100)
    ])
  }
  
  private func titleLabelConstraint() {
    addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      titleLabel.leadingAnchor.constraint(equalTo: venueImage.trailingAnchor, constant: 10),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
    ])
  }
  
  private func addressLabelConstraint() {
    addSubview(addressLabel)
    addressLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      addressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
      addressLabel.leadingAnchor.constraint(equalTo: venueImage.trailingAnchor, constant: 10),
      addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
    ])
  }
  
}
