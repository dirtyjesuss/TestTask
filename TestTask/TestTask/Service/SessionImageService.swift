//
//  SessionImageService.swift
//  TestTask
//
//  Created by Ruslan Khanov on 12.04.2021.
//

import UIKit

class SessionImageService: ImageService {
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                print("Cannot load image")
                return
            }
            DispatchQueue.main.async() {
                completion(.success(image))
            }
        }.resume()
    }
}
