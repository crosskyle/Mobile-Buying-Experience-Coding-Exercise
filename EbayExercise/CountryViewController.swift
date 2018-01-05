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
        

    }
    
    override func viewWillLayoutSubviews() {
        addMapView()
        addLabels()
    }
    
    func addMapView() {
        let leftMargin:CGFloat = 10
        let topMargin:CGFloat = UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height)! + 10
        let mapWidth:CGFloat = view.frame.size.width-20
        let mapHeight:CGFloat = 300
        
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        
        // set initial location
        let location = CLLocationCoordinate2D(latitude: country.latlng![0], longitude: country.latlng![1])
        let regionRadius: CLLocationDistance = CLLocationDistance(sqrt(Double(country.area!*1000000)))
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location,regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = country.name!
        mapView.addAnnotation(annotation)
        
        view.addSubview(mapView)
    }
    
    func addLabels() {
        
    }
    
    
}
