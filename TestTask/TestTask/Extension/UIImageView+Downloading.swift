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
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
