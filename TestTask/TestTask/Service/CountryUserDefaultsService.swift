//
//  CountryUserDefaultsService.swift
//  TestTask
//
//  Created by Ruslan Khanov on 12.04.2021.
//

import UIKit

class CountryUserDefaultsService: CountryStorageService {
    
    private let countriesKey = "countries"
    
    private var defaults = UserDefaults.standard
    
    private var countries: Countries {
        get {
            if let savedCountries = defaults.object(forKey: countriesKey) as? Data {
                let decoder = JSONDecoder()
                if let loadedCountries = try? decoder.decode(Countries.self, from: savedCountries) {
                    return loadedCountries
                } else {
                    return Countries(nextURLString: "", countries: [])
                }
            } else {
                return Countries(nextURLString: "", countries: [])
            }
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                defaults.set(encoded, forKey: countriesKey)
            }
        }
    }
    
    func save(newCountries: [Country]) {
        var savedCountries = countries
        savedCountries.countries.append(contentsOf: newCountries)
        countries = savedCountries
    }
    
    func fetch() -> [Country] {
        let fetchedCountries = countries.countries
        fetchedCountries.forEach { country in
            if let url = defaults.url(forKey: "\(country.flagImageURL)") {
                country.flagImageURL = url
            }
            
            var index = 0
            
            country.imageURLs.forEach { imageURL in
                if let url = defaults.url(forKey: "\(country.imageURLs[index])") {
                    country.imageURLs[index] = url
                }
                index += 1
            }
        }
        return countries.countries
    }
    
    func saveImage(_ image: UIImage, for country: Country, of type: CountryImageType) {
        if let data = image.pngData() {
            
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            var fileName = ""
            var key = ""
            
            switch type {
            case .flag:
                fileName = "\(country.name)_flag"
                key = "\(country.flagImageURL)"
            case .normal(index: let index):
                fileName = "\(country.name)_image\(index)"
                key = "\(country.imageURLs[index])"
            }
            let url = documents.appendingPathComponent("\(fileName).png")
            
            do {
                try data.write(to: url)
                UserDefaults.standard.set(url, forKey: key)
                
            } catch {
                print("Unable to Write Data to Disk (\(error))")
            }
        }
    }
}
