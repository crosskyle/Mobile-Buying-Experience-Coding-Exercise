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
    var sortedCountries: [[Country]] = [[]]
    var firstLettersOfCountries: [String] =  []
    
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
                    self.firstLettersOfCountries = self.getFirstLetters(of: countries)
                    self.sortedCountries = self.assignCountriesToLetters(countries)
                    self.tableView.reloadData()
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        })
    }
    
    /**
     First letters in country names are sorted into a list of unique strings.
    */
    private func getFirstLetters(of countries: [Country]) -> [String] {
        var letters: Set<String> = []
        var uniqueLetters: [String] = []
        
        for country in countries {
            if let firstLetter = country.firstLetterOfName, !letters.contains(firstLetter) {
                letters.insert(firstLetter)
            }
        }
        
        for letter in letters {
            uniqueLetters.append(letter)
        }
        
        return uniqueLetters.sorted()
    }
    
    /**
     Countries are assigned to the first letter in their name.
    */
    private func assignCountriesToLetters(_ countries: [Country]) -> [[Country]] {
        return self.firstLettersOfCountries.map { firstLetter in
            return countries.filter { country in
                guard let name = country.name else { return false }
                
                return String(name[name.startIndex]) == firstLetter
            }
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return firstLettersOfCountries[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return firstLettersOfCountries
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return firstLettersOfCountries.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedCountries[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        
        let country = sortedCountries[indexPath.section][indexPath.row]
        
        // Text in each cell is set to each country name.
        if let name = country.name {
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
                let selectedCountry = sortedCountries[indexPath.section][indexPath.row]
                countryViewController.country = selectedCountry
            }
        }
    }
}
