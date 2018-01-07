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
    
    private let mapView: MKMapView = {
        let v = MKMapView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let flagImageView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.borderColor = UIColor.black.cgColor
        v.layer.borderWidth = 1
        return v
    }()
    
    private let nameLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        v.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        v.adjustsFontForContentSizeCategory = true
        return v
    }()
    
    private let capitalLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        v.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        v.adjustsFontForContentSizeCategory = true
        return v
    }()
    
    private let populationLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        v.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        v.adjustsFontForContentSizeCategory = true
        return v
    }()
    
    private let regionLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        v.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        v.adjustsFontForContentSizeCategory = true
        return v
    }()
    
    private let subregionLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        v.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        v.adjustsFontForContentSizeCategory = true
        return v
    }()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupMapView()
        setupViews()
        addViews()
        setupLayout()
    }

    
    private func setupMapView() {
        
        guard let latlng = country.latlng else {return}
        guard let area = country.area else {return}
        
        let location = CLLocationCoordinate2D(latitude: latlng[0], longitude: latlng[1])
        let regionRadius: CLLocationDistance = CLLocationDistance(sqrt(area*1000000))
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = country.name!
        mapView.addAnnotation(annotation)
    }
    
    
    private func setupViews() {

        if let countryCode = country.alpha2Code,
            let image = UIImage(named: countryCode.lowercased()) {
            flagImageView.image = image
        }

        nameLabel.text = ("Country: \(country.name ?? "")")
        capitalLabel.text = ("Capital: \(country.capital ?? "")")
        
        
        if let populationInt = country.population {
            populationLabel.text = ("Population: \(String(describing: populationInt))")
        }
        else {
            populationLabel.text = ("Population:")
        }
        
        regionLabel.text = ("Region: \(country.region ?? "")")
        subregionLabel.text = ("Subregion: \(country.subregion ?? "")")
    }
    
    
    private func addViews() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mapView)
        contentView.addSubview(flagImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(capitalLabel)
        contentView.addSubview(populationLabel)
        contentView.addSubview(regionLabel)
        contentView.addSubview(subregionLabel)
    }
    
    
    private func setupLayout() {
        
        let margins = contentView.layoutMarginsGuide
        let contentGuide = contentView.readableContentGuide
        
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            mapView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0)
            ])
        
        NSLayoutConstraint.activate([
            flagImageView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 8.0),
            flagImageView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: 8.0)
            ])
        
        NSLayoutConstraint.activate([
            capitalLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            capitalLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
            capitalLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8.0),
            ])
        
        NSLayoutConstraint.activate([
            populationLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            populationLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
            populationLabel.topAnchor.constraint(equalTo: capitalLabel.bottomAnchor, constant: 8.0),
            ])
        
        NSLayoutConstraint.activate([
            regionLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            regionLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
            regionLabel.topAnchor.constraint(equalTo: populationLabel.bottomAnchor, constant: 8.0),
            ])
        
        NSLayoutConstraint.activate([
            subregionLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            subregionLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
            subregionLabel.topAnchor.constraint(equalTo: regionLabel.bottomAnchor, constant: 8.0),
            subregionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0)
            ])
    }
    
}
