//
//  CollectionView.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import Foundation
import UIKit

class TestScreenTwo: UIView {
  public lazy var imageView : UIImageView = {
    let iv = UIImageView()
    iv.backgroundColor = .systemIndigo
    return iv
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
    imageViewSetup()
  }

  private func imageViewSetup() {
    addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
      imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      imageView.heightAnchor.constraint(equalToConstant: 300),
      imageView.widthAnchor.constraint(equalToConstant: 300)
    ])
  }

}
