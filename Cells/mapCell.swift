//
//  mapCell.swift
//  FourSquare-GroupProject
//
//  Created by Pursuit on 2/27/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class mapCell: UICollectionViewCell {

      public lazy var venueImage : UIImageView = {
        let iv = UIImageView()
    //    iv.backgroundColor = .white
     //   iv.contentMode = .scaleAspectFill
        iv.sizeToFit()
        return iv
      }()
    
    public lazy var venueNameLabel: UILabel = {
         let label = UILabel()
         label.backgroundColor = .systemBackground
         label.text = "Venue Name"
         label.numberOfLines = 1
         label.textAlignment = .center
         label.font = UIFont.preferredFont(forTextStyle: .headline)
         
         return label
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
        configureImage()
       // configreLabel()
        
        
    }
    
    private func configureImage(){
        addSubview(venueImage)
        
        venueImage.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                venueImage.centerYAnchor.constraint(equalTo: centerYAnchor),
                venueImage.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        
    }
    
    private func configreLabel(){
        addSubview(venueNameLabel)
        venueNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
        ])
    }

    
    public func configureCell(for venue: Venue) {
        venueNameLabel.text = venue.name
        
           PhotoAPIClient.photoURL(venue: venue) { [weak self] (result) in
               switch result {
               case .failure:
                   DispatchQueue.main.async {
                       self?.venueImage.image = UIImage(named: "exclamationmark - octagon")
                   }
               case .success(let image):
                
                       self?.venueImage.getImage(with: image, completion: { (result) in
                           switch result {
                           case .failure:
                               print("fail")
                           case .success(let image):
                               DispatchQueue.main.async {
                                   self?.venueImage.image = image
                               }
                           }
                       })
                   
               }
           }
           
       }
}
