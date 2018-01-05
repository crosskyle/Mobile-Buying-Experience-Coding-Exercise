//
//  Country.swift
//  EbayExercise
//
//  Created by Kyle Cross on 1/4/18.
//  Copyright © 2018 Kyle Cross. All rights reserved.
//

import Foundation

struct Country {
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
    let area: Int?
    let gini: Float?
    let timezones: [String]?
    let borders: [String]?
    let nativeName: String?
    let numericCode: String?
    let currencies: [String]?
    let languages: [String]?
    let translations: [String:String]?
    let relevance: String?
    
    struct PropertyKey {
        static let name = "name"
        static let topLevelDomain = "topLevelDomain"
        static let alpha2Code = "alpha2Code"
        static let alpha3Code = "alpha3Code"
        static let callingCodes = "callingCodes"
        static let capital = "capital"
        static let altSpellings = "altSpellings"
        static let region = "region"
        static let subregion = "subregion"
        static let population = "population"
        static let latlng = "latlng"
        static let demonym = "demonym"
        static let area = "area"
        static let gini = "gini"
        static let timezones = "timezones"
        static let borders = "borders"
        static let nativeName = "nativeName"
        static let numericCode = "numericCode"
        static let currencies = "currencies"
        static let languages = "languages"
        static let translations = "translations"
        static let relevance = "relevance"
    }
}

extension Country {
    init?(json: [String: Any]) {
        self.name = json[PropertyKey.name] as? String
        self.topLevelDomain = json[PropertyKey.topLevelDomain] as? [String]
        self.alpha2Code = json[PropertyKey.alpha2Code] as? String
        self.alpha3Code = json[PropertyKey.alpha3Code] as? String
        self.callingCodes = json[PropertyKey.callingCodes] as? [String]
        self.capital = json[PropertyKey.capital] as? String
        self.altSpellings = json[PropertyKey.altSpellings] as? [String]
        self.region = json[PropertyKey.region] as? String
        self.subregion = json[PropertyKey.subregion] as? String
        self.population = json[PropertyKey.population] as? Int
        self.latlng = json[PropertyKey.latlng] as? [Double]
        self.demonym = json[PropertyKey.demonym] as? String
        self.area = json[PropertyKey.area] as? Int
        self.gini = json[PropertyKey.gini] as? Float
        self.timezones = json[PropertyKey.timezones] as? [String]
        self.borders = json[PropertyKey.borders] as? [String]
        self.nativeName = json[PropertyKey.nativeName] as? String
        self.numericCode = json[PropertyKey.numericCode] as? String
        self.currencies = json[PropertyKey.currencies] as? [String]
        self.languages = json[PropertyKey.languages] as? [String]
        self.translations = json[PropertyKey.translations] as? [String:String]
        self.relevance = json[PropertyKey.relevance] as? String
    }
}

extension Country {
    static func fetchCountriesInfo(completion: @escaping ([Country]?) -> Void) {
        let url = URL(string: "https://restcountries-v1.p.mashape.com/all")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("1IosQYQKu0mshuIZjcqiIXbiLGJSp1dBB9Yjsnfd2aISWLA7Yk", forHTTPHeaderField: "X-Mashape-Key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            var countries: [Country] = []
            
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data),
                let j = json as? [[String: Any]] {
                for case let result in j {
                    if let country = Country(json: result) {
                        countries.append(country)
                    }
                }
                completion(countries)
            }
            else {
                completion(nil)
            }
        }
        task.resume()
    }
}
