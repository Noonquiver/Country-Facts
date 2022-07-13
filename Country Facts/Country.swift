//
//  Country.swift
//  Country Facts
//
//  Created by Camilo Hernández Guerrero on 12/07/22.
//

class Country: Codable {
    var name: String
    var capital: String
    var size: String
    var population: String
    var currency: String
    
    init(name: String, capital: String, size: String, population: String, currency: String) {
        self.name = name
        self.capital = capital
        self.size = size
        self.population = population
        self.currency = currency
    }
}
