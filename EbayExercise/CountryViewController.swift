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

    }
    
    private func setupConstraints() {
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
            ])
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                mapView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0),
                guide.bottomAnchor.constraintEqualToSystemSpacingBelow(mapView.bottomAnchor, multiplier: 1.0)
                ])
        }
        else {
            let standardSpacing: CGFloat = 8.0
            NSLayoutConstraint.activate([
                mapView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: standardSpacing),
                bottomLayoutGuide.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: standardSpacing)
                ])
        }
        
    }
    
}
