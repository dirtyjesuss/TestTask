//
//  CountryService.swift
//  TestTask
//
//  Created by Ruslan Khanov on 08.04.2021.
//

import Foundation

enum CountryServiceError: Error {
    
}

protocol CountryService {
    func loadCountries(page: URL?, completion: @escaping(Result<Countries, CountryServiceError>) -> Void)
}
