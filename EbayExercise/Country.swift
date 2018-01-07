//
//  Country.swift
//  EbayExercise
//
//  Created by Kyle Cross on 1/4/18.
//  Copyright © 2018 Kyle Cross. All rights reserved.
//

import Foundation

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
    static func fetchCountriesInfo(completion: @escaping ([Country]?) -> Void) {
        guard let url = URL(string: "https://restcountries-v1.p.mashape.com/all")
            else { completion(nil); return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("1IosQYQKu0mshuIZjcqiIXbiLGJSp1dBB9Yjsnfd2aISWLA7Yk", forHTTPHeaderField: "X-Mashape-Key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(nil); return }
            
            do {
                let countries = try JSONDecoder().decode([Country].self, from: data)
                completion(countries)
            }
            catch let jsonError {
                print(jsonError)
                completion(nil)
            }
        }.resume()
    }
}
