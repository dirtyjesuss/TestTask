//
//  DetailCountryViewController.swift
//  TestTask
//
//  Created by Ruslan Khanov on 07.04.2021.
//

import UIKit

class DetailCountryViewController: UIViewController, UITableViewDataSource, Storyboarded {
    
    // MARK: - Outlets
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var carouselView: UICollectionView!
    @IBOutlet private var pageControl: UIPageControl! {
        didSet {
            pageControl.numberOfPages = viewModel.images.count
        }
    }
    
    // MARK: - Vars & Lets
    
    private var viewModel: DetailCountryViewModel!
    private var sectionData: SectionData?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        carouselView.delegate = self
        carouselView.dataSource = self

        loadCellData()
        configureBar()
    }
    
    // MARK: - Instantiation
    
    static func makeViewController(viewModel: DetailCountryViewModel) -> DetailCountryViewController {
        let viewController = DetailCountryViewController.instantiate()
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cellsData = sectionData?.cells else { return 0 }
        
        return cellsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellsData = sectionData?.cells else { return UITableViewCell() }
        
        switch cellsData[indexPath.row] {
        case .textCell(text: let text, style: let style):
            return textCell(text: text, style: style, at: indexPath)
        case .iconRightDetailTextCell(icon: let icon, text: let text, detailText: let detailText):
            return iconRightDetailTextCell(icon: icon, text: text, detailText: detailText, at: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: - Status bar
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Private methods
    
    private func configureBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.sizeToFit()
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.tintColor = .white
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    private func loadCellData() {
        sectionData = SectionData(cells: [
            .textCell(text: viewModel.name, style: .largeText),
            .iconRightDetailTextCell(icon: UIImage(named: "Star") ?? UIImage(), text: "Capital", detailText: viewModel.capital),
            .iconRightDetailTextCell(icon: UIImage(named: "Face") ?? UIImage(), text: "Population", detailText: "\(viewModel.population)"),
            .iconRightDetailTextCell(icon: UIImage(named: "Earth") ?? UIImage(), text: "Continent", detailText: viewModel.continent),
            .textCell(text: "About", style: .normalText),
            .textCell(text: viewModel.countryDescription, style: .normalText)
        ])
    }
    
    private func textCell(text: String, style: TextCellStyle, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath) as? TextCell
        cell?.configure(text: text, style: style)
        cell?.separatorInset = UIEdgeInsets(top: 0, left: cell?.bounds.size.width ?? 0, bottom: 0, right: 0)
        
        cell?.selectionStyle = .none

        return cell ?? UITableViewCell()
    }
    
    private func iconRightDetailTextCell(icon: UIImage, text: String, detailText: String, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconRightDetailTextCell", for: indexPath) as? IconRightDetailTextCell
        cell?.configure(icon: icon, text: text, detailText: detailText)
        
        cell?.selectionStyle = .none

        return cell ?? UITableViewCell()
    }
    
    // MARK: Page control
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: carouselView.contentOffset, size: carouselView.bounds.size)
        let midPointOfVisibleRect = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = carouselView.indexPathForItem(at: midPointOfVisibleRect) {
                 pageControl.currentPage = visibleIndexPath.row
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension DetailCountryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell
        cell?.imageView.image = viewModel.images[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DetailCountryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: carouselView.bounds.width, height: carouselView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
