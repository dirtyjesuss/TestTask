//
//  DetailCountryViewModel.swift
//  TestTask
//
//  Created by Ruslan Khanov on 10.04.2021.
//

import Foundation

protocol DetailCountryViewModel {
    var name: String { get }
    var continent: String { get }
    var capital: String { get }
    var population: Int { get }
    var countryDescription: String { get }
    var images: [URL?] { get }
}

class DetailCountryViewModelImplementation: DetailCountryViewModel {

    var name: String {
        country.name
    }
    var continent: String {
        country.continent
    }
    var capital: String {
        country.capital
    }
    var population: Int {
        country.population
    }
    var countryDescription: String {
        country.countryDescription
    }
    var images: [URL?] {
        if country.imageURLString.isEmpty {
            return country.countryInfo.images
        } else if country.countryInfo.images.isEmpty {
            return [country.countryInfo.flagImageURL]
        } else {
            return [URL(string: country.imageURLString)]
        }
    }
    
    private var country: Country
    
    init(data: Country) {
        country = data
    }
}
