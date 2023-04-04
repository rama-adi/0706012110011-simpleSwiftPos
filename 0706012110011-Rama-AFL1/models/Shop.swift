//
//  ShopAfl1.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 03/03/23.
//

import Foundation

/// The shop class
class Shop: Identifiable {
    var ID: Int
    var name: String
    var products: [Product]
    
    init(ID: Int, name: String, products: [Product]) {
        self.ID = ID
        self.name = name
        self.products = products
    }
}
