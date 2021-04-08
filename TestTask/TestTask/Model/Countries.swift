//
//  Countries.swift
//  TestTask
//
//  Created by Ruslan Khanov on 08.04.2021.
//
import Foundation

struct Countries: Codable {
    var next: URL?
    var countries: [Country]
}
