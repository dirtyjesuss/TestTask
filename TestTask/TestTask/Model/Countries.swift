//
//  Countries.swift
//  TestTask
//
//  Created by Ruslan Khanov on 08.04.2021.
//
import Foundation

struct Countries: Decodable {
    var nextURLString: String
    var countries: [Country]
    
    enum CodingKeys: String, CodingKey {
        case nextURLString = "next"
        case countries
    }
}
