//
//  CountryViewController.swift
//  EbayExercise
//
//  Created by Kyle Cross on 1/4/18.
//  Copyright © 2018 Kyle Cross. All rights reserved.
//

import UIKit
import MapKit

class CountryViewController: UIViewController {
    
    var country: Country!
    private let mapView = MKMapView()
    private let nameLabel = UILabel()
    private let capitalLabel = UILabel()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addMapView()
        setupViews()
        setupConstraints()
    }

    func addMapView() {

        let location = CLLocationCoordinate2D(latitude: country.latlng![0], longitude: country.latlng![1])
        let regionRadius: CLLocationDistance = CLLocationDistance(sqrt(Double(country.area!*1000000)))
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location,regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = country.name!
        mapView.addAnnotation(annotation)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
    }
    
    private func setupViews() {

        if let name = country.name {
            nameLabel.text = name
        }
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 0
        
        if let capital = country.capital {
            capitalLabel.text = capital
        }
        capitalLabel.translatesAutoresizingMaskIntoConstraints = false
        capitalLabel.numberOfLines = 0
        
        view.addSubview(nameLabel)
        view.addSubview(capitalLabel)
    }
    
    private func setupConstraints() {
        
        mapLayout()
        labelLayout()
    }
    
    private func labelLayout() {
        
        let contentGuide = view.readableContentGuide
        nameLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 8.0).isActive = true
        
        capitalLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor).isActive = true
        capitalLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor).isActive = true
        capitalLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8.0).isActive = true
    }
    
    private func mapLayout() {
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            ])
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                mapView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0),
                ])
            
        }
        else {
            //for not available in below 11.0
        }
        
        let constraint = NSLayoutConstraint(item: mapView,
                                            attribute: NSLayoutAttribute.height,
                                            relatedBy: NSLayoutRelation.equal,
                                            toItem: self.view,
                                            attribute: NSLayoutAttribute.height,
                                            multiplier: 0.5,
                                            constant: 0)
        
        self.view.addConstraint(constraint)
    }
    
}
