//
//  CountryUserDefaultsService.swift
//  TestTask
//
//  Created by Ruslan Khanov on 12.04.2021.
//

import UIKit

protocol CountryStorageService {
    func save(newCountries: [Country])
    func fetch() -> [Country]
    
    func saveImage(_ image: UIImage, for country: Country, of type: CountryImageType)
}
