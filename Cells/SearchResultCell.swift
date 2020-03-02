//
//  SearchResultCell.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/26/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
//import Kingfisher
import ImageKit

class SearchResultsCell: UICollectionViewCell {
    
    private var currentVenue: Venue!
    
    public lazy var venueImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.backgroundColor = .systemBackground
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 20
        return image
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
    
    public lazy var venueCategoryLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "Venue Ctegory"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
         
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
        setUpImageViewConstraints()
        setupCatregoryLabelConstraints()
        setupNameLabelConstraints()
        

    }
    
    private func setUpImageViewConstraints() {
        addSubview(venueImage)
       venueImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            venueImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            venueImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            venueImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            venueImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35)
        ])
    }
    
    
    
    private func setupCatregoryLabelConstraints() {
        addSubview(venueCategoryLabel)
        venueCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            venueCategoryLabel.leadingAnchor.constraint(equalTo: venueImage.trailingAnchor, constant: 10),
            venueCategoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            venueCategoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func setupNameLabelConstraints() {
        addSubview(venueNameLabel)
        venueNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            venueNameLabel.leadingAnchor.constraint(equalTo: venueImage.trailingAnchor, constant: 10),
            venueNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            venueNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    public func configureCell(for venue: Venue) {
        currentVenue = venue
        venueNameLabel.text = venue.name
        venueCategoryLabel.text = venue.categories[0]?.shortName
     
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

