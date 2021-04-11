//
//  UIImageView+Downloading.swift
//  TestTask
//
//  Created by Ruslan Khanov on 11.04.2021.
//

import Foundation
import UIKit


extension UIImageView {
    func downloadImage(from url: URL) {
        self.image = UIImage(named: "No-Image-Placeholder")
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
