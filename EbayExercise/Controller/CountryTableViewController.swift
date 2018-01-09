//
//  CountryTableViewController.swift
//  EbayExercise
//
//  Created by Kyle Cross on 1/4/18.
//  Copyright © 2018 Kyle Cross. All rights reserved.
//

import UIKit

/**
 View controller that displays a list of countries and segues to a country detailed view
 when a user taps on a country.
 */
class CountryTableViewController: UITableViewController {
    var countries: [Country] = []
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCountries()
    }
    
    // MARK: - Update UI
    
    /**
     List of countries is fetched and loaded in `tableView` on the main thread.
    */
    private func fetchCountries() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        Country.fetchCountries(completion: { countries in
            DispatchQueue.main.async {
                if let countries = countries {
                    self.countries = countries
                    self.tableView.reloadData()
                }
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
        // Country data is passed to the detail view.
        if segue.identifier == "showCountry" {
            if let countryViewController = segue.destination as? CountryViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                let selectedCountry = countries[indexPath.row]
                countryViewController.country = selectedCountry
            }
        }
    }
}
