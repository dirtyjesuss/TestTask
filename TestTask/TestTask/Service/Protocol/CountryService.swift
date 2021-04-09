//
//  CountryService.swift
//  TestTask
//
//  Created by Ruslan Khanov on 08.04.2021.
//

import Foundation

enum CountryServiceError: Error {
    case errorGettingURLFromString
    case errorGettingValueFromResponse
}

protocol CountryService {
    func loadCountries(pageURLString: String?, completion: @escaping(Result<Countries, CountryServiceError>) -> Void)
}
