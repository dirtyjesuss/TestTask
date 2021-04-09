//
//  CountryViewModel.swift
//  TestTask
//
//  Created by Ruslan Khanov on 08.04.2021.
//

import Foundation

protocol CountryViewModelDelegate {
    func didLoadData()
}

protocol CountryViewModel {
    var items: [Country] { get set }
    var delegate: CountryViewModelDelegate? { get set }
    
    func fetchCountries()
}

class CountryViewModelImplementation: CountryViewModel {
    
    var delegate: CountryViewModelDelegate?
    var items: [Country] = []
    
    private var nextPage: String?
    
    private var countryService: CountryService!
    private var isFetchingInProgress = false
        
    init() {
        #warning("Set country service in factory not in init")
        countryService = CountryAPIService()
    }
    
    func fetchCountries() {
        guard !isFetchingInProgress else {
            return
        }
        
        if let nextPage = nextPage, nextPage.isEmpty {
            return
        }
        
        isFetchingInProgress = true
        
        countryService.loadCountries(pageURLString: nextPage) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.isFetchingInProgress = false
                    print(error.localizedDescription)
                }
            case .success(let response):
                DispatchQueue.main.async {
                    self?.isFetchingInProgress = false
                    
                    self?.items.append(contentsOf: response.countries)
                    self?.delegate?.didLoadData()

                    self?.nextPage = response.nextURLString
                }
            }
        }
    }
}
