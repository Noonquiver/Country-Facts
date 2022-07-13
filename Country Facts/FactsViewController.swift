//
//  FactsViewController.swift
//  Country Facts
//
//  Created by Camilo Hernández Guerrero on 12/07/22.
//

import UIKit

class FactsViewController: UIViewController {
    var selectedCountry: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let selectedCountry = selectedCountry else { return }
        title = selectedCountry.name
        
        let capital = UILabel()
        capital.font = UIFont(name: "Times New Roman", size: 18)
        capital.translatesAutoresizingMaskIntoConstraints = false
        capital.text = "Capital: \(selectedCountry.capital)."
        view.addSubview(capital)
        
        let size = UILabel()
        size.font = UIFont(name: "Times New Roman", size: 18)
        size.translatesAutoresizingMaskIntoConstraints = false
        size.text = "Size: \(selectedCountry.size) km\u{00B2}."
        view.addSubview(size)
        
        let population = UILabel()
        population.font = UIFont(name: "Times New Roman", size: 18)
        population.translatesAutoresizingMaskIntoConstraints = false
        population.text = "Population: \(selectedCountry.population) people."
        view.addSubview(population)
        
        let currency = UILabel()
        currency.font = UIFont(name: "Times New Roman", size: 18)
        currency.translatesAutoresizingMaskIntoConstraints = false
        currency.text = "Currency: \(selectedCountry.currency)."
        view.addSubview(currency)
        
        NSLayoutConstraint.activate([
            capital.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            capital.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            size.topAnchor.constraint(equalTo: capital.bottomAnchor, constant: 20),
            size.leadingAnchor.constraint(equalTo: capital.leadingAnchor),
            population.topAnchor.constraint(equalTo: size.bottomAnchor, constant: 20),
            population.leadingAnchor.constraint(equalTo: size.leadingAnchor),
            currency.topAnchor.constraint(equalTo: population.bottomAnchor, constant: 20),
            currency.leadingAnchor.constraint(equalTo: population.leadingAnchor)
        ])
        
        
    }
}
