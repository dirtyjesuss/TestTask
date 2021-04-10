//
//  DetailCountryViewModel.swift
//  TestTask
//
//  Created by Ruslan Khanov on 10.04.2021.
//

import UIKit

protocol DetailCountryViewModel {
    var name: String { get }
    var continent: String { get }
    var capital: String { get }
    var population: Int { get }
    var countryDescription: String { get }
    var images: [UIImage?] { get }
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
    
    #warning("Mock data")
    var images: [UIImage?] {[
        UIImage(named: "i-photo"),
        UIImage(named: "i-photo"),
        UIImage(named: "i-photo")
        ]
    }
    
    private var country: Country
    
    init(data: Country) {
        country = data
    }
}
