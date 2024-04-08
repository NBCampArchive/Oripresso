//
//  CoffeeMenu.swift
//  Oripresso
//
//  Created by 박현렬 on 4/3/24.
//

import Foundation
struct CafeMenu: Codable {
    let coffee: Category
    let nonCoffee: Category
    let dessert: Category
    let bread: Category
    
    enum CodingKeys: String, CodingKey {
        case coffee = "Coffee"
        case nonCoffee = "Non-Coffee"
        case dessert = "Dessert"
        case bread = "Bread"
    }
}

struct Category: Codable {
    let menus: [Menu]
}

struct Menu: Codable {
    let image: String
    let name: String
    let price: Int
    let description: String
}
