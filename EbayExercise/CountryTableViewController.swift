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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCountryData()
    }
    
    private func getCountryData() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // A list of countries are fetched and loaded in a table view in the main thread
        Country.fetchCountriesInfo(completion: { countries in
            if let countries = countries {
                self.countries = countries
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)

        // Text in each cell is set to each country name.
        if let name = countries[indexPath.row].name {
            cell.textLabel?.text = name
        }
        
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // A country's data is passed to the detail view
        if segue.identifier == "showCountry" {
            let countryViewController = segue.destination as! CountryViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedCountry = countries[indexPath.row]
            countryViewController.country = selectedCountry
        }
    }
}
