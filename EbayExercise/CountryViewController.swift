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
    
    // MARK: - Set view properties
    
    // All views have translatesAutoresizingMaskIntoConstraints set to false
    // to all allow for auto layout.
    
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
    
    // An image border is created to differentiate white flags from a
    // white background.
    
    private let flagImageView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.borderColor = UIColor.black.cgColor
        v.layer.borderWidth = 1
        return v
    }()
    
    // Number of lines are set to 0 so that labels can expand.
    // Font is set to preferred font and adjusted for content size to give
    // users the ability to make font size accessible.
    
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
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        setupImageView()
        setupLabelViews()
        addViews()
        setupLayout()
    }

    // MARK: - Setup view content
    
    private func setupMapView() {
        guard let latlng = country.latlng else {return}
        guard let area = country.area else {return}
        
        // A map region is set to a radius that corresponds to the postion and general size of the country.
        let location = CLLocationCoordinate2D(latitude: latlng[0], longitude: latlng[1])
        let radius = sqrt(area * 1000000)
        let regionRadius: CLLocationDistance = CLLocationDistance(radius)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)

        // A map annotation is added to show selected country's name.
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = country.name ?? ""
        mapView.addAnnotation(annotation)
    }
    
    private func setupImageView() {
        // The country code string must be set to lowercase to correspond with image assets.
        if let countryCode = country.alpha2Code,
            let image = UIImage(named: countryCode.lowercased()) {
            flagImageView.image = image
        }
    }
    
    private func setupLabelViews() {
        // Population value must be cast to String from a Double type
        if let population = country.population {
            populationLabel.text = ("Population: \(String(describing: population))")
        } else {
            populationLabel.text = ("Population:")
        }

        // Labels are assigned empty string when values are nil
        nameLabel.text = ("Country: \(country.name ?? "")")
        capitalLabel.text = ("Capital: \(country.capital ?? "")")
        regionLabel.text = ("Region: \(country.region ?? "")")
        subregionLabel.text = ("Subregion: \(country.subregion ?? "")")
    }
    
    // MARK: - Setup view layout
    
    // Subviews are added. A content view is placed on top of a scroll view in order
    // to prevent horizontal scrolling. All views with content are added to the content
    // view.
    
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
    
    // Contraints are added for each of the subviews.
    
    private func setupLayout() {
        let marginGuide = contentView.layoutMarginsGuide
        let contentGuide = contentView.readableContentGuide
        
        // The scroll view is pinned to all view edges so that the whole view is scrollable
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        // The content view's top and bottom anchors are pinned to the scroll
        // view to allow for only vertical scrolling.
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        
        // The map view's height anchor is constrained to half the height of the view
        // to allow for space for other views.
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            mapView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0)
            ])
        
        // The flag image view is only pinned to the leading anchor so that the image ratio is correct.
        NSLayoutConstraint.activate([
            flagImageView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 8.0),
            flagImageView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
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
        
        // The final view must be constrained to the content view's bottom to allow for scrolling.
        NSLayoutConstraint.activate([
            subregionLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            subregionLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
            subregionLabel.topAnchor.constraint(equalTo: regionLabel.bottomAnchor, constant: 8.0),
            subregionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0)
            ])
    }
}
