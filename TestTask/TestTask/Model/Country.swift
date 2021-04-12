//
//  Country.swift
//  TestTask
//
//  Created by Ruslan Khanov on 08.04.2021.
//

import UIKit

class Country: Decodable {
    var name, continent, capital: String
    var population: Int
    var shortDescription, countryDescription: String
    var imageURLs: [URL]
    var flagImageURL: URL
    
    var images: [UIImage]
    var flagImage: UIImage
    
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
    
    required init(from decoder: Decoder) throws {
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
            self.imageURLs = [imageURL]
        } else {
            self.imageURLs = try countryInfo.decode([URL].self, forKey: .imageURLs)
        }
        
        images = []
        flagImage = UIImage()
    }

}

extension Country: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(continent, forKey: .continent)
        try container.encode(capital, forKey: .capital)
        try container.encode(population, forKey: .population)
        try container.encode(shortDescription, forKey: .shortDescription)
        try container.encode(countryDescription, forKey: .countryDescription)
        try container.encode("", forKey: .imageURL)
        
        var countryInfo = container.nestedContainer(keyedBy: CountryInfoCodingKeys.self, forKey: .countryInfo)
        try countryInfo.encode(imageURLs, forKey: .imageURLs)
        try countryInfo.encode(flagImageURL, forKey: .flagImageURL)
    }
}
