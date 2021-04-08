//
//  Country.swift
//  TestTask
//
//  Created by Ruslan Khanov on 08.04.2021.
//

import Foundation

struct Country: Codable {
    var name, continent, capital: String
    var population: Int
    var shortDescription, countryDescription: String
    var imageURLString: String
    var countryInfo: CountryInfo

    enum CodingKeys: String, CodingKey {
        case name, continent, capital, population
        case shortDescription = "description_small"
        case countryDescription = "description"
        case imageURLString = "image"
        case countryInfo = "country_info"
    }
}

struct CountryInfo: Codable {
    var images: [URL?]
    var flagImageURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case images
        case flagImageURL = "flag"
    }
}
