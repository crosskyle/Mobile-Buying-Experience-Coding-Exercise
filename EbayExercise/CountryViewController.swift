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
    private let flagImage = UIImageView()
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    let contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        scrollView.addSubview(contentView)
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
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
        contentView.addSubview(mapView)
    }
    
    private func setupViews() {

        nameLabel.text = country.name ?? ""
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 0
        
        capitalLabel.text = country.capital ?? ""
        capitalLabel.translatesAutoresizingMaskIntoConstraints = false
        capitalLabel.numberOfLines = 0
        
        flagImage.image = UIImage(named: country.alpha2Code!.lowercased())!
        flagImage.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(nameLabel)
        
        contentView.addSubview(capitalLabel)
        contentView.addSubview(flagImage)
    }
    
    private func setupConstraints() {
        
        mapLayout()
        labelLayout()
    }
    
    private func labelLayout() {
        
        let contentGuide = contentView.readableContentGuide
        nameLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 0).isActive = true
        
        capitalLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor).isActive = true
        capitalLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor).isActive = true
        capitalLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8.0).isActive = true
        //capitalLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0).isActive = true
        
//        flagImage.widthAnchor.constraint(equalToConstant: 180).isActive = true
//        flagImage.heightAnchor.constraint(equalToConstant: 180).isActive = true
        flagImage.topAnchor.constraint(equalTo: capitalLabel.bottomAnchor, constant: 8.0).isActive = true
        flagImage.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor).isActive = true
//        flagImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0).isActive = true
    }
    
    private func mapLayout() {
        
        let margins = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            ])
        
        // in ios 11 only
        let guide = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0),
            ])
        
        let constraint = NSLayoutConstraint(item: mapView,
                                            attribute: NSLayoutAttribute.height,
                                            relatedBy: NSLayoutRelation.equal,
                                            toItem: view,
                                            attribute: NSLayoutAttribute.height,
                                            multiplier: 0.5,
                                            constant: 0)
        view.addConstraint(constraint)
    }
    
}
