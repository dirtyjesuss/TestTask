//
//  CountryTableViewController.swift
//  TestTask
//
//  Created by Ruslan Khanov on 07.04.2021.
//

import UIKit

class CountryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Vars & Lets
    
    private var viewModel: CountryViewModel!
        
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Countries"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        activityIndicator.startAnimating()
                
        viewModel = CountryViewModelImplementation()
        viewModel.delegate = self
        viewModel.fetchCountries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return countryCell(at: indexPath)
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailCountryViewController(with: viewModel.items[indexPath.row])
    }
    
    // MARK: - Scroll view delegate
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableView{

            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                viewModel.fetchCountries()
            }
        }
    }
    
    // MARK: - Private methods
    
    private func countryCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryCell
        let item = viewModel.items[indexPath.row]
        cell?.configure(name: item.name, capital: item.capital, flagImage: UIImage(), shortDescription: item.shortDescription)
        return cell ?? UITableViewCell()
    }
    
    // MARK: - Navigation
    
    private func navigateToDetailCountryViewController(with data: Country) {
        let detailCountryViewModel = DetailCountryViewModelImplementation(data: data)
        let destination = DetailCountryViewController.makeViewController(viewModel: detailCountryViewModel)
        
        navigationController?.pushViewController(destination, animated: true)
    }
}

// MARK: - CountryViewModelDelegate

extension CountryViewController: CountryViewModelDelegate {
    func didLoadData() {
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
}
