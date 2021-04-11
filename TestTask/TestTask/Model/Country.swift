//
//  Country.swift
//  TestTask
//
//  Created by Ruslan Khanov on 08.04.2021.
//

import UIKit

struct Country: Decodable {
    var name, continent, capital: String
    var population: Int
    var shortDescription, countryDescription: String
    var images: [URL]
    var flagImageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case name, continent, capital, population
        case shortDescription = "description_small"
        case countryDescription = "description"
        case imageURL = "image"
        case countryInfo = "country_info"
    }
    
    enum CountryInfoCodingKeys: String, CodingKey {
        case imageURLs = "images"
        case flagImageURL = "flag"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        continent = try container.decode(String.self, forKey: .continent)
        capital = try container.decode(String.self, forKey: .capital)
        population = try container.decode(Int.self, forKey: .population)
        shortDescription = try container.decode(String.self, forKey: .shortDescription)
        countryDescription = try container.decode(String.self, forKey: .countryDescription)
        
        let countryInfo = try container.nestedContainer(keyedBy: CountryInfoCodingKeys.self, forKey: .countryInfo)
                
        flagImageURL = try countryInfo.decode(URL.self, forKey: .flagImageURL)

        if let imageURL = try? container.decode(URL.self, forKey: .imageURL) {
            self.images = [imageURL]
        } else {
            self.images = try countryInfo.decode([URL].self, forKey: .imageURLs)
        }
    }
}
