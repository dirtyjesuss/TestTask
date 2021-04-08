//
//  CountryAPIService.swift
//  TestTask
//
//  Created by Ruslan Khanov on 08.04.2021.
//

import Foundation
import Alamofire

class CountryAPIService: CountryService {
    
    let baseURL: URL? = {
        return URL(string: "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json")
    }()
    
    func loadCountries(page: URL?, completion: @escaping (Result<Countries, CountryServiceError>) -> Void) {
        var url: URL
        
        if let pageURL = page {
            url = pageURL
        } else {
            guard let baseURL = baseURL else { return }
            url = baseURL
        }
        
        let request = AF.request(url)
            
        request.responseDecodable(of: Countries.self) { (response) in
            guard let countries = response.value else {
                return
            }
            completion(.success(countries))
        }
    }
    
    
}
