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
    
    // MARK: - Vars & Lets
    
    private var viewModel: DetailCountryViewModel!
    private var sectionData: SectionData?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self

        loadCellData()
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
        }
    }
    
    // MARK: - Private methods
    
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

        return cell ?? UITableViewCell()
    }
    
    private func iconRightDetailTextCell(icon: UIImage, text: String, detailText: String, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconRightDetailTextCell", for: indexPath) as? IconRightDetailTextCell
        cell?.configure(icon: icon, text: text, detailText: detailText)
        return cell ?? UITableViewCell()
    }

}
