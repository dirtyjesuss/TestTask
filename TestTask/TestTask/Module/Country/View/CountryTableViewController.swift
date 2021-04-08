//
//  CountryTableViewController.swift
//  TestTask
//
//  Created by Ruslan Khanov on 07.04.2021.
//

import UIKit

class CountryTableViewController: UITableViewController {
    
    // MARK: - Vars & Lets
    
    private var viewModel: CountryViewModel!
        
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Countries"
        
        viewModel = CountryViewModelImplementation()
        viewModel.delegate = self
        viewModel.getCountries()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryCell
        let item = viewModel.items[indexPath.row]
        cell?.configure(name: item.name, capital: item.capital, flagImage: UIImage(), shortDescription: item.shortDescription)
        return cell ?? UITableViewCell()
    }

}

extension CountryTableViewController: CountryViewModelDelegate {
    func didLoadData() {
        tableView.reloadData()
    }
    
    func didFailLoadData() {
        
    }
    
}
