//
//  CountryTableViewController.swift
//  EbayExercise
//
//  Created by Kyle Cross on 1/4/18.
//  Copyright © 2018 Kyle Cross. All rights reserved.
//

import UIKit

class CountryTableViewController: UITableViewController {
    
    var countries: [Country] = []

    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Country.fetchCountriesInfo(completion: { countries in
            if let countries = countries {
                self.countries = countries
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)

        // Configure the cell...
        if let name = countries[indexPath.row].name {
            cell.textLabel?.text = name
        }
        
        return cell
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showCountry" {
            let countryViewController = segue.destination as! CountryViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedCountry = countries[indexPath.row]
            countryViewController.country = selectedCountry
        }
    }

}
