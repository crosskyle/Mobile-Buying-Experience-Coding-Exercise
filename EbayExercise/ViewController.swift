//
//  ViewController.swift
//  EbayExercise
//
//  Created by Kyle Cross on 1/4/18.
//  Copyright © 2018 Kyle Cross. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var countries: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Country.fetchCountriesInfo(completion: { (fetchedInfo) in
            if let info = fetchedInfo {
                print(info)
            }
        })
    }
    
}

