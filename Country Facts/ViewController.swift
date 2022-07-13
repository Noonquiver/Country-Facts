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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Random fact", style: .plain, target: self, action: #selector(showRandomFact))
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
    
    @objc func showRandomFact(){
        let shuffledCountries = countries.shuffled()
        let randomCountry = shuffledCountries[0]
        let randomFact: String
        
        switch Int.random(in: 1...4) {
        case 1:
            randomFact = "\(randomCountry.name)'s capital is \(randomCountry.capital)."
        case 2:
            randomFact = "\(randomCountry.name)'s area is about \(randomCountry.size) km\u{00B2}."
        case 3:
            randomFact = "About \(randomCountry.population) people live in \(randomCountry.name)."
        default:
            randomFact = "\(randomCountry.name)'s currency is the \(randomCountry.currency)."
        }
        
        let alertController = UIAlertController(title: "Did you know?", message: randomFact, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Interesting!", style: .default))
        present(alertController, animated: true)
    }
}
