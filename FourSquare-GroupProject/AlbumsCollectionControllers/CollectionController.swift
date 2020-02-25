//
//  CollectionControllers.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
import ImageKit

class CollectionController: UIViewController {
  
  private var testView2 = TestScreenTwo()
  
  override func loadView() {
    view = testView2
  }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
      loadPhoto()
    }
  
  func loadPhoto() {
    PhotoAPIClient.photoURL(venueID: "") { (result) in
      switch result {
      case .failure(let error):
        print("\(error)")
      case .success(let url):
//        guard url = url {
        print(url)
        DispatchQueue.main.async {
          self.testView2.imageView.getImage(with: url) { [weak self] (finish) in
            switch finish {
            case .failure(let appError):
              self?.testView2.imageView.image = UIImage(systemName: "ellipsis")
              print("\(appError)")
            case .success(let image):
              self?.testView2.imageView.image = image
            }
          }
        }
//        }
    }
  }
    
}
}
