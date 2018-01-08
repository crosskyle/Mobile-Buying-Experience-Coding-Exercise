//
//  Country.swift
//  EbayExercise
//
//  Created by Kyle Cross on 1/4/18.
//  Copyright © 2018 Kyle Cross. All rights reserved.
//

import Foundation

/**
 Country properties and types that match JSON keys and values from API call response in `fetchCountries`.
 */
struct Country: Decodable {
    let name: String?
    let topLevelDomain: [String]?
    let alpha2Code: String?
    let alpha3Code: String?
    let callingCodes: [String]?
    let capital: String?
    let altSpellings: [String]?
    let region: String?
    let subregion: String?
    let population: Int?
    let latlng: [Double]?
    let demonym: String?
    let area: Double?
    let gini: Double?
    let timezones: [String]?
    let borders: [String]?
    let nativeName: String?
    let numericCode: String?
    let currencies: [String]?
    let languages: [String]?
    let translations: [String:String?]?
    let relevance: String?
}

extension Country {
    /**
     List of all countries and their corresponding data is fetched with GET request.
     Successful response executes completion handler with a list of countries optional parameter.
     Unsuccessful response executes a completion handler with a nil parameter.
    */
    static func fetchCountries(completion: @escaping ([Country]?) -> Void) {
        guard let url = URL(string: "https://restcountries-v1.p.mashape.com/all")
            else { completion(nil); return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("1IosQYQKu0mshuIZjcqiIXbiLGJSp1dBB9Yjsnfd2aISWLA7Yk", forHTTPHeaderField: "X-Mashape-Key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let countries = try JSONDecoder().decode([Country].self, from: data)
                    completion(countries)
                }
                catch let jsonError {
                    print(jsonError)
                    completion(nil)
                }
            } else {
                if let error = error {
                    print(error)
                }
                completion(nil)
            }
        }.resume()
    }
}
