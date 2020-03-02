//
//  RestaurantsDetailView.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
import MapKit
import DataPersistence

class RestaurantsDetailView: UIView {
    
    public lazy var venueImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo.fill")
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 20
        
        image.layer.masksToBounds = true
       // image.clipsToBounds = true
        return image
        
    }()
    
    public lazy var venueNameLabel: UILabel = {
        let label = UILabel()
        label.text = "venue name"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.backgroundColor = .white
        return label
    }()
    
    public lazy var venueAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "venue address"
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.backgroundColor = .white
        return label
    }()
    
    public lazy var deliveryButton: UIButton = {
        let button = UIButton()
//        button.titleLabel?.text = "Delivery"
//        button.titleLabel?.textColor = .black
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemRed
        button.setTitleColor(.black, for: .normal)
       button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitle("Deliver Me", for: .normal)
        return button
    }()
    
    public lazy var map: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame:UIScreen.main.bounds)
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commomInit()
    }
    
    private func commomInit() {
        setupVenueImageConstraints()
        setupMapConstraints()
        setupNameLabelConstraints()
        setupAddressLabelConstraints()
        setupButtonConstraints()
        
    }
    
   private func setupVenueImageConstraints() {
        addSubview(venueImage)
    venueImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        venueImage.topAnchor.constraint(equalTo: topAnchor, constant: 90),
        venueImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
        venueImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
        venueImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier:  0.35)
    ])
    }
    
    private func setupMapConstraints() {
        addSubview(map)
        map.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            map.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            map.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            map.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            map.heightAnchor.constraint(equalTo: heightAnchor, multiplier:  0.40)
        ])
    }
    
    private func setupNameLabelConstraints() {
        addSubview(venueNameLabel)
        venueNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            venueNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            venueNameLabel.topAnchor.constraint(equalTo: venueImage.bottomAnchor, constant: 5),
            venueNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    private func setupAddressLabelConstraints() {
        addSubview(venueAddressLabel)
        
        venueAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        venueAddressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        venueAddressLabel.topAnchor.constraint(equalTo: venueNameLabel.bottomAnchor, constant: 15),
        venueAddressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func setupButtonConstraints() {
        addSubview(deliveryButton)
        deliveryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deliveryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            deliveryButton.topAnchor.constraint(equalTo: venueAddressLabel.bottomAnchor, constant: 5)
        ])
    }
}
