//
//  CountryViewModel.swift
//  TestTask
//
//  Created by Ruslan Khanov on 08.04.2021.
//

import UIKit

protocol CountryViewModelDelegate {
    func didLoadData()
    func didImageUpdate(for index: Int)
}

protocol CountryViewModel {
    var items: [Country] { get set }
    var delegate: CountryViewModelDelegate? { get set }
    
    func fetchCountries()
    func refreshViewModel()
}

class CountryViewModelImplementation: CountryViewModel {
        
    var delegate: CountryViewModelDelegate?
    var items: [Country] = []
    
    private var nextPage: String?
    
    private var countryService: CountryService!
    private var imageService: ImageService!
    private var isFetchingInProgress = false
    
    // MARK: - Init
        
    init() {
        countryService = CountryAPIService()
        imageService = SessionImageService()
    }
    
    // MARK: - Public methods
    
    func fetchCountries() {
        guard !isFetchingInProgress else {
            return
        }
        
        if let nextPage = nextPage, nextPage.isEmpty {
            return
        }
        
        isFetchingInProgress = true
        
        countryService.loadCountries(pageURLString: nextPage) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.isFetchingInProgress = false
                    print(error.localizedDescription)
                }
            case .success(let response):
                DispatchQueue.main.async {
                    self?.isFetchingInProgress = false
                    
                    self?.items.append(contentsOf: response.countries)
                    self?.delegate?.didLoadData()
                    
                    let indexPath = self?.calculateIndexPathsToReload(from: response.countries)
                    self?.loadImages(for: indexPath!)

                    self?.nextPage = response.nextURLString
                }
            }
        }
    }
    
    func refreshViewModel() {
        items = []
        nextPage = nil
    }
    
    private func loadImages(for indexPath: [IndexPath]) {
        indexPath.forEach {
            let index = $0.row
            let item = items[index]
            
            item.flagImage = UIImage(named: "No-Image-Placeholder") ?? UIImage()
            
            imageService.downloadImage(from: item.flagImageURL) { [weak self] result in
                switch result {
                case .failure(_):
                    break
                case .success(let image):
                    item.flagImage = image
                    self?.delegate?.didImageUpdate(for: index)
                }
            }
            
            item.imageURLs.forEach { url in
                imageService.downloadImage(from: url) {result in
                    switch result {
                    case .failure(_):
                        break
                    case .success(let image):
                        item.images.append(image)
                    }
                }
            }
        }
    }
    
    private func calculateIndexPathsToReload(from newCountries: [Country]) -> [IndexPath] {
      let startIndex = items.count - newCountries.count
      let endIndex = startIndex + newCountries.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
