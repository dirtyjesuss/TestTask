//
//  CountryViewModel.swift
//  TestTask
//
//  Created by Ruslan Khanov on 08.04.2021.
//

import Foundation

protocol CountryViewModelDelegate {
    func didLoadData()
    func didFailLoadData()
}

protocol CountryViewModel {
    var items: [Country] { get set }
    var delegate: CountryViewModelDelegate? { get set }
    
    func getCountries()
}

class CountryViewModelImplementation: CountryViewModel {
    
    var delegate: CountryViewModelDelegate?
    var items: [Country] = []
    
    private var countryService: CountryService!
        
    init() {
        #warning("Set country service in factory not in init")
        countryService = CountryAPIService()
    }
    
    func getCountries() {
        countryService.loadCountries(page: nil) { [self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                delegate?.didFailLoadData()
            case .success(let countries):
                items = countries.countries
                delegate?.didLoadData()
            }
        }
    }
}
