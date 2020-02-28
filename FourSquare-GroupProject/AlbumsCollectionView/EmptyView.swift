//
//  EmptyView.swift
//  FourSquare-GroupProject
//
//  Created by Eric Davenport on 2/28/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class EmptyView: UIView {

  public lazy var titleLabel : UILabel = {
    let label = UILabel()
    label.text = "Title Label"
    label.textAlignment = .center
    label.numberOfLines = 0
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    return label
  }()
  
  public lazy var subtitleLabel : UILabel = {
    let label = UILabel()
    label.text = "subheader Label"
    label.textAlignment = .center
    label.numberOfLines = 0
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    return label
  }()
  
  init(title: String, message: String) {
    super.init(frame: UIScreen.main.bounds)
    titleLabel.text = title
    subtitleLabel.text = message
    commonInit()
  }
    
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    titleConstraints()
    subheaderConstraints()
  }
  
  private func titleConstraints() {
    addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
    ])
  }
  
  private func subheaderConstraints() {
    addSubview(subtitleLabel)
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
      subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      subtitleLabel.heightAnchor.constraint(equalToConstant: 25)
    ])
  }


}
