//
//  ImageService.swift
//  TestTask
//
//  Created by Ruslan Khanov on 12.04.2021.
//

import UIKit

protocol ImageService {
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void)
}
