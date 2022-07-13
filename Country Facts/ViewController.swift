//
//  ViewController.swift
//  Country Facts
//
//  Created by Camilo Hernández Guerrero on 12/07/22.
//

import UIKit

class ViewController: UITableViewController {
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Country facts"
        navigationController?.navigationBar.prefersLargeTitles = true
        performSelector(inBackground: #selector(loadCountries), with: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        configuration.text = countries[indexPath.row].name
        cell.contentConfiguration = configuration
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let factsViewController = storyboard?.instantiateViewController(withIdentifier: "FactsViewController") as? FactsViewController {
            factsViewController.selectedCountry = countries[indexPath.row]
            navigationController?.pushViewController(factsViewController, animated: true)
        }
    }
    
    @objc func loadCountries(){
        if let countriesURL = Bundle.main.url(forResource: "Countries", withExtension: "json") {
            if let countriesData = try? Data(contentsOf: countriesURL) {
                let JSONDecoder = JSONDecoder()
                
                if let countriesJSON = try? JSONDecoder.decode(Countries.self, from: countriesData) {
                    countries = countriesJSON.countries

                }
            }
        }
        
        DispatchQueue.main.async {
            [weak self] in
            self?.tableView.reloadData()
        }
    }
}
