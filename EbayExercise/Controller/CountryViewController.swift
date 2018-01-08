//
//  CountryViewController.swift
//  EbayExercise
//
//  Created by Kyle Cross on 1/4/18.
//  Copyright © 2018 Kyle Cross. All rights reserved.
//

import UIKit
import MapKit

/**
 View controller that displays a detailed view of a country including a map view,
 image of a flag, and information about that country.
 */
class CountryViewController: UIViewController {
    var country: Country?
    
    // MARK: - Initialize views and set view properties
    
    // All views have translatesAutoresizingMaskIntoConstraints set to false to allow for auto layout.
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Image border is created to differentiate white flags from a white background.
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    // Number of lines are set to 0 so that labels can expand.
    // Font is set to preferred font and adjusted for content size to give
    // users the ability to make font size accessible.
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let alternativeNamesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let capitalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let populationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let regionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let subregionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        setupFlagImageView()
        setupLabelViews()
        addSubviews()
        setupLayout()
    }

    // MARK: - Setup view content
    
    /**
     `mapView` is set to show the selected region with an annotation that shows the country name.
     */
    private func setupMapView() {
        guard let latlng = country?.latlng else {return}
        guard let latitude = latlng.first, let longitude = latlng.last else {return}
        
        // Map region is set to a radius that corresponds to the postion and general size of the country.
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let area = country?.area ?? 1000000
        let radius = sqrt(area * 1000000)
        let regionRadius: CLLocationDistance = CLLocationDistance(radius)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)

        // Annotation is added to show country name.
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = country?.name ?? ""
        mapView.addAnnotation(annotation)
    }
    
    
    /**
     `flagImageView` is set to country flag.
    */
    private func setupFlagImageView() {
        // Country code String must be set to lowercase to correspond with image assets.
        if let countryCode = country?.alpha2Code,
            let image = UIImage(named: countryCode.lowercased()) {
            flagImageView.image = image
        }
    }
    
    /**
     Label text is set with country descriptions.
    */
    private func setupLabelViews() {
        // Population label text is formatted to a string with commas.
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        if let population = country?.population,
            let formattedPopulation = numberFormatter.string(from: NSNumber(value:population)) {
            populationLabel.text = ("Population: \(formattedPopulation)")
        } else {
            populationLabel.text = ("Population:")
        }

        // Alternative names list is joined with comma separator.
        if let alternativeNames = country?.altSpellings {
            let alternativeNamesText = alternativeNames.joined(separator: ", ")
            alternativeNamesLabel.text = ("Alternative Names: \(alternativeNamesText)")
        } else {
            alternativeNamesLabel.text = ("Alternative Names:")
        }
        
        // Labels are assigned empty string when values are nil.
        nameLabel.text = ("Country: \(country?.name ?? "")")
        capitalLabel.text = ("Capital: \(country?.capital ?? "")")
        regionLabel.text = ("Region: \(country?.region ?? "")")
        subregionLabel.text = ("Subregion: \(country?.subregion ?? "")")
    }
    
    // MARK: - Setup view layout
    
    /**
     Subviews are added. `contentView` is placed on top of `scrollView` to prevent
     horizontal scrolling. All views with content are added to `contentView`.
    */
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mapView)
        contentView.addSubview(flagImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(alternativeNamesLabel)
        contentView.addSubview(capitalLabel)
        contentView.addSubview(populationLabel)
        contentView.addSubview(regionLabel)
        contentView.addSubview(subregionLabel)
    }
    
    /**
     Contraints are added for each of the subviews.
    */
    private func setupLayout() {
        let marginGuide = contentView.layoutMarginsGuide
        let contentGuide = contentView.readableContentGuide
        
        // `scrollView` is pinned to all `view` edges to make whole view scrollable.
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        // `contentView` top and bottom anchors are pinned to `scrollView` to limit scrolling to vertically only.
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        
        // `mapView` height anchor is constrained to half the height of `view` to allow space for other views.
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            mapView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0)
            ])
        
        // `flagImageView` is only pinned to the leading anchor so that the image ratio is correct.
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
            alternativeNamesLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            alternativeNamesLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
            alternativeNamesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8.0)
            ])
        
        NSLayoutConstraint.activate([
            capitalLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            capitalLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
            capitalLabel.topAnchor.constraint(equalTo: alternativeNamesLabel.bottomAnchor, constant: 8.0),
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
        
        // Last view must be constrained to `contentView` bottom to allow for scrolling.
        NSLayoutConstraint.activate([
            subregionLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            subregionLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
            subregionLabel.topAnchor.constraint(equalTo: regionLabel.bottomAnchor, constant: 8.0),
            subregionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0)
            ])
    }
}
